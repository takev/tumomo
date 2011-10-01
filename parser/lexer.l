
%{
#include <yyast/yyast.h>
#include "parser.h"
%}

L           [a-zA-Z_]
LD          [a-zA-Z0-9_]
B           [01]
O           [0-7]
D           [0-9]
H           [a-fA-F0-9]
E           [Ee][+-]?{D}+
P           [Pp][+-]?{D}+
WS          [ \t\v\n\f\r]

%option noyywrap
%x COMMENT
%x ASSEMBLY
%%

"++"                                    { return T_INCREMENT; }
"--"                                    { return T_DECREMENT; }

":="                                    { return T_INPLACE_COPY; }
"**="                                   { return T_INPLACE_POW; }
"//="                                   { return T_INPLACE_DIV_FLOOR; }
"%%="                                   { return T_INPLACE_MOD_FLOOR; }
"<<="                                   { return T_INPLACE_SHL; }
">>="                                   { return T_INPLACE_SHR; }
"+="                                    { return T_INPLACE_ADD; }
"-="                                    { return T_INPLACE_SUB; }
"*="                                    { return T_INPLACE_MUL; }
"/="                                    { return T_INPLACE_DIV; }
"%="                                    { return T_INPLACE_MOD; }
"&="                                    { return T_INPLACE_AND; }
"|="                                    { return T_INPLACE_OR; }
"^="                                    { return T_INPLACE_XOR; }

"**"                                    { return T_POW; }
"//"                                    { return T_DIV_FLOOR; }
"%%"                                    { return T_MOD_FLOOR; }
">>"                                    { return T_SHR; }
"<<"                                    { return T_SHL; }
"=="                                    { return T_EQ; }
"!="                                    { return T_NE; }
"<="                                    { return T_LE; }
">="                                    { return T_GE; }
"and"                                   { return T_LOGICAL_AND; }
"or"                                    { return T_LOGICAL_OR; }
"xor"                                   { return T_LOGICAL_XOR; }
"not"                                   { return T_LOGICAL_NOT; }
"in"                                    { return T_IN; }
"is"                                    { return T_IS; }
"isa"                                   { return T_ISA; }

"if"                                    { return T_IF; }
"else"                                  { return T_ELSE; }
"elif"                                  { return T_ELSE_IF; }
"case"                                  { return T_CASE; }
"while"                                 { return T_WHILE; }
"do"                                    { return T_DO; }
"for"                                   { return T_FOR; }
"break"                                 { return T_BREAK; }
"continue"                              { return T_CONTINUE; }
"return"                                { return T_RETURN; }
"raise"                                 { return T_RAISE; }
"except"                                { return T_EXCEPT; }
"finally"                               { return T_FINALLY; }
"def"                                   { return T_DEF; }
"class"                                 { return T_CLASS; }
"import"                                { return T_IMPORT; }
"as"                                    { return T_AS; }
"lambda"                                { return T_LAMBDA; }
"thread-safe"                           { return T_THREAD_SAFE; }
"read-only"                             { return T_READ_ONLY; }

[][+*/%&|^.=,:;(){}?-]                  { return yytext[0]; }

"True"                                  { return T_TRUE; }
"False"                                 { return T_FALSE; }
"None"                                  { return T_NONE; }

[-+]?[1-9]{D}*                          |
[-+]?0{O}*                              |
[-+]?0[oO]{O}+                          |
[-+]?0[dD]{D}+                          |
[-+]?0[xX]{H}+                          |
[-+]?0[bB]{B}+                          { yylval = ya_int(yytext, yyleng); return T_INTEGER; }

[-+]INFINITY                            |
[-+]NAN                                 |
[-+]?{D}+{E}?                           |
[-+]?{D}*"."{D}+{E}?                    |
[-+]?{D}+"."{D}*{E}?                    |
[-+]?0[xX]{H}+{P}?                      |
[-+]?0[xX]{H}*"."{D}+{P}?               |
[-+]?0[xX]{H}+"."{D}*{P}?               { yylval = ya_real(yytext, yyleng); return T_REAL; }

\"(\\.|[^\"])*\"                        { yylval = ya_string(&yytext[1], yyleng - 2); return T_STRING; }
r\"(\\.|[^\"])*\"                       { yylval = ya_raw_string(&yytext[2], yyleng - 3); return T_STRING; }
"/"(\\.|[^/])*"/"                       { yylval = ya_regex(&yytext[1], yyleng - 2); return T_REGEX; }

{L}{LD}*                                { yylval = ya_name(yytext, yyleng); return T_NAME; }

"//"[^\n]                               ;

"{{{"                                   { yymore(); BEGIN(ASSEMBLY); }
<ASSEMBLY>.                             { yymore(); }
<ASSEMBLY>"}}}"                         { BEGIN(INITIAL); yylval = ya_assembly(&yytext[3], yyleng - 6); return T_ASSEMBLY; }

"/*"                                    { yymore(); BEGIN(COMMENT); }
<COMMENT>.                              { yymore(); }
<COMMENT>"*/"                           { BEGIN(INITIAL); }

{WS}                                    ;

.                                       { return T_UNKNOWN; }


%%

