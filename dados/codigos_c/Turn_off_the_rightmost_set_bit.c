/* Problema: Turn off the rightmost set bit
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/turn-off-the-rightmost-set-bit/
 */

#include <stdio.h>

// unsets the rightmost set bit
// of n and returns the result
intfun(unsigned intn)
{
    returnn & (n - 1);
}

// Driver Code
intmain()
{
    intn = 7;
    printf("The number after unsetting the");
    printf(" rightmost set bit %d", fun(n));
    return0;
}
