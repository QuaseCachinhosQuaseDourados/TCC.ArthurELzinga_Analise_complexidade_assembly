/* Problema: Nth Power of Matrix Approach to Find and Print Nth Fibonacci Numbers
 * Complexidade de Tempo: O(Log n)
 * Complexidade de Espaco: O(Log n)
 * Fonte: https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/
 */

#include <stdio.h>

voidmultiply(intF[2][2], intM[2][2]);

voidpower(intF[2][2], intn);

/* function that returns nth Fibonacci number */
intfib(intn)
{
    intF[2][2] = { { 1, 1 }, { 1, 0 } };
    if(n == 0)
        return0;
    power(F, n - 1);
    returnF[0][0];
}

/* Optimized version of power() in method 4 */
voidpower(intF[2][2], intn)
{
    if(n == 0 || n == 1)
        return;
    intM[2][2] = { { 1, 1 }, { 1, 0 } };

    power(F, n / 2);
    multiply(F, F);

    if(n % 2 != 0)
        multiply(F, M);
}

voidmultiply(intF[2][2], intM[2][2])
{
    intx = F[0][0] * M[0][0] + F[0][1] * M[1][0];
    inty = F[0][0] * M[0][1] + F[0][1] * M[1][1];
    intz = F[1][0] * M[0][0] + F[1][1] * M[1][0];
    intw = F[1][0] * M[0][1] + F[1][1] * M[1][1];

    F[0][0] = x;
    F[0][1] = y;
    F[1][0] = z;
    F[1][1] = w;
}

/* Driver program to test above function */
intmain()
{
    intn = 9;
    printf("%d", fib(9));
    getchar();
    return0;
}
