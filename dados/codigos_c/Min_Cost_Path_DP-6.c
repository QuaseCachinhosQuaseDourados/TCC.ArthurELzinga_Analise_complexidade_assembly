/* Problema: Min Cost Path | DP-6
 * Complexidade de Tempo: O((M * N)3)
 * Complexidade de Espaco: O(M + N)
 * Fonte: https://www.geeksforgeeks.org/min-cost-path-dp-6/
 */

/* A Naive recursive implementation of MCP(Minimum Cost
 * Path) problem */
#include <limits.h>
#include <stdio.h>
#define R 3
#define C 3

intmin(intx, inty, intz);

/* Returns cost of minimum cost path from (0,0) to (m, n) in
 * mat[R][C]*/
intminCost(intcost[R][C], intm, intn)
{
    if(n < 0 || m < 0)
        returnINT_MAX;
    elseif(m == 0 && n == 0)
        returncost[m][n];
    else
        returncost[m][n]
               + min(minCost(cost, m - 1, n - 1),
                     minCost(cost, m - 1, n),
                     minCost(cost, m, n - 1));
}

/* A utility function that returns minimum of 3 integers */
intmin(intx, inty, intz)
{
    if(x < y)
        return(x < z) ? x : z;
    else
        return(y < z) ? y : z;
}

/* Driver code */
intmain()
{
    intcost[R][C]
        = { { 1, 2, 3 }, { 4, 8, 2 }, { 1, 5, 3 } };
    printf(" %d ", minCost(cost, 2, 2));
    return0;
}
