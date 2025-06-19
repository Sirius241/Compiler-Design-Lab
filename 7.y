%{
#include <stdio.h>
#include <stdlib.h>
int yyerror();
int yylex();
%}

%token TYPE IDEN NUM
%left '+' '-'
%left '*' '/'
%start S

%%
S: FUN { printf("Function format Accepted!\n"); exit(0); };
FUN: TYPE IDEN '(' PARAMS ')' BODY ;
PARAMS: PARAM ',' PARAMS
      | PARAM
      | 
      ;
PARAM: TYPE IDEN ;
BODY: '{' SS '}'
    | S1 ';' 
    ;
SS: S1 ';' SS
  | 
  ;
S1: DECL
   | ASSGN
   | E
   ;
DECL: TYPE IDEN
     | TYPE ASSGN
     ;
ASSGN: IDEN '=' E ;
E: E '+' E
 | E '-' E
 | E '*' E
 | E '/' E
 | '-' '-' E
 | '+' '+' E
 | E '+' '+' 
 | E '-' '-' 
 | T
 ;
T: NUM
 | IDEN
 ;
%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s <source_file.c>\n", argv[0]);
        exit(1);
    }

    extern FILE *yyin; 
    yyin = fopen(argv[1], "r");

    yyparse();

    fclose(yyin);
    return 0;
}


int yyerror() {
    printf("ERROR!\n");
    exit(1);
}
