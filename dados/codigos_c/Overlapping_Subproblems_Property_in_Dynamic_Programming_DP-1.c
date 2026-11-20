/* Problema: Overlapping Subproblems Property in Dynamic Programming | DP-1
 * Complexidade de Tempo: O(2N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/overlapping-subproblems-property-in-dynamic-programming-dp-1/
 */

/* a simple recursive program for Fibonacci numbers */
intfib(intn)
{
    if(n <= 1)
        returnn;

    returnfib(n - 1) + fib(n - 2);
}
