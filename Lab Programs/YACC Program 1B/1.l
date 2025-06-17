%{
#include "1.tab.h"
%}

%%
"a"     { return 'a'; }
"b"     { return 'b'; }
"c"     { return 'c'; }
\n      { return '\n'; }
.       { return yytext[0]; }
%%

int yywrap() {
    return 1;
}

/* OUTPUT:
Enter the input:
abc
Invalid string

Enter the input:
abbc
Valid string
*/