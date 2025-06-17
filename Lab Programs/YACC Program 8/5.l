%{
#include "5.tab.h"
#include "string.h"
%}

%%
[_a-zA-Z][_a-zA-Z0-9]*	{yylval.exp=strdup(yytext);return IDEN;}
[0-9]+	                {yylval.exp=strdup(yytext);return NUM;}
[\n]                    {return '\n';}
.                       {return yytext[0];}
%%

int yywrap() { 
    return 1; 
}

/*
OUTPUT 1:
Enter the expression: 
c=a+b
Target Code is: 
LOAD     R1, a
LOAD     R2, b
ADD      R3, R1, R2
STORE    t0, R3
LOAD     R1,t0
STORE    R1,c

OUTPUT 2:
Enter the expression: 
x=a*b/c-e
Target Code is: 
LOAD     R1, a
LOAD     R2, b
MUL      R3, R1, R2
STORE    t0, R3
LOAD     R1, t0
LOAD     R2, c
DIV      R3, R1, R2
STORE    t1, R3
LOAD     R1, t1
LOAD     R2, e
SUB      R3, R1, R2
STORE    t2, R3
LOAD     R1,t2
STORE    R1,x

OUTPUT 3:
Enter the expression: 
c=a+b
a=45
b=25
Target Code is: 
LOAD     R1, a
LOAD     R2, b
ADD      R3, R1, R2
STORE    t0, R3
LOAD     R1,t0
STORE    R1,cLOAD        R1,45
STORE    R1,aLOAD        R1,25
STORE    R1,b
*/