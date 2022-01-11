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
	
	/* All scanned tokens pass through a tokenQueue, which allows to store multiple symbols at a single scan; */
	private LinkedList<Symbol> tokenQueue = new LinkedList<>();
	
	/* Data structure to implement Indentation-based Parsing:
     * the an Indent Stack contains all the current open indents, i.e. the nested block which have not been closed yet;
	 *   each entry of the Stack contains the column index related to that indentation level;
	 */
	private Stack<Integer> indentStack = new Stack<>();
	
	/* Flags that prepares the lexer for scanning an Indent or a Dedent:
	 * scanIndent is raised if an indent must be immediately scanned
	 * indentEnable is raised if a block based on indentation has been recognized (let, do blocks)
	 * dedentForce is raised when a dedent must be scanned (right before an "in" token)
	 * foundNewline is raised if a newline is found; it is coupled with dedentEnable for Indentation check
	 * endOfCode is raised when EOF is found
	 */
	private boolean scanIndent = true;
	private boolean indentEnable = true;
	private boolean dedentForce = false;
	private boolean foundNewline = false;
	private boolean endOfCode = false;
	
	/* Flag for printing debug info */
	private final boolean debugMode = false;
	
	/* 
	 *  Inform the user that a Lexical Error has been raised, and inform them about its nature
	 *	@param: String msg - The additional message describing the kind of Syntax Error
	 *	@return: nothing
	 */
	public void report_error(String msg) {
		System.err.print("ERROR: Lexical error");
		System.err.print(" (line " + (yyline+1) + ", column " + (yycolumn+1) + "): " + msg);
		System.err.println(" (Token \"" + yytext() + "\")");
	}
	
	/* Custom scanning method that aims to empty the Token Queue
	 * before trying to find new tokens;
	 * Moreover, it prepares the scanner in case either a Separator
	 * or a Dedent must be scanned
	 * @param: nothing
	 * @return: the next Token for the Parser
	 */
	public Symbol next_token_custom() throws IOException{
		// if the token Queue is not empty, extract its content
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
	 * @param: symbols - the symbols to add to the queue
	 * @return: the first Token in the Token Queue
	 */
	private Symbol manageToken(Symbol... symbols) {
		Integer indentColumn, dedentColumn;
		// scan an Indent
		if (!endOfCode && scanIndent) {
			indentColumn = yycolumn+1;
			if (indentStack.size() == 0 || indentColumn > indentStack.peek()) {
				indentStack.push(indentColumn);
				if (debugMode) System.out.println("SCANNER DEBUG: indent at " + indentColumn);
				tokenQueue.add(createSymbol(sym.indent));
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
			dedentColumn = yycolumn + 1;
			boolean thereIsDedentToInsert = true;
			while (thereIsDedentToInsert && !indentStack.empty()) {
				indentColumn = indentStack.peek(); 					// take the column of the innermost block
				if (indentColumn > dedentColumn || dedentForce) { 	// check if we are out of the innermost block
					dedentForce = false;
					indentStack.pop();
					if (debugMode) System.out.println("SCANNER DEBUG: dedent at " + indentColumn);
					tokenQueue.add(createSymbol(sym.dedent));
				}
				else {
					thereIsDedentToInsert = false;
					if (indentColumn.equals(dedentColumn)) {
						// the following statement is not outside of the block : add only a Separator
						tokenQueue.add(createSymbol(sym.sep));
					}
				}
			}
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
	endOfCode = true;
	return manageToken(createSymbol(sym.EOF));
%eofval}

/* Indentation-based Parsing
 * Indent: symbol to recognize the starting point of an inner block
 * Dedent: symbol to recognize the end point of an inner block
 * The Grammar must ensure that for each Indent there is a corresponding Dedent
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
"::"			{return manageToken(createSymbol(sym.clns));}
","				{return manageToken(createSymbol(sym.cm));}
"("				{return manageToken(createSymbol(sym.ro));}
")"				{return manageToken(createSymbol(sym.rc));}
"["				{return manageToken(createSymbol(sym.bo));}
"]"				{return manageToken(createSymbol(sym.bc));}
"->"			{return manageToken(createSymbol(sym.arrow));}
"+"				{return manageToken(createSymbol(sym.plus));}
"-"				{return manageToken(createSymbol(sym.minus));}
"*"				{return manageToken(createSymbol(sym.times));}
"/"				{return manageToken(createSymbol(sym.div));}
div				{return manageToken(createSymbol(sym.intdiv));}
rem				{return manageToken(createSymbol(sym.rem));}
"&&"			{return manageToken(createSymbol(sym.and));}
"||"			{return manageToken(createSymbol(sym.or));}
not				{return manageToken(createSymbol(sym.not));}
"/="			{return manageToken(createSymbol(sym.relnoteq));}
"=="			{return manageToken(createSymbol(sym.releq));}
">="			{return manageToken(createSymbol(sym.relge));}
">"				{return manageToken(createSymbol(sym.relgt));}
"<="			{return manageToken(createSymbol(sym.relle));}
"<"				{return manageToken(createSymbol(sym.rellt));}
";"				{return manageToken(createSymbol(sym.sep));}
in				{dedentForce = true;
				 return manageToken(createSymbol(sym.in));}
main			{return manageToken(createSymbol(sym.main));}
do				{indentEnable = true;
				 return manageToken(createSymbol(sym.do_begin));}
"!!"			{return manageToken(createSymbol(sym.index));}
if				{return manageToken(createSymbol(sym.if_begin));}
then			{return manageToken(createSymbol(sym.then));}
else			{return manageToken(createSymbol(sym.else_begin));}
let				{indentEnable = true;
				 return manageToken(createSymbol(sym.let));}
print			{return manageToken(createSymbol(sym.print));}
Int				{return manageToken(createSymbol(sym.type_int));}
Double			{return manageToken(createSymbol(sym.type_double));}
Bool			{return manageToken(createSymbol(sym.type_bool));}
Char			{return manageToken(createSymbol(sym.type_char));}
String			{return manageToken(createSymbol(sym.type_string));}
{int}			{return manageToken(createSymbol(sym.val_int, 	 Integer.valueOf(yytext())));}
{double}		{return manageToken(createSymbol(sym.val_double, Double.valueOf(yytext())));}
{bool}			{return manageToken(createSymbol(sym.val_bool, 	 Boolean.valueOf(yytext())));}
{char}			{return manageToken(createSymbol(sym.val_char, 	 yytext().charAt(1)));}
{string}		{return manageToken(createSymbol(sym.val_string, yytext().substring(1, yytext().length()-1)));}
//LLVM does not support the single quote as a valid character for identifiers, while dots are: for this reason, every single tick is replaced with a dot
{id}			{return manageToken(createSymbol(sym.id, 		 yytext().replace('\'', '.')));} 
{ws}			{;}
{nl}			{foundNewline = true;}

/* Single-line Comment */
"--" ~ {nl}		{foundNewline = true;}


/* Lexical error */
.				{report_error("Not recognized token");
				 return this.manageToken(createSymbol(sym.error));}
