%{
#include <stdio.h>
int p = 0, s = 0;
%}

%%
"printf"     { p++; fprintf(yyout, "writef"); }
"scanf"      { s++; fprintf(yyout, "readf"); }
.|\n         { fprintf(yyout, "%s", yytext); }
%%

int main() {
    FILE *in = fopen("test3.c", "r");
    FILE *out = fopen("new_file.c", "w");

    if (!in || !out) {
        perror("File error");
        return 1;
    }

    yyin = in;
    yyout = out;

    yylex();

    fclose(in);
    fclose(out);

    printf("The number of printf's: %d, and scanf's: %d\n", p, s);
    return 0;
}

int yywrap() {
    return 1;
}

/*OUTPUT:
The number of printf's: 2, and scanf's: 1

new_file.c 
#include<stdio.h>
#include<stdlib.h>

int main() {
    writef("Hello world!");
    readf("%d");
    writef("Done");
    return 0;
}
*/