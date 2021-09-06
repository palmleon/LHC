import java_cup.runtime.*;

%%

%class scanner
%unicode
%line
%column
%cup
%state DEDENTSEP // TODO check if it must be excluding

%{
	private Symbol createSymbol(int id) {
		return new Symbol(id, yyline+1, yycolumn+1);
	}
	
	private Symbol createSymbol(int id, Object value) {
		return new Symbol(id, yyline+1, yycolumn+1, value);
	}
	
	private LinkedList<Symbol> tokenQueue = new LinkedList<>;
	
	private Stack<Integer> indentStack = new Stack<>;
	
	private boolean computeDedent = false;
	
	/* Custom scanning method that aims to empty the Token Queue
	 * before trying to find new tokens;
	 * Moreover, it prepares the scanner in case either a Separator
	 * or a Dedent must be scanned
	 * Returns: the next Token for the Parser
	 */
	private Symbol next_token_custom(){
		// if the token Queue is not empty, extract its content
		if (this.tokenQueue.size() > 0) {
			return this.tokenQueue.remove();
		}
		/* if we need to scan either a dedent or a separator,
		 * the scanner is prepared by entering the DEDENT state
		 */
		if (parser.getDedentEnable) {
			yybegin(DEDENTSEP);
		}
		return this.next_token();
	}
	
	/* Method that manages the Token Queue, inserting elements in order
	 * and providing them in a FIFO manner
	 * Args: symbols - the symbols to add to the queue
	 * Returns: the first Token in the Token Queue
	 */
	private Symbol manageToken(Symbol... symbols) {
		int indentColumn, dedentColumn;
		if (parser.getIndentEnable()) {
			indentColumn = yycolumn+1();
			indentStack.push(indentColumn);
			tokenQueue.add(createSymbol(sym.indent));
		}
		// scan either a dedent or a separator
		if (computeDedent) {
			dedentColumn = yycolumn()+1;
			indentColumn = indentStack.peek();
			if (indentColumn == dedentColumn) {
				// the following statement is not outside of the block
				// add only a Separator
				tokenQueue.add(createSymbol(sym.sep));
			}
			else (
				// pop the top element of the indent Stack (i.e. exit the block)
				do {
					indentColumn = indentStack.pop();
					tokenQueue.add(createSymbol(sym.dedent));
					if (!indentStack.empty())
						indentColumn = indentStack.peek();
				} while (indentColumn != dedentColumn && !indentStack.empty());
			}	
			computeDedent = false;
		}
		for (Symbol sym: symbols) {
			tokenQueue.add(createSymbol(sym));
		}
		return this.tokenQueue.remove();
	}
%}

%eofval{
	return this.manageToken(sym.dedent, sym.EOF);
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
 *   it is up to the parser to declare when a statement is complete
 * A Separator (either a semicolon or a newline) is looked for when the Parser
 * needs it; the Parser needs to communicate its state to the Scanner to achieve
 * this behaviour, using two variables: indentEnable, dedentEnable
 */

int = (0|[1-9][0-9]*) 					//unsigned int
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
"|"				{return manageToken(sym.pipe);}
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
main			{return manageToken(sym.main);}
do				{return manageToken(sym.do);}
if				{return manageToken(sym.if);}
then			{return manageToken(sym.then);}
else			{return manageToken(sym.else);}
let				{return manageToken(sym.let);}
<<YYINITIAL> in	{return manageToken(sym.in);}
where			{return manageToken(sym.where);}
print			{return manageToken(sym.print);}
Int				{return manageToken(sym.int_type);}
Double			{return manageToken(sym.double_type);}
Bool			{return manageToken(sym.bool_type);}
Char			{return manageToken(sym.char_type);}
String			{return manageToken(sym.string_type);}
{int}			{return manageToken(sym.int);}
{double}		{return manageToken(sym.double);}
{bool}			{return manageToken(sym.bool);}
{char}			{return manageToken(sym.char);}
{string}		{return manageToken(sym.string);}
{id}			{return manageToken(sym.id);}

<YYINITIAL> {nl}{;}
{ws}			{;}

<DEDENTSEP> {
	";"			//separator found, no dedent to check
				{yybegin(YYINITIAL);
				 return manageToken(sym.sep);}
	{nl}		/* newline found, the scanner is made insensitive to 
				 * other newlines or separators
				 * However, no token has been found at this moment,
				 * it is necessary to call the scanner again and return
				 * the next symbol
				 */
				{yybegin(YYINITIAL);
				 computeDedent = true;
				 return next_token();}
	in			{yybegin(YYINITIAL);
				 return manageToken(sym.dedent, sym.in);}
}

/* Single-line Comment */
"--"~{nl}		{;}

/* Lexical error */
.				{System.err.println("Lexical error on: " + yytext());
				 return this.manageToken(sym.error);}
