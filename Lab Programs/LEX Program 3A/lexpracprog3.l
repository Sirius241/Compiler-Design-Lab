%{
#include <stdio.h>
#include <string.h>
int comment_lines = 0;
%}

%%
\/\/[^\n]*        { comment_lines++;}
\/\*([^*]|\*+[^*/])*\*+\/ {
    int lines = 1;
    for (int i = 0; yytext[i] != '\0'; i++) {
        if (yytext[i] == '\n') lines++;
    }
    comment_lines += lines;
}
.|\n              { fputc(yytext[0], out);}
%%


int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file.c>\n", argv[0]);
        return 1;
    }

    FILE *in = fopen(argv[1], "r");
    if (!in) {
        perror("Error opening input file");
        return 1;
    }

    FILE *out = fopen("clean_code.c", "w");
    if (!out) {
        perror("Error creating output file");
        fclose(in);
        return 1;
    }

    yyin = in;
    yylex();

    printf("Total comment lines removed: %d\n", comment_lines);

    fclose(in);
    fclose(out);
    return 0;
}

int yywrap() {
    return 1;
}

/* OUTPUT:
//clean_code.c
#include <stdio.h>



int main() {
    printf("Hello\n"); 
    return 0;
}

//Terminal output
Total comment lines removed: 3
*/