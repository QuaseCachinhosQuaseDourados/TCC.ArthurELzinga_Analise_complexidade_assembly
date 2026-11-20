/* Problema: Program to calculate pow(x, n) using Divide and Conqueror approach:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/write-a-c-program-to-calculate-powxn/
 */

// C program to calculate pow(x,n)
#include <stdio.h>

/* Function to calculate x raised to the power y */
intpower(intx, unsigned inty)
{
    if(y == 0)
        return1;
    elseif(y % 2 == 0)
        returnpower(x, y / 2) * power(x, y / 2);
    else
        returnx * power(x, y / 2) * power(x, y / 2);
}

/* Driver code */
intmain()
{
    intx = 2;
    unsigned inty = 3;

    // Function call
    printf("%d", power(x, y));
    return0;
}
