%{
    #include <stdio.h>
    #include <stdlib.h>

    int total_for_count = 0;
    int current_nesting = 0;
    int max_nesting = 0;

    int yylex();
    int yyerror(const char *s);
%}

%token FOR IDEN NUM OP INCDEC ARITH

%%

STMTS: /* empty */
     | STMTS STMT
     ;

STMT: FORSTMT
    | IDEN '=' EXPR ';'
    | IDEN ';'
    | '{' STMTS '}'
    | 
    ;

FORSTMT:
    FOR '(' ASSGN ';' COND ';' ASSGN ')' 
    {
        total_for_count++;
        current_nesting++;
        if (current_nesting > max_nesting) {
            max_nesting = current_nesting;
        }
    }
    STMT
    {
        current_nesting--;
    }
    ;

ASSGN: IDEN '=' EXPR
     | IDEN INCDEC
     | 
     ;

COND: IDEN OP IDEN
    | IDEN OP NUM
    | IDEN
    | NUM
    |
    ;

EXPR: IDEN
    | NUM
    | IDEN ARITH IDEN
    | IDEN ARITH NUM
    ;

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <filename.c>\n", argv[0]);
        return 1;
    }

    extern FILE *yyin; 
    yyin = fopen(argv[1], "r");

    yyparse();

    fclose(yyin);

    printf("\nTotal FOR loops: %d\n", total_for_count);
    printf("Maximum nesting level: %d\n", max_nesting);
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    return 1;
}
