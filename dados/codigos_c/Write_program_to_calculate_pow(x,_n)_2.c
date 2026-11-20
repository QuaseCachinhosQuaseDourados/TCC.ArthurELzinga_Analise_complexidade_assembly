/* Problema: Write program to calculate pow(x, n)
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/write-a-c-program-to-calculate-powxn/
 */

// C program for the above approach
#include <stdio.h>

intpower(intx, intn)
{
    // If x^0 return 1
    if(n == 0)
        return1;

    // If we need to find of 0^y
    if(x == 0)
        return0;
    // For all other cases
    returnx * power(x, n - 1);
}

// Driver Code
intmain()
{
    intx = 2;
    intn = 3;

    // Function call
    printf("%d\n", power(x, n));
}

// This code is contributed by Aditya Kumar (adityakumar129)
