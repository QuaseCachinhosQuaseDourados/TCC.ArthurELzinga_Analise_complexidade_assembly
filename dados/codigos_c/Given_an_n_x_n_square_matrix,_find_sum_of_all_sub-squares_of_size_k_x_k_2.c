/* Problema: Given an n x n square matrix, find sum of all sub-squares of size k x k
 * Complexidade de Tempo: O(n2)
 * Complexidade de Espaco: O(n2)
 * Fonte: https://www.geeksforgeeks.org/given-n-x-n-square-matrix-find-sum-sub-squares-size-k-x-k/
 */

// An efficient C program to find sum of all subsquares of
// size k x k
#include <stdio.h>

// Size of given matrix
#define n 5

// A O(n^2) function to find sum of all sub-squares of size
// k x k in a given square matrix of size n x n
voidprintSumTricky(intmat[][n], intk)
{
    // k must be smaller than or equal to n
    if(k > n)
        return;

    // 1: PREPROCESSING
    // To store sums of all strips of size k x 1
    intstripSum[n][n];

    // Go column by column
    for(intj = 0; j < n; j++) {
        // Calculate sum of first k x 1 rectangle in this
        // column
        intsum = 0;
        for(inti = 0; i < k; i++)
            sum += mat[i][j];
        stripSum[0][j] = sum;

        // Calculate sum of remaining rectangles
        for(inti = 1; i < n - k + 1; i++) {
            sum += (mat[i + k - 1][j] - mat[i - 1][j]);
            stripSum[i][j] = sum;
        }
    }

    // 2: CALCULATE SUM of Sub-Squares using stripSum[][]
    for(inti = 0; i < n - k + 1; i++) {
        // Calculate and print sum of first subsquare in
        // this row
        intsum = 0;
        for(intj = 0; j < k; j++)
            sum += stripSum[i][j];
        printf("%d ", sum);

        // Calculate sum of remaining squares in current row
        // by removing the leftmost strip of previous
        // sub-square and adding a new strip
        for(intj = 1; j < n - k + 1; j++) {
            sum += (stripSum[i][j + k - 1]
                    - stripSum[i][j - 1]);
            printf("%d ", sum);
        }

        printf("\n");
    }
}

// Driver program to test above function
intmain()
{
    intmat[n][n] = {
        { 1, 1, 1, 1, 1 }, { 2, 2, 2, 2, 2 },
        { 3, 3, 3, 3, 3 }, { 4, 4, 4, 4, 4 },
        { 5, 5, 5, 5, 5 },
    };
    intk = 3;
    printSumTricky(mat, k);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
