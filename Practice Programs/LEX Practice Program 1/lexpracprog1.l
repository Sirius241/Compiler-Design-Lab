%{
int c=0,v=0;
%}

%%
[aeiouAEIOU]    {v++;}
[a-zA-Z]        {c++;}
.               ;
%%

int main() {
    printf("Enter the string: \n");
    yylex();
    printf("Number of vowels: %d \nNumber of consonants: %d\n",v,c);
    return 0;
}

int yywrap() {
    return 1;
}

/* OUTPUT:
Enter the string: 
I am in RVCE!
Number of vowels: 4 
Number of consonants: 5
*/