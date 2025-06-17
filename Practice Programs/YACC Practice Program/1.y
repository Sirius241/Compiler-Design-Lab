%{
#include <stdio.h>
#include <stdlib.h>

int yylex();                  
int yyerror(const char *s);  
%}

%start S

%%
S: 'a' S 'b'
 | 
 ;
%%

int main() {
    printf("Enter the string:\n");
    yyparse();
    printf("Valid string\n");
    return 0;
}

int yyerror(const char *s) {
    printf("Invalid string\n");
    exit(1);
}
