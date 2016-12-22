package Fonte;

/* User Code */
import java.util.*;
import java_cup.runtime.*;
import java.io.*; 
import Fonte.sym;

%%

/* Options And Expression */

%state chuck
%cupsym sym
%class LuaLexer
%cup
%public
%unicode
%standalone
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

        private Token createToken(String val) {
            Token tk = new Token(val);
            return tk;
        }
%}


/* Line terminator regex */
LineTerminator = \r|\n|\r\n
//InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

/* Comments can be inline or block comments */
regex_inline_comment = -{2}[^\[{2}][^\]{2}]\s*.*
regex_block_comment = -{2}\[((=*)\[(.|\n)*?)\]\2\]
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

{regex_comment} 		{ System.out.printf(" COMMENT"); }

/* tokens */
"do"					{ System.out.printf(" DO"); return new Symbol(sym.DO, createToken(yytext())); } 
"end"					{ System.out.println(" END"); return new Symbol(sym.END, createToken(yytext()) ); }
"while"					{ System.out.printf(" WHILE"); return new Symbol(sym.WHILE, createToken(yytext()) ); }
"repeat"				{ System.out.printf(" REPEAT"); return new Symbol(sym.REPEAT, createToken(yytext()) ); }
"if"					{ System.out.printf(" IF"); return new Symbol(sym.IF, createToken(yytext()) ); }
"then"					{ System.out.printf(" THEN"); return new Symbol(sym.THEN, createToken(yytext()) ); }
"else"					{ System.out.printf(" ELSE"); return new Symbol(sym.ELSE, createToken(yytext()) ); }
"elseif"				{ System.out.printf(" ELSEIF"); return new Symbol(sym.ELSEIF, createToken(yytext()) ); }
"for"                                   { System.out.printf(" FOR"); return new Symbol(sym.FOR, createToken(yytext()) ); }
"in"					{ System.out.printf(" IN"); return new Symbol(sym.IN, createToken(yytext()) ); }
"function"				{ System.out.printf(" FUNCTION"); return new Symbol(sym.FUNCTION, createToken(yytext()) ); }
"local"					{ System.out.printf(" LOCAL"); return new Symbol(sym.LOCAL, createToken(yytext()) ); }
"return"				{ System.out.printf(" RETURN"); return new Symbol(sym.RETURN, createToken(yytext()) ); }
"break"					{ System.out.printf(" BREAK"); return new Symbol(sym.BREAK, createToken(yytext()) ); }
 
"nil"					{ System.out.printf(" NIL"); return new Symbol(sym.NIL, createToken(yytext()) ); }
"false"					{ System.out.printf(" FALSE"); return new Symbol(sym.FALSE, createToken(yytext()) ); }
"true"					{ System.out.printf(" TRUE"); return new Symbol(sym.TRUE, createToken(yytext()) ); }
"..."					{ System.out.printf(" ELLIPSIS"); return new Symbol(sym.ELLIPSIS, createToken(yytext()) ); }
 
":"					{ System.out.printf(" COLON"); return new Symbol(sym.COLON, createToken(yytext()) ); }
";"					{ System.out.printf(" SEMICOLON"); return new Symbol(sym.SEMICOLON, createToken(yytext()) ); }
","					{ System.out.printf(" COMMA"); return new Symbol(sym.COMMA, createToken(yytext()) ); }
"."					{ System.out.printf(" PERIOD"); return new Symbol(sym.PERIOD, createToken(yytext()) ); }
"["					{ System.out.printf(" OPEN_BRACKETS"); return new Symbol(sym.OPEN_BRACKETS, createToken(yytext()) ); }
"]"					{ System.out.printf(" CLOSE_BRACKETS"); return new Symbol(sym.CLOSE_BRACKETS, createToken(yytext()) ); }
"{"					{ System.out.printf(" OPEN_BRACES"); return new Symbol(sym.OPEN_BRACES, createToken(yytext()) ); }
"}"					{ System.out.printf(" CLOSE_BRACES"); return new Symbol(sym.CLOSE_BRACES, createToken(yytext()) ); }
"("					{ System.out.printf(" OPEN_PARENTHESES"); return new Symbol(sym.OPEN_PARENTHESES, createToken(yytext()) ); }
")"					{ System.out.printf(" CLOSE_PARENTHESES"); return new Symbol(sym.CLOSE_PARENTHESES, createToken(yytext()) ); }
 
"="					{ System.out.printf(" SIGN"); return new Symbol(sym.SIGN, createToken(yytext()) ); }
"+"					{ System.out.printf(" PLUS"); return new Symbol(sym.PLUS, createToken(yytext()) ); }
"-"					{ System.out.printf(" MINUS"); return new Symbol(sym.MINUS, createToken(yytext()) ); }
"*"					{ System.out.printf(" TIMES"); return new Symbol(sym.TIMES, createToken(yytext()) ); }
"/"					{ System.out.printf(" DIV"); return new Symbol(sym.DIV, createToken(yytext()) ); }
"^"					{ System.out.printf(" UP_CARET"); return new Symbol(sym.UP_CARET, createToken(yytext()) ); }
"%"					{ System.out.printf(" PERCENT"); return new Symbol(sym.PERCENT, createToken(yytext()) ); }
".."					{ System.out.printf(" TWO_PERIOD"); return new Symbol(sym.TWO_PERIOD, createToken(yytext()) ); }
"<"					{ System.out.printf(" LESS_THAN"); return new Symbol(sym.LESS_THAN, createToken(yytext()) ); }
"<="					{ System.out.printf(" LESS_THAN_EQUAL"); return new Symbol(sym.LESS_THAN_EQUAL, createToken(yytext()) ); }
">"					{ System.out.printf(" GREATHER_THAN"); return new Symbol(sym.GREATHER_THAN, createToken(yytext()) ); }
">="					{ System.out.printf(" GREATHER_THAN_EQUAL"); return new Symbol(sym.GREATHER_THAN_EQUAL, createToken(yytext()) ); }
"=="					{ System.out.printf(" EQUAL"); return new Symbol(sym.EQUAL, createToken(yytext()) ); }
"~="					{ System.out.printf(" DIFFERENT"); return new Symbol(sym.DIFFERENT, createToken(yytext()) ); }
"and"					{ System.out.printf(" AND"); return new Symbol(sym.AND, createToken(yytext()) ); }
"or"					{ System.out.printf(" OR"); return new Symbol(sym.OR, createToken(yytext())); }
 
"not"					{ System.out.printf(" NOT"); return new Symbol(sym.NOT, createToken(yytext()) ); }
"#"					{ System.out.printf(" LENGTH"); return new Symbol(sym.LENGTH, createToken(yytext()) ); }
 
{regex_identifier} 		{ System.out.printf(" IDENTIFIER"); return new Symbol(sym.IDENTIFIER, createToken(yytext()) ); }
{regex_number} 			{ System.out.printf(" NUMBER"); return new Symbol(sym.NUMBER, createToken(yytext()) ); }
{regex_string} 			{ System.out.printf(" STRING"); return new Symbol(sym.STRING, createToken(yytext()) ); }

{LineTerminator}                { /* Syntax Error */ }
{WhiteSpace}                    { /* Syntax Error */ }
.                               { /* Syntax Error */ }