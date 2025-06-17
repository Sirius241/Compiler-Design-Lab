%{
#include "4.tab.h"
#include "string.h"
%}

%%
[_a-zA-Z][_a-zA-Z0-9]*	{yylval.exp=strdup(yytext);return IDEN;}
[0-9]+	{yylval.exp=strdup(yytext);return NUM;}
[\n] {return '\n';}
. {return yytext[0];}
%%

int yywrap() { 
    return 1; 
}


/*
OUTPUT 1:
Enter the expression
a=b+c
--- Three Address Code(TAC) ---
t0 = b + c
a = t0    
--- Quadruple Representation ---
0: + b c t0
1: = t0   a
--- Triples Representation ---
0: + b c
1: = t0

OUTPUT 2:
Enter the expression
a=b+c*d
--- Three Address Code(TAC) ---
t0 = c * d
t1 = b + t0
a = t1    
--- Quadruple Representation ---
0: * c d t0
1: + b t0 t1
2: = t1   a
--- Triples Representation ---
0: * c d
1: + b t0
2: = t1

OUTPUT 3:
Enter the expression: 
x=a/b-c*d+e
--- Three Address Code(TAC) ---
t0 = a / b
t1 = c * d
t2 = t0 - t1
t3 = t2 + e
x = t3    
--- Quadruple Representation ---
0: / a b t0
1: * c d t1
2: - t0 t1 t2
3: + t2 e t3
4: = t3   x
--- Triples Representation ---
0: / a b
1: * c d
2: - t0 t1
3: + t2 e
4: = t3
*/