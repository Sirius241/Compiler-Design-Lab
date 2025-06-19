%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror();
%}

%%
S:A B
;
A:'a'A'b'
 |
 ;
B:'b'B'c'
 |
 ;
%%

int main()
{
printf("enter input\n");
yyparse();
printf("valid string");
}
int yyerror()
{
printf("invalid string");
exit(0);
}
