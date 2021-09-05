import java_cup.runtime.*;

%%

%class scanner
%unicode
%line
%column
%cup

%{
	private Symbol symbol(int id) {
		return new Symbol(id, yyline+1, yycolumn+1);
	}
	
	private Symbol symbol(int id, Object value) {
		return new Symbol(id, yyline+1, yycolumn+1, value);
	}
%}

%eofval{
  return symbol(sym.EOF);
%eofval}

//indent, dedent;
int = (0|[1-9][0-9]*) 					//unsigned int
rational = {int}\.[0-9]+				//unsigned rational
expform = {rational}[eE]-?{int}
double = {rational}|{expform}
bool = True|False
char = [a-zA-Z0-9]
id = [a-z_][a-zA-Z0-9_']*
nl = \r|\n|\r\n
ws = [ \t]

%%

main			{return symbol(sym.main);}
"="				{return symbol(sym.eq);}
":"				{return symbol(sym.cons);}
"::"			{return symbol(sym.clns);}
","				{return symbol(sym.cm);}
"|"				{return symbol(sym.pipe);}
"("				{return symbol(sym.ro);}
")"				{return symbol(sym.rc);}
"["				{return symbol(sym.bo);}
"]"				{return symbol(sym.bc);}
"_"				{return symbol(sym.us);}
"->"			{return symbol(sym.arrow);}
"+"				{return symbol(sym.plus);}
"-"				{return symbol(sym.minus);}
"*"				{return symbol(sym.times);}
"/"				{return symbol(sym.div);}
mod				{return symbol(sym.mod);}
"^"				{return symbol(sym.exp);}
"&&"			{return symbol(sym.and);}
"||"			{return symbol(sym.or);}
not				{return symbol(sym.not);}
"=="			{return symbol(sym.releq);}
">="			{return symbol(sym.relge);}
">"				{return symbol(sym.relgt);}
"<="			{return symbol(sym.relle);}
"<"				{return symbol(sym.rellt);}
"++"			{return symbol(sym.conc);}
do				{return symbol(sym.do);}
if				{return symbol(sym.if);}
then			{return symbol(sym.then);}
else			{return symbol(sym.else);}
let				{return symbol(sym.let);}
in				{return symbol(sym.in);}
where			{return symbol(sym.where);}
print			{return symbol(sym.print);}
Int				{return symbol(sym.int_type);}
Double			{return symbol(sym.double_type);}
Bool			{return symbol(sym.bool_type);}
Char			{return symbol(sym.char_type);}
{int}			{return symbol(sym.int);}
{double}		{return symbol(sym.double);}
{bool}			{return symbol(sym.bool);}
{char}			{return symbol(sym.char);}
{id}			{return symbol(sym.id);}

";"				{return symbol(sym.sep);}
{nl}			{return symbol(sym.sep);}

{ws}			{;}

.				{System.err.println("Lexical error on: " + yytext());
				 return symbol(sym.error);}
