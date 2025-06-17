%{
#include <stdio.h>
int posint = 0, negint = 0, posfrac = 0, negfrac = 0, invalid = 0;
%}

%%
[ \t\n]+                                ;
"-"[0-9]+"."[0-9]+                      { negfrac++; }
"-"[0-9]+"/"[0-9]+                      { negfrac++; }
[0-9]+"/"-[0-9]+                        { negfrac++; }
"-"[0-9]+"/"+"-"[0-9]+                  { posfrac++; }
[0-9]+"."[0-9]+                         { posfrac++; }
[0-9]+"/"[0-9]+                         { posfrac++; }
"\."[0-9]+                              { posfrac++; }
"-"[0-9]+                               { negint++; }
[0-9]+                                  { posint++; }
[^ \t\n]+                               { invalid++; }
%%

int main() {
    printf("Enter a set of numbers:\n");
    yylex();
    printf("Positive Integers: %d\n", posint);
    printf("Negative Integers: %d\n", negint);
    printf("Positive Fractions: %d\n", posfrac);
    printf("Negative Fractions: %d\n", negfrac);
    printf("Invalid Numbers: %d\n", invalid);
    return 0;
}

int yywrap() {
    return 1;
}


/* OUTPUT:
Enter a set of numbers:
1 -2 3.5 3/5 -4.2 -4/5 5/-6 -5/-6 6.-7 0.3 .9 .9.4
Positive Integers: 1
Negative Integers: 1
Positive Fractions: 5
Negative Fractions: 3
Invalid Numbers: 2
*/