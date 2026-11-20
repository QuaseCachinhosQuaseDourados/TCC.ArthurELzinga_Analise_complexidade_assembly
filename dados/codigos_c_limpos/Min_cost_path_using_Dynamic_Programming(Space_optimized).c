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
int min(int num1, int num2)
{
    return(num1 > num2) ? num2 : num1;
}

int minCost(int cost[row][col])
{
    // for 1st column
    for(int i = 1; i < row; i++)
        cost[i][0] += cost[i - 1][0];

    // for 1st row
    for(int j = 1; j < col; j++)
        cost[0][j] += cost[0][j - 1];

    // for rest of the 2d matrix
    for(int i = 1; i < row; i++)
        for(int j = 1; j < col; j++)
            cost[i][j]
                += min(cost[i - 1][j - 1],
                       min(cost[i - 1][j], cost[i][j - 1]));

    // return ing the value in last cell
    return cost[row - 1][col - 1];
}

// Driver code
int main()
{
    int cost[row][col]
        = { { 1, 2, 3 }, { 4, 8, 2 }, { 1, 5, 3 } };

    printf("%d \n", minCost(cost));
    return 0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
