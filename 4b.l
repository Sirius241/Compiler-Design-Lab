%{
#include "4b.tab.h"
%}

%%
"if"        { return IF; }
">"|"<"|">="|"<="|"=="|"!=" return OP;
[a-zA-Z][a-zA-Z0-9]* { return IDEN; }
";"         { return ';'; }
[0-9]+ {return NUM;}
[\t\n]+ ;
"(" {return '(';}
")" {return ')';}
"{" {return '{';}
"}" {return '}';}
[\n\t ]  ;
. {return yytext[0];}
%%
int yywrap() {
    return 1;
}
