/* Problema: Write program to calculate pow(x, n)
 * Complexidade de Tempo: O(log |n|)
 * Complexidade de Espaco: O(log |n|)
 * Fonte: https://www.geeksforgeeks.org/write-a-c-program-to-calculate-powxn/
 */

/* Extended version of power function that can work
 for float x and negative y*/
#include <stdio.h>

floatpower(floatx, inty)
{
    floattemp;
    if(y == 0)
        return1;
    temp = power(x, y / 2);
    if(y % 2 == 0)
        returntemp * temp;
    else{
        if(y > 0)
            returnx * temp * temp;
        else
            return(temp * temp) / x;
    }
}

/* Driver code */
intmain()
{
    floatx = 2;
    inty = -3;

    // Function call
    printf("%f", power(x, y));
    return0;
}
