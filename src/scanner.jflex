import java_cup.runtime.*;
import java.util.LinkedList;
import java.util.Stack;
import java.io.IOException;

%%

%class Scanner
%unicode
%line
%column
%cup

%{
	
	private Symbol createSymbol(int id) {
		return new Symbol(id, yyline+1, yycolumn+1);
	}
	
	private Symbol createSymbol(int id, Object value) {
		return new Symbol(id, yyline+1, yycolumn+1, value);
	}
	
	private LinkedList<Symbol> tokenQueue = new LinkedList<>();
	
	private Stack<Integer> indentStack = new Stack<>();
	
	/* Flags that prepares the lexer for scanning an Indent or a Dedent:
	 * scanIndent is raised if an indent must be immediately scanned
	 * indentEnable is raised if a block based on indentation has been recognized (let, do blocks)
	 * dedentEnable is raised if a block based on indentation has been recognized (let, do blocks);
	 *   if a newline is scanned, the dedentEnable will enable Indentation check
	 * foundNewline is raised if a newline is found; it is coupled with dedentEnable for Indentation check
	 */
	private boolean scanIndent = true;
	private boolean indentEnable = true;
	private boolean dedentForce = false;
	private boolean foundNewline = false;
	private boolean endOfCode = false;
	
	/* Flag for printing debug info */
	private boolean debugMode = true;
	
	public void report_error(String msg) {
		System.err.print("ERROR: Lexical error");
		System.err.print(" (line " + (yyline+1) + ", column " + (yycolumn+1) + "): " + msg);
		System.err.println(" (Token \"" + yytext() + "\")");
	}
	
	/* Custom scanning method that aims to empty the Token Queue
	 * before trying to find new tokens;
	 * Moreover, it prepares the scanner in case either a Separator
	 * or a Dedent must be scanned
	 * Returns: the next Token for the Parser
	 */
	public Symbol next_token_custom() throws IOException{
		// if the token Queue is not empty, extract its content
		//System.out.println("Scanning a token");
		//System.out.println("Current TokenQueue size: " + tokenQueue.size());
		if (this.tokenQueue.size() > 0) {
			return this.tokenQueue.remove();
		}
		if (indentEnable) {
			indentEnable = false;
			scanIndent = true;
		}
		return this.next_token();
	}
	
	/* Method that manages the Token Queue, inserting elements in order
	 * and providing them in a FIFO manner
	 * Args: symbols - the symbols to add to the queue
	 * Returns: the first Token in the Token Queue
	 */
	private Symbol manageToken(Symbol... symbols) {
		Integer indentColumn, dedentColumn, indentColumnTopLevel;
		if (scanIndent && !endOfCode) {
			indentColumn = yycolumn+1;
			if (indentStack.size() == 0 || indentColumn > indentStack.peek()) {
				indentStack.push(indentColumn);
				if (debugMode) System.out.println("SCANNER DEBUG: indent at " + indentColumn);
				tokenQueue.add(createSymbol(sym.indent));
				//System.out.println("Indent added (column " + indentColumn + ")");
			}
			else {
				report_error("Nested block is not indented further in than the enclosing expression");
				tokenQueue.add(createSymbol(sym.error));
			}
			scanIndent = false;
			foundNewline = false;
		}
		// scan either a Dedent or a Separator
		if (!endOfCode && !indentStack.empty() && (foundNewline || dedentForce)) {
			indentColumn = indentStack.peek();			
			if (!foundNewline && dedentForce) {
				dedentColumn = indentColumn-1;
			}
			else {
				dedentColumn = yycolumn+1;
			}
			if (indentColumn.equals(dedentColumn) && foundNewline) {
				// the following statement is not outside of the block : add only a Separator
				tokenQueue.add(createSymbol(sym.sep));
			}
			// if the next token is on the left wrt the current Indentation Level, insert Dedents
			else if (indentColumn > dedentColumn && !indentStack.empty()) {
				// pop the top element of the indent Stack (i.e. exit the block)
				do {
					indentColumn = indentStack.pop();
					if (debugMode) System.out.println("SCANNER DEBUG: dedent at " + indentColumn);
					tokenQueue.add(createSymbol(sym.dedent));
					if (!indentStack.empty())
						indentColumn = indentStack.peek();
				} while (indentColumn > dedentColumn && !indentStack.empty());
			}	
			dedentForce = false;
		}
		// special dedent management in case of EOF
		if (endOfCode) {
			while (!indentStack.empty()) {
				indentColumn = indentStack.pop();
				if (debugMode) System.out.println("SCANNER DEBUG: dedent at " + indentColumn);
				tokenQueue.add(createSymbol(sym.dedent));
			}
		}
		for (Symbol sym: symbols) {
			tokenQueue.add(sym);
		}
		
		foundNewline = false;
		return this.tokenQueue.remove();
	}
%}

%eofval{
	//System.out.println("EOFfound");
	//System.out.println("Current value of dedentEnable: " + dedentEnable);
	endOfCode = true;
	return this.manageToken(createSymbol(sym.EOF));
%eofval}

