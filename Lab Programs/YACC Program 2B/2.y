%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror();
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%
S : I '\n'     { printf("Valid expression!\n"); printf("Result is %d\n", $1); exit(0); }
  ;
I : I '+' I    { $$ = $1 + $3; }
  | I '-' I    { $$ = $1 - $3; }
  | I '*' I    { $$ = $1 * $3; }
  | I '/' I    {
                  if ($3 == 0) {
                      printf("Division by zero!\n");
                      exit(1);
                  } else {
                      $$ = $1 / $3;
                  }
               }
  | NUM        { $$ = $1; }
  ;
%%

int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}

int yyerror() {
    printf("Invalid expression\n");
    exit(1);
}
