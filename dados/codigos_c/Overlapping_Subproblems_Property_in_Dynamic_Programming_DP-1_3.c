/* Problema: Overlapping Subproblems Property in Dynamic Programming | DP-1
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/overlapping-subproblems-property-in-dynamic-programming-dp-1/
 */

/* C program for Tabulated version */
#include <stdio.h>
intfib(intn)
{
    intf[n + 1];
    inti;
    f[0] = 0;
    f[1] = 1;
    for(i = 2; i <= n; i++)
        f[i] = f[i - 1] + f[i - 2];

    returnf[n];
}

intmain()
{
    intn = 9;
    printf("Fibonacci number is %d ", fib(n));
    return0;
}
