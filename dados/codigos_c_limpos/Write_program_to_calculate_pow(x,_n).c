/* Problema: Write program to calculate pow(x, n)
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/write-a-c-program-to-calculate-powxn/
 */

// C program for the above approach
#include <stdio.h>

int power(int x, int n)
{
    // If x^0 return 1
    if(n == 0)
        return 1;

    // If we need to find of 0^y
    if(x == 0)
        return 0;
    // For all other case s
    return x * power(x, n - 1);
}

// Driver Code
int main()
{
    int x = 2;
    int n = 3;

    // Function call
    printf("%d\n", power(x, n));
}

// This code is contributed by Aditya Kumar (adityakumar129)
