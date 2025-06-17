%{
#include "3.tab.h"
%}

%%
[\t\n\r ]+                  ; // skip whitespace
"int"|"float"|"char"|"void" { return TYPE; }
[a-zA-Z_][a-zA-Z0-9_]*      { return IDEN; }
[0-9]+                      { return NUM; }
"++"                        { return '+' + 256; }
"--"                        { return '-' + 256; }
"="                         { return '='; }
"+"                         { return '+'; }
"-"                         { return '-'; }
"*"                         { return '*'; }
"/"                         { return '/'; }
"("                         { return '('; }
")"                         { return ')'; }
"{"                         { return '{'; }
"}"                         { return '}'; }
";"                         { return ';'; }
","                         { return ','; }
.                           { return yytext[0]; }
%%

int yywrap() { 
    return 1; 
}

/* OUTPUT 1:
int add(int a, int b) {
    int result;
    result = a + b;
}
Function format Accepted!

OUTPUT 2:
int add(int a, int b) {
    int result;
    result = a + b;
ERROR!
*/