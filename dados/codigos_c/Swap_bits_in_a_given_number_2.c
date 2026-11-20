/* Problema: Swap bits in a given number
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/swap-bits-in-a-given-number/
 */

intswapBits(unsigned intx, unsigned intp1, unsigned intp2, unsigned intn)
{
    /* xor contains xor of two sets */
    unsigned intxor = ((x >> p1) ^ (x >> p2)) & ((1U << n) - 1);

    /* To swap two sets, we need to again XOR the xor with original sets */
    returnx ^ ( (xor << p1) | (xor << p2));
}
