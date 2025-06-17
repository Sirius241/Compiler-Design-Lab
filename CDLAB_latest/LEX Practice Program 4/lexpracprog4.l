%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
int keywords = 0, identifiers = 0, operators = 0;

const char *keyword_list[] = {
    "auto", "break", "case", "char", "const", "continue", "default",
    "do", "double", "else", "enum", "extern", "float", "for", "goto",
    "if", "inline", "int", "long", "register", "restrict", "return",
    "short", "signed", "sizeof", "static", "struct", "switch",
    "typedef", "union", "unsigned", "void", "volatile"
};
int is_keyword(const char *word) {
    int n = sizeof(keyword_list) / sizeof(keyword_list[0]);
    for (int i = 0; i < n; i++) {
        if (strcmp(word, keyword_list[i]) == 0)
            return 1;
    }
    return 0;
}
%}


%%
[ \t\r\n]+         {;}
"//".*             {;}
"/*"([^*]|\*+[^*/])*\*+"/"  {;}
[a-zA-Z_][a-zA-Z0-9_]*  {
    if (is_keyword(yytext))
        keywords++;
    else
        identifiers++;
}
"=="|"!="|"<="|">="|"&&"|"||"|"++"|"--"|"+"|"-"|"*"|"/"|"="|"<"|">"  {operators++;}
.   {;}
%%


int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *in = fopen(argv[1], "r");
    if (!in) {
        perror("Error opening input file");
        return 1;
    }

    yyin = in;
    yylex();

    printf("Number of keywords: %d\n", keywords);
    printf("Number of identifiers: %d\n", identifiers);
    printf("Number of operators: %d\n", operators);

    fclose(in);
    return 0;
}

int yywrap() {
    return 1;
}

/* OUTPUT:
Number of keywords: 6
Number of identifiers: 8
Number of operators: 5
*/