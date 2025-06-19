%{
#include <stdio.h>
int w = 0, c = 0, l = 0, ws = 0;
%}

%%
[a-zA-Z]+         { w++; c += yyleng; }
[ \t]+            { ws += yyleng; }
\n                { l++; }
.                 { c++; }
%%

int main() {
    printf("Enter a para: \n");
    yylex();

    printf("Words: %d\n", w);
    printf("Lines: %d\n", l);
    printf("Characters: %d\n", c);
    printf("Whitespaces: %d\n", ws);
    return 0;
}

int yywrap() {
    return 1;
}
