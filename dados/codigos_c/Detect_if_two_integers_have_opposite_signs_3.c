/* Problema: Detect if two integers have opposite signs
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/detect-if-two-integers-have-opposite-signs/
 */

//C program to detect whether two integers
//have different sign or not

#include <stdio.h>
#include<stdbool.h>

booloppositeSigns(intx, inty)
{
    return((x ^ y) >> 31);
}

//this code is contributed by shruti456rawal
