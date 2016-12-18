package br.uff.compilers.luacompilers;

/* User Code */
import java.util.*;
import java_cup.runtime.*;
import java.io.*; 
import br.uff.compilers.luacompilers.sym;

%%

/* Options And Expression */

%state chuck
%cupsym sym
%class LuaLexer
%cup
%public
%unicode
%line
%char
%ignorecase

%{
	StringBuffer string = new StringBuffer();

	private Symbol symbol(int type, int yyline, int yycolumn) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, int yyline, int yycolumn, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}


/* Line terminator regex */
LineTerminator = \r|\n|\r\n
//InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* Comments can be inline or block comments */
regex_inline_comment = -{2}[^\[{2}][^\]{2}]\s*.*
regex_block_comment = \[((=*)\[(.|\n)*?)\]\2\]
regex_comment = {regex_inline_comment} | {regex_block_comment}

/* Name can be variable or function name */
regex_identifier = ([a-zA-Z]|\_)(\w|\d|\_)*

/* Type of String */
regex_string = \"([^\\\"]|\\.)*\"

/* Here, we have a big problem, it can be integer or float or a different kind of number expression */
regex_integer = [+-]?\d+
regex_float = [+-]?\d+\.\d+
regex_scientific_notation = [+-]?\d+\.?\d*e[+-]?\d+
regex_number = {regex_integer} | {regex_float} | {regex_scientific_notation}

%%
/* Lexical Rules */

/* tokens */
"do"					{ System.out.printf(" DO"); return symbol(sym.DO, yychar, yyline); }
"end"					{ System.out.printf(" END"); return symbol(sym.END, yychar, yyline ); }
"while"					{ System.out.printf(" WHILE"); return symbol(sym.WHILE, yychar, yyline ); }
"repeat"				{ System.out.printf(" REPEAT"); return symbol(sym.REPEAT, yychar, yyline ); }
"if"					{ System.out.printf(" IF"); return symbol(sym.IF, yychar, yyline ); }
"then"					{ System.out.printf(" THEN"); return symbol(sym.THEN, yychar, yyline ); }
"else"					{ System.out.printf(" ELSE"); return symbol(sym.ELSE, yychar, yyline ); }
"elseif"				{ System.out.printf(" ELSEIF"); return symbol(sym.ELSEIF, yychar, yyline ); }
"for"                                   { System.out.printf(" FOR"); return symbol(sym.FOR, yychar, yyline ); }
"in"					{ System.out.printf(" IN"); return symbol(sym.IN, yychar, yyline ); }
"function"				{ System.out.printf(" FUNCTION"); return symbol(sym.FUNCTION, yychar, yyline ); }
"local"					{ System.out.printf(" LOCAL"); return symbol(sym.LOCAL, yychar, yyline ); }
"return"				{ System.out.printf(" RETURN"); return symbol(sym.RETURN, yychar, yyline ); }
"break"					{ System.out.printf(" BREAK"); return symbol(sym.BREAK, yychar, yyline ); }
 
"nil"					{ System.out.printf(" NIL"); return symbol(sym.NIL, yychar, yyline ); }
"false"					{ System.out.printf(" FALSE"); return symbol(sym.FALSE, yychar, yyline ); }
"true"					{ System.out.printf(" TRUE"); return symbol(sym.TRUE, yychar, yyline ); }
"..."					{ System.out.printf(" ELLIPSIS"); return symbol(sym.ELLIPSIS, yychar, yyline ); }
 
":"					{ System.out.printf(" COLON"); return symbol(sym.COLON, yychar, yyline ); }
";"					{ System.out.printf(" SEMICOLON"); return symbol(sym.SEMICOLON, yychar, yyline ); }
","					{ System.out.printf(" COMMA"); return symbol(sym.COMMA, yychar, yyline ); }
"."					{ System.out.printf(" COMMA"); return symbol(sym.PERIOD, yychar, yyline ); }
"["					{ System.out.printf(" OPEN_BRACKETS"); return symbol(sym.OPEN_BRACKETS, yychar, yyline ); }
"]"					{ System.out.printf(" CLOSE_BRACKETS"); return symbol(sym.CLOSE_BRACKETS, yychar, yyline ); }
"{"					{ System.out.printf(" OPEN_BRACES"); return symbol(sym.OPEN_BRACES, yychar, yyline ); }
"}"					{ System.out.printf(" CLOSE_BRACES"); return symbol(sym.CLOSE_BRACES, yychar, yyline ); }
"("					{ System.out.printf(" OPEN_PARENTHESES"); return symbol(sym.OPEN_PARENTHESES, yychar, yyline ); }
")"					{ System.out.printf(" CLOSE_PARENTHESES"); return symbol(sym.CLOSE_PARENTHESES, yychar, yyline ); }
 
"="					{ System.out.printf(" SIGN"); return symbol(sym.SIGN, yychar, yyline ); }
"+"					{ System.out.printf(" PLUS"); return symbol(sym.PLUS, yychar, yyline ); }
"-"					{ System.out.printf(" MINUS"); return symbol(sym.MINUS, yychar, yyline ); }
"*"					{ System.out.printf(" TIMES"); return symbol(sym.TIMES, yychar, yyline ); }
"/"					{ System.out.printf(" DIV"); return symbol(sym.DIV, yychar, yyline ); }
"^"					{ System.out.printf(" UP_CARET"); return symbol(sym.UP_CARET, yychar, yyline ); }
"%"					{ System.out.printf(" PERCENT"); return symbol(sym.PERCENT, yychar, yyline ); }
".."					{ System.out.printf(" TWO_PERIOD"); return symbol(sym.TWO_PERIOD, yychar, yyline ); }
"<"					{ System.out.printf(" LESS_THAN"); return symbol(sym.LESS_THAN, yychar, yyline ); }
"<="					{ System.out.printf(" LESS_THAN_EQUAL"); return symbol(sym.LESS_THAN_EQUAL, yychar, yyline ); }
">"					{ System.out.printf(" GREATHER_THAN"); return symbol(sym.GREATHER_THAN, yychar, yyline ); }
">="					{ System.out.printf(" GREATHER_THAN_EQUAL"); return symbol(sym.GREATHER_THAN_EQUAL, yychar, yyline ); }
"=="					{ System.out.printf(" EQUAL"); return symbol(sym.EQUAL, yychar, yyline ); }
"~="					{ System.out.printf(" DIFFERENT"); return symbol(sym.DIFFERENT, yychar, yyline ); }
"and"					{ System.out.printf(" AND"); return symbol(sym.AND, yychar, yyline ); }
"or"					{ System.out.printf(" OR"); return symbol(sym.OR, yychar, yyline); }
 
"not"					{ System.out.printf(" NOT"); return symbol(sym.NOT, yychar, yyline ); }
"#"					{ System.out.printf(" LENGTH"); return symbol(sym.LENGTH, yychar, yyline ); }
 
 
 
{regex_comment} 		{ System.out.printf(" COMMENT"); }
{regex_number} 			{ System.out.printf(" NUMBER"); return symbol(sym.NUMBER, yychar, yyline,new String(yytext())); }
{regex_string} 			{ System.out.printf(" STRING"); return symbol(sym.STRING, yychar, yyline,new String(yytext())); }
{regex_identifier} 		{ System.out.printf(" IDENTIFIER"); return symbol(sym.IDENTIFIER, yychar, yyline,new String(yytext())); }
{LineTerminator}                { /* Syntax Error */ }
{WhiteSpace}                    { /* Syntax Error */ }
.                               { /* Syntax Error */ }