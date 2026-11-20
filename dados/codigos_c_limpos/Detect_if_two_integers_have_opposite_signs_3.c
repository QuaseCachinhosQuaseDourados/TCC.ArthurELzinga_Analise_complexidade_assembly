/* Problema: Detect if two int egers have opposite signs
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/detect-if-two-int egers-have-opposite-signs/
 */

//C program to detect whether two int egers
//have different sign or not

#include <stdio.h>
#include<stdbool.h>

booloppositeSigns(int x, int y)
{
    return((x ^ y) >> 31);
}

//this code is contributed by shruti456rawal
