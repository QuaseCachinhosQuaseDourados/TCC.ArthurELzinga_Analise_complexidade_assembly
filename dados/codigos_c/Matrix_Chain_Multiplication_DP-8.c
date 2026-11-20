/* Problema: Matrix Chain Multiplication | DP-8
 * Complexidade de Tempo: exponential
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/matrix-chain-multiplication-dp-8/
 */

// C code to implement the 
// matrix chain multiplication using recursion

#include <limits.h>
#include <stdio.h>

// Matrix Ai has dimension p[i-1] x p[i] 
// for i = 1 . . . n
intMatrixChainOrder(intp[], inti, intj)
{
    if(i == j)
        return0;
    intk;
    intmin = INT_MAX;
    intcount;

    // Place parenthesis at different places
    // between first and last matrix, 
    // recursively calculate count of multiplications 
    // for each parenthesis placement 
    // and return the minimum count
    for(k = i; k < j; k++) 
    {
        count = MatrixChainOrder(p, i, k)
                + MatrixChainOrder(p, k + 1, j)
                + p[i - 1] * p[k] * p[j];

        if(count < min)
            min = count;
    }

    // Return minimum count
    returnmin;
}

// Driver code
intmain()
{
    intarr[] = { 1, 2, 3, 4, 3 };
    intN = sizeof(arr) / sizeof(arr[0]);

    // Function call
    printf("Minimum number of multiplications is %d ",
           MatrixChainOrder(arr, 1, N - 1));
    getchar();
    return0;
}
