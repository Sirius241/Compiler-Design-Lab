#include <stdio.h>
int main() 
{
    int a,b,c; a=45; b=25;
    c=a+b;
    printf("Sum: %d", c);
    return 0;
}

/*
OUTPUT:
gcc -S test.c -o output.s
output.s
*/