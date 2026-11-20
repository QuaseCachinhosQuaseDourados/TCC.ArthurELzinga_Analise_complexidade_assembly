/* Problema: Min cost path using Memoization DP:
 * Complexidade de Tempo: O(M * N)
 * Complexidade de Espaco: O(M * N)
 * Fonte: https://www.geeksforgeeks.org/min-cost-path-dp-6/
 */

/* Dynamic Programming implementation of MCP problem */
#include <limits.h>
#include <stdio.h>
#define R 3
#define C 3

intmin(intx, inty, intz);

intminCost(intcost[R][C], intm, intn)
{
    inti, j;

    // Instead of following line, we can use int
    // tc[m+1][n+1] or dynamically allocate memory to save
    // space. The following line is used to keep the program
    // simple and make it working on all compilers.
    inttc[R][C];

    tc[0][0] = cost[0][0];

    /* Initialize first column of total cost(tc) array */
    for(i = 1; i <= m; i++)
        tc[i][0] = tc[i - 1][0] + cost[i][0];

    /* Initialize first row of tc array */
    for(j = 1; j <= n; j++)
        tc[0][j] = tc[0][j - 1] + cost[0][j];

    /* Construct rest of the tc array */
    for(i = 1; i <= m; i++)
        for(j = 1; j <= n; j++)
            tc[i][j] = min(tc[i - 1][j - 1], tc[i - 1][j],
                           tc[i][j - 1])
                       + cost[i][j];

    returntc[m][n];
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
