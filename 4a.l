%{
#include<stdio.h>
int id=0,kw=0,op=0;
%}

%%
"int"|"float"|"if"|"else"|"while"|"return"|"for"|"double"|"exit"  {kw++;}
[a-zA-Z_][a-zA-Z0-9_]* {id++;}
"+"|"-"|"*"|"/"|"="|"^"|"=="|"++"|"--"|"<"|">" {op++;}
. ;
%%

int main(int argc,char **argv)
{
if(argc<2)
{
fprintf(stderr,"usage:%s <filename.c>\n",argv[0]);
return 1;
}
yyin=fopen(argv[1],"r");
yylex();
printf("Count of Identifiers: %d\nKeywords: %d\nOperators: %d\n",id,kw,op);
return 0;
}

int yywrap()
{
return 1;
}

