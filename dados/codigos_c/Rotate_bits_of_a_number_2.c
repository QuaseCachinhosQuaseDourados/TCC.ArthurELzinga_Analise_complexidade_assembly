/* Problema: Rotate bits of a number
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/rotate-bits-of-an-integer/
 */

#include <stdio.h>
#define SHORT_SIZE 16

// function to rotate the given unsigned short
// in the left direction
unsigned shortleftRotate(unsigned shortx, shortd)
{
    /**
     * By doing x << d, we move the first(right most) d bits 
     * to the left most d bits, and at the same time we move
     * the left most d bits to the right side,
     * performing OR operation between the two gives use the
     * required result.
     * */

    return(x << d) | (x >> (SHORT_SIZE - d));
}

// function to rotate the given unsigned short
// in the right direction
unsigned shortrightRotate(unsigned shortx, shortd)
{
    /**
     * By doing x >> d, we move the first(left most) d bits 
     * to the right most d bits, and at the same time we move
     * the right most d bits to the right side,
     * performing OR operation between the two gives use the
     * required result.
     * */

    return(x >> d) | (x << (SHORT_SIZE - d));
}

/* Driver program to test above functions */
intmain()
{
    // Test case
    unsigned shortn = 28;
    shortd = 2;
    printf("%d\n", leftRotate(n, d));
    printf("%d\n", rightRotate(n, d));

    return0;
}

// This code is contributed by ganesh227
