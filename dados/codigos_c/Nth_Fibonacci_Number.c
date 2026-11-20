/* Problema: Nth Fibonacci Number
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/
 */

// Fibonacci Series using Space Optimized Method
#include <stdio.h>
intfib(intn)
{
    inta = 0, b = 1, c, i;
    if(n == 0)
        returna;
    for(i = 2; i <= n; i++) {
        c = a + b;
        a = b;
        b = c;
    }
    returnb;
}

intmain()
{
    intn = 9;
    printf("%d", fib(n));
    getchar();
    return0;
}
