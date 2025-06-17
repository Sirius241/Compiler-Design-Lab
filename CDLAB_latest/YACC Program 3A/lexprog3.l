%{
    #include "lexprog3.tab.h"
%}

%%
"for"               return FOR;
">"|"<"|">="|"<="|"=="|"!="   return OP;
[a-zA-Z_][a-zA-Z0-9_]*         return IDEN;
[0-9]+             return NUM;
[\n\t\r ]+         ;  // Ignore whitespace
"++"|"--"          return INCDEC;
"+"|"-"|"*"|"/"    return ARITH;
"="                return '=';
";"                return ';';
"("                return '(';
")"                return ')';
"{"                return '{';
"}"                return '}';
.                  return yytext[0];
%%

int yywrap() {
    return 1;
}

/*
OUTPUT:
for (i = 0; i < 3; i++) {
    b = 5;
    for (j = 0; j < 2; j++) {
        for (k = 1; k <= 5; k++) {
            a = a + 2;
        }
    }
}

Total FOR loops: 3
Maximum nesting level: 3
*/