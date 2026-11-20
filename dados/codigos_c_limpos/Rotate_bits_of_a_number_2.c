/* Problema: Rotate bits of a number
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/rotate-bits-of-an-int eger/
 */

#include <stdio.h>
#define SHORT_SIZE 16

// function to rotate the given unsigned short
// in the left direction
unsigned short leftRotate(unsigned short x, short d)
{
    /**
     * By do ing x << d, we move the first(right most) d bits 
     * to the left most d bits, and at the same time we move
     * the left most d bits to the right side,
     * performing OR operation between the two gives use the
     * required result.
     * */

    return(x << d) | (x >> (SHORT_SIZE - d));
}

// function to rotate the given unsigned short
// in the right direction
unsigned short rightRotate(unsigned short x, short d)
{
    /**
     * By do ing x >> d, we move the first(left most) d bits 
     * to the right most d bits, and at the same time we move
     * the right most d bits to the right side,
     * performing OR operation between the two gives use the
     * required result.
     * */

    return(x >> d) | (x << (SHORT_SIZE - d));
}

/* Driver program to test above functions */
int main()
{
    // Test case
    unsigned short n = 28;
    short d = 2;
    printf("%d\n", leftRotate(n, d));
    printf("%d\n", rightRotate(n, d));

    return 0;
}

// This code is contributed by ganesh227
