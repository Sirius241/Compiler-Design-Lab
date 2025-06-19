%{
#include<stdio.h>
int posint=0,negint=0,negf=0,posf=0,invalid=0;
%}

%%
[\t\n]+ ;
"-"[0-9]+"."[0-9]+ {negf++;}
"-"[0-9]+"/"[0-9]+ {negf++;}
[0-9]+"/""-"[0-9]+ {negf++;}
[0-9]+"."[0-9]+ {posf++;}
"-"[0-9]+"/""-"[0-9]+ {posf++;}
[0-9]+"/"[0-9]+ {posf++;}
[0-9]+ {posint++;}
"-"[0-9]+ {negint++;}
"\."[0-9]+ {posf++;}
[^\t\n]+ {invalid++;}
%%

int main()
{
printf("Enter a set of numbers:\n");
    yylex();
    printf("Positive Integers: %d\n", posint);
    printf("Negative Integers: %d\n", negint);
    printf("Positive Fractions: %d\n", posf);
    printf("Negative Fractions: %d\n", negf);
    printf("Invalid Numbers: %d\n", invalid);
    return 0;
}

int yywrap() {
    return 1;
}

