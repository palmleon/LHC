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

nl = \r|\n|\r\n
ws = [ 1t]
unsint = (0|[1-9][0-9]*) 					//unsigned int
unsrational = {unsint}|{unsint}\.[0-9]+		//unsigned rational
expform = {unsrational}[eE]-?{unsint}
real = {unsrational}|{expform}

%%

"="				{return symbol(sym.EQ);}
"("				{return symbol(sym.RO);}
")"				{return symbol(sym.RC);}
"["				{return symbol(sym.BO);}
"]"				{return symbol(sym.BC);}
","				{return symbol(sym.CM);}
";"				{return symbol(sym.SC);}
"?"				{return symbol(sym.QM);}
"+"				{return symbol(sym.PLUS);}
"-"				{return symbol(sym.MINUS);}
"*"				{return symbol(sym.TIMES);}
"."				{return symbol(sym.DOT);}
"/"				{return symbol(sym.DIV);}
"^"				{return symbol(sym.EXP);}
[a-z]			{return symbol(sym.SCALVAR, yytext());}
[A-Z]			{return symbol(sym.VECTVAR, yytext());}
{real}			{return symbol(sym.REAL, Double.valueOf(yytext()));}

{nl}|{ws}		{;}
.				{System.err.println("Lexical error on: " + yytext());
				 return symbol(sym.error);}
