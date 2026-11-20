/* Problema: Write program to calculate pow(x, n)
 * Complexidade de Tempo: O(log n)
 * Complexidade de Espaco: O(log n)
 * Fonte: https://www.geeksforgeeks.org/write-a-c-program-to-calculate-powxn/
 */

/* Function to calculate x raised to the power y in
 * O(logn)*/
intpower(intx, unsigned inty)
{
    inttemp;
    if(y == 0)
        return1;
    temp = power(x, y / 2);
    if(y % 2 == 0)
        returntemp * temp;
    else
        returnx * temp * temp;
}
