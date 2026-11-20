/* Problema: Given an n x n square matrix, find sum of all sub-squares of size k x k
 * Complexidade de Tempo: O(k2n2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/given-n-x-n-square-matrix-find-sum-sub-squares-size-k-x-k/
 */

// A simple C program to find sum of all subsquares of
// size k x k
#include <stdio.h>

// Size of given matrix
#define n 5

// A simple function to find sum of all sub-squares of size
// k x k in a given square matrix of size n x n
voidprintSumSimple(intmat[][n], intk)
{
    // k must be smaller than or equal to n
    if(k > n)
        return;

    // row number of first cell in current sub-square of
    // size k x k
    for(inti = 0; i < n - k + 1; i++) {
        // column of first cell in current sub-square of
        // size k x k
        for(intj = 0; j < n - k + 1; j++) {
            // Calculate and print sum of current sub-square
            intsum = 0;
            for(intp = i; p < k + i; p++)
                for(intq = j; q < k + j; q++)
                    sum += mat[p][q];
            printf("%d ", sum);
        }

        // Line separator for sub-squares starting with next
        // row
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
    printSumSimple(mat, k);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
