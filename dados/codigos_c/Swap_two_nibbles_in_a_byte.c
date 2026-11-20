/* Problema: Swap two nibbles in a byte
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/swap-two-nibbles-byte/
 */

#include <stdio.h>

unsigned charswapNibbles(unsigned charx)
{
    return( (x & 0x0F)<<4 | (x & 0xF0)>>4 );
}

intmain()
{
    unsigned charx = 100;
    printf("%u", swapNibbles(x));
    return0;
}