/* Indentation-based Parsing
 * Indent: symbol to recognize the starting point of an inner block
 * Dedent: symbol to recognize the end point of an inner block
 * The Grammar must ensure that, for each Indent there is a corresponding Dedent
 * Data structures to deal with Indent/Dedent:
 * - an Indent Stack, containing all the indents to consider so far;
 *   each entry of the Stack contains the column index related to that
 * 	 indentation level;
 * - a tokenQueue, to allow multiple symbols at a single scan;
 * Concept: when a block requiring implicit indentation is recognized, i.e. its keyword is scanned
 *			 (let, do), the next Token will define the indentation column and an Indent 
 *			 will be scanned and saved into the Stack; 
 *			If we are inside a special block (let, do):
 *          if a newline is met and the following line is aligned to the left with respect to 
 *			the current indentation level, then a Dedent is scanned and the block is automatically closed
 *			if the next line is aligned as the previous one, then a separator is scanned
 *			if the next line is aligned to the right with respect to the current indentation level,
 *			then no dedent nor separator is scanned
 */

int = 0|[1-9][0-9]* 					//unsigned int
rational = {int}\.[0-9]+				//unsigned rational
expform = {rational}[eE]-?{int}
double = {rational}|{expform}
bool = True|False
char = \'.\'
string = \"~\"
id = [a-z][a-zA-Z0-9_\']*
nl = \r|\n|\r\n
ws = [ \t]

%%

"="				{return manageToken(createSymbol(sym.eq));}
//":"				{return manageToken(sym.cons);}

"::"			{return manageToken(createSymbol(sym.clns));}
","				{return manageToken(createSymbol(sym.cm));}
//"|"			{return manageToken(sym.pipe);}
"("				{return manageToken(createSymbol(sym.ro));}
")"				{return manageToken(createSymbol(sym.rc));}
"["				{return manageToken(createSymbol(sym.bo));}
"]"				{return manageToken(createSymbol(sym.bc));}
//"_"			{return manageToken(sym.us);}
"->"			{return manageToken(createSymbol(sym.arrow));}
"+"				{return manageToken(createSymbol(sym.plus));}
"-"				{return manageToken(createSymbol(sym.minus));}
"*"				{return manageToken(createSymbol(sym.times));}
"/"				{return manageToken(createSymbol(sym.div));}
div				{return manageToken(createSymbol(sym.intdiv));}
mod				{return manageToken(createSymbol(sym.mod));}
"&&"			{return manageToken(createSymbol(sym.and));}
"||"			{return manageToken(createSymbol(sym.or));}
not				{return manageToken(createSymbol(sym.not));}
"/="			{return manageToken(createSymbol(sym.relnoteq));}
"=="			{return manageToken(createSymbol(sym.releq));}
">="			{return manageToken(createSymbol(sym.relge));}
">"				{return manageToken(createSymbol(sym.relgt));}
"<="			{return manageToken(createSymbol(sym.relle));}
"<"				{return manageToken(createSymbol(sym.rellt));}
//"++"			{return manageToken(sym.conc);}
";"				{return manageToken(createSymbol(sym.sep));}
in				{dedentForce = true;
				 return manageToken(createSymbol(sym.in));}
main			{return manageToken(createSymbol(sym.main));}
do				{indentEnable = true;
				 return manageToken(createSymbol(sym.do_begin));}
//head			{return manageToken(sym.head);}
//tail			{return manageToken(sym.tail);}
elem			{return manageToken(createSymbol(sym.elem));}
"!!"			{return manageToken(createSymbol(sym.index));}
if				{return manageToken(createSymbol(sym.if_begin));}
then			{return manageToken(createSymbol(sym.then));}
else			{return manageToken(createSymbol(sym.else_begin));}
let				{indentEnable = true;
				 return manageToken(createSymbol(sym.let));}
/*where			{dedentEnable = false;
				 indentEnableNextToken = true;
				 return manageToken(sym.where);}*/
print			{return manageToken(createSymbol(sym.print));}
Int				{return manageToken(createSymbol(sym.type_int));}
Double			{return manageToken(createSymbol(sym.type_double));}
Bool			{return manageToken(createSymbol(sym.type_bool));}
Char			{return manageToken(createSymbol(sym.type_char));}
String			{return manageToken(createSymbol(sym.type_string));}
{int}			{return manageToken(createSymbol(sym.val_int, 	 Integer.valueOf(yytext())));}
{double}		{return manageToken(createSymbol(sym.val_double, Double.valueOf(yytext())));}
{bool}			{return manageToken(createSymbol(sym.val_bool, 	 Boolean.valueOf(yytext())));}
{char}			{return manageToken(createSymbol(sym.val_char));}
{string}		{return manageToken(createSymbol(sym.val_string, yytext()));}
{id}			{return manageToken(createSymbol(sym.id, 		 yytext().replace('\'', '.')));}
{ws}			{;}
{nl}			{foundNewline = true;}

/* Single-line Comment */
"--" ~ {nl}		{foundNewline = true;}


/* Lexical error */
.				{report_error("Not recognized token");
				 return this.manageToken(createSymbol(sym.error));}
