/* Problema: Babylonian method for square root
 * Complexidade de Tempo: O(n1/2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/square-root-of-a-perfect-square/
 */

#include <stdio.h>

/*Returns the square root of n. Note that the function */
floatsquareRoot(floatn)
{
    /*We are using n itself as initial approximation
   This can definitely be improved */
    floatx = n;
    floaty = 1;
    floate = 0.000001; /* e decides the accuracy level*/
    while(x - y > e) {
        x = (x + y) / 2;
        y = n / x;
    }
    returnx;
}

/* Driver program to test above function*/
intmain()
{
    intn = 50;
    printf("Square root of %d is %f", n, squareRoot(n));
    getchar();
}
