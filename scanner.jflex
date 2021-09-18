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
	
	// boolean variable that prepares the lexer for scanning an indent
	// the next time (i.e. after scanning a do, let, where, ...)
	private boolean lookForIndent = true;
	private boolean indentEnable = true;
	private boolean dedentEnable = false;
	private boolean endOfCode = false;
	
	public void report_error(String errorType) {
		System.err.print("ERROR: Lexical error");
		System.err.print("(" + errorType + ")");
		System.err.print(" (line "+yyline+", column "+yycolumn+"): ");
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
		/* if we need to scan either a dedent or a separator,
		 * the scanner is prepared by entering the DEDENT state
		 */
		if (lookForIndent) 
			indentEnable = true;
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
		if (indentEnable) {
			indentColumn = yycolumn+1;
			if (indentStack.size() == 0 || indentColumn > indentStack.peek()) {
				indentStack.push(indentColumn);
				tokenQueue.add(createSymbol(sym.indent));
				System.out.println("Indent added (column " + indentColumn + ")");
			}
			else {
				report_error("Nested block is not indented further in than the enclosing expression");
				tokenQueue.add(createSymbol(sym.error));
			}
			//System.out.println("INDENT DISABLED");
			indentEnable = false;
			dedentEnable = false;
			lookForIndent = false;
		}
		// scan either a dedent or a separator
		else if (dedentEnable && !endOfCode) {
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
			else {
				// pop the top element of the indent Stack (i.e. exit the block)
				do {
					/*System.out.println("Indentcolumn = " + indentColumn + "; Dedentcolumn = " + dedentColumn);
					System.out.println("DEDENT FOUND");*/
					indentColumn = indentStack.pop();
					tokenQueue.add(createSymbol(sym.dedent));
					if (!indentStack.empty())
						indentColumn = indentStack.peek();
				} while (indentColumn != dedentColumn && !indentStack.empty());
			}	
			dedentEnable = false;
		}
		// special dedent management in case of EOF
		else if (endOfCode) {
			while (!indentStack.empty()) {
				indentColumn = indentStack.pop();
				tokenQueue.add(createSymbol(sym.dedent));
			}
		}
		for (int sym: symbols) {
			tokenQueue.add(createSymbol(sym));
		}
		return this.tokenQueue.remove();
	}
%}

%eofval{
	/*System.out.println("EOFfound");
	System.out.println("Current value of dedentEnable: " + dedentEnable);*/
	endOfCode = true;
	return this.manageToken(sym.EOF);
%eofval}

/* About Indent, Dedent
 * Indent: symbol to recognize the starting point of an inner block
 * Dedent: symbol to recognize the end point of an inner block
 * The Grammar must ensure that, for each Indent there is a corresponding Dedent
 * Data structures to deal with indent/dedent:
 * - an Indent Stack, containing all the indents to consider so far;
 *   each entry of the Stack contains the column index related to that
 * 	 indentation level;
 * - a tokenQueue, to allow multiple symbols at a single scan;
 * Concept: when an indent is recognized, it is pushed into the Stack; 
 *          when a dedent is recognized, an indent is popped from the Stack
 * To recognize a Dedent: 
 * - we define a Dedent State, where we compare the column
 *   index of the 1st available token with the index of the top element in
 *   the Stack: if equal, return a separator as we are still in the block; 
 *   if it is not the case, pop and insert a dedent until a matching Indent
 *   is found. If no matching Indent is found: Parsing error
 * - the Dedent State is also used to scan Separators; in particular, the scanner
 *   must decide whether to pass a dedent or a separator, depending on the input pattern
 * To recognize an Indent:
 * - we define an Indent State, where we look for the first available token;
 *   when found, we insert into the Token Queue both an Indent and the token;
 *   the column index of the Indent is the same as for the token
 * The Indent State is accessed if:
 * - some keyword that build an inner block are scanned (let, where, do, main + eq);
 * - it is the beginning of the program,
 * The Dedent State is accessed if:
 * - we have completed a statement and we need to find either a Separator or a Dedent;
 */

int = 0|[1-9][0-9]* 					//unsigned int
rational = {int}\.[0-9]+				//unsigned rational
expform = {rational}[eE]-?{int}
double = {rational}|{expform}
bool = True|False
char = '[a-zA-Z0-9]'
string = \"~\"
id = [a-z_][a-zA-Z0-9_']*
nl = \r|\n|\r\n
ws = [ \t]

%%

"="				{return manageToken(sym.eq);}
":"				{return manageToken(sym.cons);}
"::"			{return manageToken(sym.clns);}
","				{return manageToken(sym.cm);}
//"|"				{return manageToken(sym.pipe);}
"("				{return manageToken(sym.ro);}
")"				{return manageToken(sym.rc);}
"["				{return manageToken(sym.bo);}
"]"				{return manageToken(sym.bc);}
"_"				{return manageToken(sym.us);}
"->"			{return manageToken(sym.arrow);}
"+"				{return manageToken(sym.plus);}
"-"				{return manageToken(sym.minus);}
"*"				{return manageToken(sym.times);}
"/"				{return manageToken(sym.div);}
mod				{return manageToken(sym.mod);}
"^"				{return manageToken(sym.exp);}
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
in				{dedentEnable = false;
				 indentStack.pop();
				 return manageToken(sym.dedent, sym.in);}
main			{return manageToken(sym.main);}
do				{lookForIndent = true;
				 return manageToken(sym.do_begin);}
if				{return manageToken(sym.if_begin);}
then			{dedentEnable = false;
				 return manageToken(sym.then);}
else			{dedentEnable = false;
				 return manageToken(sym.else_begin);}
let				{lookForIndent = true;
				 return manageToken(sym.let);}
/*where			{dedentEnable = false;
				 lookForIndent = true;
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
{nl}			{dedentEnable = true;}

/* Single-line Comment */
"--"~{nl}		{dedentEnable = true;}

/* Lexical error */
.				{report_error("Not recognized token");
				 return this.manageToken(sym.error);}
