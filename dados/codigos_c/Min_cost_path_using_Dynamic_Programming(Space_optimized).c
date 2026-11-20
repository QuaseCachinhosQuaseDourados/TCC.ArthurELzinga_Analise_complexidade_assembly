/* Problema: Min cost path using Dynamic Programming(Space optimized):
 * Complexidade de Tempo: O(N * M)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/min-cost-path-dp-6/
 */

// C++ program for the above approach

#include <stdio.h>

#define row 3
#define col 3

// Find minimum between two numbers.
intmin(intnum1, intnum2)
{
    return(num1 > num2) ? num2 : num1;
}

intminCost(intcost[row][col])
{
    // for 1st column
    for(inti = 1; i < row; i++)
        cost[i][0] += cost[i - 1][0];

    // for 1st row
    for(intj = 1; j < col; j++)
        cost[0][j] += cost[0][j - 1];

    // for rest of the 2d matrix
    for(inti = 1; i < row; i++)
        for(intj = 1; j < col; j++)
            cost[i][j]
                += min(cost[i - 1][j - 1],
                       min(cost[i - 1][j], cost[i][j - 1]));

    // returning the value in last cell
    returncost[row - 1][col - 1];
}

// Driver code
intmain()
{
    intcost[row][col]
        = { { 1, 2, 3 }, { 4, 8, 2 }, { 1, 5, 3 } };

    printf("%d \n", minCost(cost));
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
