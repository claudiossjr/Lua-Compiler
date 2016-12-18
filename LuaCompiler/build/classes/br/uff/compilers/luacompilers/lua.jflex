/* User Code */
import java.util.*;
import java_cup.runtime.*;
%%
/* Ooptions And Expression */
%public
%class LuaLexer
%unicode
%cup
%line
%column

%{
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
  	}	
%}

/* Line terminator regex */
//LineTerminator = \r|\n|\r\n
//InputCharacter = [^\r\n]
//WhiteSpace = {LineTerminator} | [ \t\f]

/* Comments can be inline or block comments */
regex_inline_comment = -{2}[^\[{2}][^\]{2}]\s*.*
regex_block_comment = -{2}\[{2}\s*[^-{2}\]{2}]*-{2}\]{2}
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
"do"					{ System.out.printf(" DO"); return symbol(sym.DO); }
"end"					{ System.out.printf(" END"); return symbol(sym.END); }
"while"					{ System.out.printf(" WHILE"); return symbol(sym.WHILE); }
"repeat"				{ System.out.printf(" REPEAT"); return symbol(sym.REPEAT); }
"if"					{ System.out.printf(" IF"); return symbol(sym.IF); }
"then"					{ System.out.printf(" THEN"); return symbol(sym.THEN); }
"else"					{ System.out.printf(" ELSE"); return symbol(sym.ELSE); }
"elseif"				{ System.out.printf(" ELSEIF"); return symbol(sym.ELSEIF); }
"for"                                   { System.out.printf(" FOR"); return symbol(sym.FOR); }
"in"					{ System.out.printf(" IN"); return symbol(sym.IN); }
"function"				{ System.out.printf(" FUNCTION"); return symbol(sym.FUNCTION); }
"local"					{ System.out.printf(" LOCAL"); return symbol(sym.LOCAL); }
"return"				{ System.out.printf(" RETURN"); return symbol(sym.RETURN); }
"break"					{ System.out.printf(" BREAK"); return symbol(sym.BREAK); }
 
"nil"					{ System.out.printf(" NIL"); return symbol(sym.NIL); }
"false"					{ System.out.printf(" FALSE"); return symbol(sym.FALSE); }
"true"					{ System.out.printf(" TRUE"); return symbol(sym.TRUE); }
"..."					{ System.out.printf(" ELLIPSIS"); return symbol(sym.ELLIPSIS); }
 
":"					{ System.out.printf(" COLON"); return symbol(sym.COLON); }
";"					{ System.out.printf(" SEMICOLON"); return symbol(sym.SEMICOLON); }
","					{ System.out.printf(" COMMA"); return symbol(sym.COMMA); }
"."					{ System.out.printf(" COMMA"); return symbol(sym.PERIOD); }
"["					{ System.out.printf(" OPEN_BRACKETS"); return symbol(sym.OPEN_BRACKETS); }
"]"					{ System.out.printf(" CLOSE_BRACKETS"); return symbol(sym.CLOSE_BRACKETS); }
"{"					{ System.out.printf(" OPEN_BRACES"); return symbol(sym.OPEN_BRACES); }
"}"					{ System.out.printf(" CLOSE_BRACES"); return symbol(sym.CLOSE_BRACES); }
"("					{ System.out.printf(" OPEN_PARENTHESES"); return symbol(sym.OPEN_PARENTHESES); }
")"					{ System.out.printf(" CLOSE_PARENTHESES"); return symbol(sym.CLOSE_PARENTHESES); }
 
"="					{ System.out.printf(" SIGN"); return symbol(sym.SIGN); }
"+"					{ System.out.printf(" PLUS"); return symbol(sym.PLUS); }
"-"					{ System.out.printf(" MINUS"); return symbol(sym.MINUS); }
"*"					{ System.out.printf(" TIMES"); return symbol(sym.TIMES); }
"/"					{ System.out.printf(" DIV"); return symbol(sym.DIV); }
"^"					{ System.out.printf(" UP_CARET"); return symbol(sym.UP_CARET); }
"%"					{ System.out.printf(" PERCENT"); return symbol(sym.PERCENT); }
".."					{ System.out.printf(" TWO_PERIOD"); return symbol(sym.TWO_PERIOD); }
"<"					{ System.out.printf(" LESS_THAN"); return symbol(sym.LESS_THAN); }
"<="					{ System.out.printf(" LESS_THAN_EQUAL"); return symbol(sym.LESS_THAN_EQUAL); }
">"					{ System.out.printf(" GREATHER_THAN"); return symbol(sym.GREATHER_THAN); }
">="					{ System.out.printf(" GREATHER_THAN_EQUAL"); return symbol(sym.GREATHER_THAN_EQUAL); }
"=="					{ System.out.printf(" EQUAL"); return symbol(sym.EQUAL); }
"~="					{ System.out.printf(" DIFFERENT"); return symbol(sym.DIFFERENT); }
"and"					{ System.out.printf(" AND"); return symbol(sym.AND); }
"or"					{ System.out.printf(" OR"); return symbol(sym.OR); }
 
"not"					{ System.out.printf(" NOT"); return symbol(sym.NOT); }
"#"					{ System.out.printf(" LENGTH"); return symbol(sym.LENGTH); }
 
 
 
{regex_comment} 		{ System.out.printf(" COMMENT"); }
{regex_number} 			{ System.out.printf(" NUMBER"); return symbol(sym.NUMBER); }
{regex_string} 			{ System.out.printf(" STRING"); return symbol(sym.STRING); }
{regex_identifier} 		{ System.out.printf(" IDENTIFIER"); return symbol(sym.IDENTIFIER); }

.						{/* Syntax Error */}