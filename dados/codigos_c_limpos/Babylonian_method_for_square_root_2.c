/* Problema: Babylonian method for square root
 * Complexidade de Tempo: O(n1/2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/square-root-of-a-perfect-square/
 */

// C program for Babylonian
// method for square root
#include <stdio.h>

/* Returns the square root of 
   n. Note that the function
   will not work for numbers 
   which are not perfect 
   squares*/
unsigned int squareRoot(int n)
{
    int x = n;
    int y = 1;
    while(x > y) {
        x = (x + y) / 2;
        y = n / x;
    }
    return x;
}

// Driver Code
int main()
{
    int n = 49;
    printf("root of %d is %d", n, squareRoot(n));
    getchar();
}
