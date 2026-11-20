/* Problema: Overlapping Subproblems Property in Dynamic Programming | DP-1
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/overlapping-subproblems-property-in-dynamic-programming-dp-1/
 */

/* C program for Memoized version for nth Fibonacci number
 */
#include <stdio.h>
#define NIL -1
#define MAX 100

intlookup[MAX];

/* Function to initialize NIL values in lookup table */
void_initialize()
{
    inti;
    for(i = 0; i < MAX; i++)
        lookup[i] = NIL;
}

/* function for nth Fibonacci number */
intfib(intn)
{
    if(lookup[n] == NIL) {
        if(n <= 1)
            lookup[n] = n;
        else
            lookup[n] = fib(n - 1) + fib(n - 2);
    }

    returnlookup[n];
}

intmain()
{
    intn = 40;
    _initialize();
    printf("Fibonacci number is %d ", fib(n));
    return0;
}
