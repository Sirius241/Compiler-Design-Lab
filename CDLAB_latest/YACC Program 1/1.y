%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror();

int acount = 0;
int bcount = 0;
int ccount = 0;
%}

%start S

%%
S : A B C '\n' {
      if (bcount >= acount && (acount + ccount) == bcount) {
          printf("Valid string\n");
          exit(0);
      } else {
          yyerror();
      }
    }
  ;
A : 
  | 'a' { acount++; } A
  ;
B : 
  | 'b' { bcount++; } B
  ;
C : 
  | 'c' { ccount++; } C
  ;
%%

int main() {
    printf("Enter the input:\n");
    yyparse();
    return 0;
}

int yyerror() {
    printf("Invalid string\n");
    exit(1);
    return 1;
}
