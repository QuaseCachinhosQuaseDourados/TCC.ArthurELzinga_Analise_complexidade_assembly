/* Problema: Swap bits in a given number
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/swap-bits-in-a-given-number/
 */

// C Program to swap bits
// in a given number
#include <stdio.h>

intswapBits(unsigned intx, unsigned intp1, unsigned intp2, unsigned intn)
{
    /* Move all bits of first set to rightmost side */
    unsigned intset1 = (x >> p1) & ((1U << n) - 1);

    /* Move all bits of second set to rightmost side */
    unsigned intset2 = (x >> p2) & ((1U << n) - 1);

    /* XOR the two sets */
    unsigned intxor = (set1 ^ set2);

    /* Put the xor bits back to their original positions */
    xor = (xor << p1) | (xor << p2);

    /* XOR the 'xor' with the original number so that the 
       two sets are swapped */
    unsigned intresult = x ^ xor;

    returnresult;
}

/* Driver program to test above function*/
intmain()
{
    intres = swapBits(28, 0, 3, 2);
    printf("\nResult = %d ", res);
    return0;
}
