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
	private boolean foundNewline = false;
	private boolean endOfCode = false;
	
	/* Flag for printing debug info */
	private boolean debugMode = true;
	
	public void report_error(String errorType) {
		System.err.print("ERROR: Lexical error");
		System.err.print("(" + errorType + ")");
		System.err.print(" (line " + yyline + ", column " + yycolumn + "): ");
		System.err.println("on token" + yytext());
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
	private Symbol manageToken(int... symbols) {
		Integer indentColumn, dedentColumn, indentColumnTopLevel;
		//System.out.println ("Matched text: " + yytext());
		//System.out.println("Current value of indentEnable: " + indentEnable);
		//System.out.println("Current value of dedentEnable: " + dedentEnable);
		if (scanIndent) {
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
			//System.out.println("INDENT DISABLED");
			scanIndent = false;
		}
		// scan either a Dedent or a Separator
		else if (foundNewline && !endOfCode) {
			dedentColumn = yycolumn+1;
			//System.out.println("CURRENT SIZE OF THE INDENT STACK: " + indentStack.size());
			indentColumn = indentStack.peek();
			//System.out.println("Indentcolumn = " + indentColumn + "; Dedentcolumn = " + dedentColumn);
			if (indentColumn.equals(dedentColumn)) {
				// the following statement is not outside of the block
				// add only a Separator
				//System.out.println("SEPARATOR FOUND");
				tokenQueue.add(createSymbol(sym.sep));
			}
			// if the next token is on the left wrt the current Indentation Level, insert Dedents
			else if (indentColumn > dedentColumn) {
				// pop the top element of the indent Stack (i.e. exit the block)
				do {
					/*System.out.println("Indentcolumn = " + indentColumn + "; Dedentcolumn = " + dedentColumn);
					System.out.println("DEDENT FOUND");*/
					indentColumn = indentStack.pop();
					if (debugMode) System.out.println("SCANNER DEBUG: dedent at " + indentColumn);
					tokenQueue.add(createSymbol(sym.dedent));
					if (!indentStack.empty())
						indentColumn = indentStack.peek();
				} while (indentColumn > dedentColumn && !indentStack.empty());
			}	
		}
		// special dedent management in case of EOF
		else if (endOfCode) {
			while (!indentStack.empty()) {
				indentColumn = indentStack.pop();
				if (debugMode) System.out.println("SCANNER DEBUG: dedent at " + indentColumn);
				tokenQueue.add(createSymbol(sym.dedent));
			}
		}
		for (int sym: symbols) {
			tokenQueue.add(createSymbol(sym));
		}
		
		foundNewline = false;
		return this.tokenQueue.remove();
	}
%}

%eofval{
	/*System.out.println("EOFfound");
	System.out.println("Current value of dedentEnable: " + dedentEnable);*/
	endOfCode = true;
	return this.manageToken(sym.EOF);
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
 *          if a newline is met and the following line is not aligned with the current indentation level,
 *			 then a Dedent is scanned and the block is automatically closed
 */

int = 0|[1-9][0-9]* 					//unsigned int
rational = {int}\.[0-9]+				//unsigned rational
expform = {rational}[eE]-?{int}
double = {rational}|{expform}
bool = True|False
char = '[a-zA-Z0-9]'
string = \"~\"
id = [a-z][a-zA-Z0-9_']*
nl = \r|\n|\r\n
ws = [ \t]

%%

"="				{return manageToken(sym.eq);}
":"				{return manageToken(sym.cons);}
"::"			{return manageToken(sym.clns);}
","				{return manageToken(sym.cm);}
//"|"			{return manageToken(sym.pipe);}
"("				{return manageToken(sym.ro);}
")"				{return manageToken(sym.rc);}
"["				{return manageToken(sym.bo);}
"]"				{return manageToken(sym.bc);}
//"_"			{return manageToken(sym.us);}
"->"			{return manageToken(sym.arrow);}
"+"				{return manageToken(sym.plus);}
"-"				{return manageToken(sym.minus);}
"*"				{return manageToken(sym.times);}
"/"				{return manageToken(sym.div);}
div				{return manageToken(sym.intdiv);}
mod				{return manageToken(sym.mod);}
"&&"			{return manageToken(sym.and);}
"||"			{return manageToken(sym.or);}
not				{return manageToken(sym.not);}
"=="			{return manageToken(sym.releq);}
">="			{return manageToken(sym.relge);}
">"				{return manageToken(sym.relgt);}
"<="			{return manageToken(sym.relle);}
"<"				{return manageToken(sym.rellt);}
"++"			{return manageToken(sym.conc);}
";"				{return manageToken(sym.sep);}
in				{return manageToken(sym.in);}
main			{return manageToken(sym.main);}
do				{indentEnable = true;
				 return manageToken(sym.do_begin);}
if				{return manageToken(sym.if_begin);}
then			{return manageToken(sym.then);}
else			{return manageToken(sym.else_begin);}
let				{indentEnable = true;
				 return manageToken(sym.let);}
/*where			{dedentEnable = false;
				 indentEnableNextToken = true;
				 return manageToken(sym.where);}*/
print			{return manageToken(sym.print);}
Int				{return manageToken(sym.type_int);}
Double			{return manageToken(sym.type_double);}
Bool			{return manageToken(sym.type_bool);}
Char			{return manageToken(sym.type_char);}
String			{return manageToken(sym.type_string);}
{int}			{return manageToken(sym.val_int);}
{double}		{return manageToken(sym.val_double);}
{bool}			{return manageToken(sym.val_bool);}
{char}			{return manageToken(sym.val_char);}
{string}		{return manageToken(sym.val_string);}
{id}			{return manageToken(sym.id);}
{ws}			{;}
{nl}			{foundNewline = true;}

/* Single-line Comment */
"--"~{nl}		{foundNewline = true;}

/* Lexical error */
.				{report_error("Not recognized token");
				 return this.manageToken(sym.error);}
