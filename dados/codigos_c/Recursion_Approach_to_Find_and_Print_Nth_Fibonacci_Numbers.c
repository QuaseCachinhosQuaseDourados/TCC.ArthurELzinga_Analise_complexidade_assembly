/* Problema: Recursion Approach to Find and Print Nth Fibonacci Numbers:
 * Complexidade de Tempo: Exponential
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/
 */

// Fibonacci Series using Recursion
#include <stdio.h>
intfib(intn)
{
    if(n <= 1)
        returnn;
    returnfib(n - 1) + fib(n - 2);
}

intmain()
{
    intn = 9;
    printf("%dth Fibonacci Number: %d", n, fib(n));
    return0;
}
