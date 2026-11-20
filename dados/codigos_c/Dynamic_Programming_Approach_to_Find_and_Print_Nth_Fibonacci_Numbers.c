/* Problema: Dynamic Programming Approach to Find and Print Nth Fibonacci Numbers:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/
 */

// Fibonacci Series using Dynamic Programming
#include <stdio.h>

intfib(intn)
{
    /* Declare an array to store Fibonacci numbers. */
    intf[n + 2]; // 1 extra to handle case, n = 0
    inti;

    /* 0th and 1st number of the series are 0 and 1*/
    f[0] = 0;
    f[1] = 1;

    for(i = 2; i <= n; i++) {
        /* Add the previous 2 numbers in the series
           and store it */
        f[i] = f[i - 1] + f[i - 2];
    }

    returnf[n];
}

intmain()
{
    intn = 9;
    printf("%d", fib(n));
    getchar();
    return0;
}
