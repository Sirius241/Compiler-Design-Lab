%{
#include "2.tab.h"
#include <stdlib.h>
extern YYSTYPE yylval;
%}

%%

[0-9]+     { yylval = atoi(yytext); return NUM; }
[-+*/()]   { return yytext[0]; }
[ \t]      ;  // Ignore whitespace
\n         { return '\n'; }
.          { return yytext[0]; }

%%

int yywrap() {
    return 1;
}

/* OUTPUT 1:
Enter expression:
2+3*4
Valid expression!
Result is 14

OUTPUT 2:
Enter expression:
3++4
Invalid expression

OUTPUT 3:
Enter expression:
4/0
Division by zero!
*/