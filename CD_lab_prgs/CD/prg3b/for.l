%{
#include "y.tab.h"
%}
%%
"for" return FOR;
">"|"<"|">="|"<="|"=="|"!=" return OP;
[a-zA-Z]* return IDEN;
[0-9]+ return NUM;
"=" return ASGN;
"++"|"--" return INCDEC;
"(" return '(';
")" return ')';
"{" return '{';
"}" return '}';
[\n\t ]  ;
.   return yytext[0];
%%
int yywrap(){
return 1;
}
