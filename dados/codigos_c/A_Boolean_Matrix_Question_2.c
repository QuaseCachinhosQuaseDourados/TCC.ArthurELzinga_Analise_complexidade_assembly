/* Problema: A Boolean Matrix Question
 * Complexidade de Tempo: O(M*N)
 * Complexidade de Espaco: O(M+N)
 * Fonte: https://www.geeksforgeeks.org/a-boolean-matrix-question/
 */

// C Code For A Boolean Matrix Question
#include <stdbool.h>
#include <stdio.h>

#define R 3
#define C 4

voidmodifyMatrix(boolmat[R][C])
{
    boolrow[R];
    boolcol[C];

    inti, j;

    /* Initialize all values of row[] as 0 */
    for(i = 0; i < R; i++)
        row[i] = 0;

    /* Initialize all values of col[] as 0 */
    for(i = 0; i < C; i++)
        col[i] = 0;

    // Store the rows and columns to be marked as
    // 1 in row[] and col[] arrays respectively
    for(i = 0; i < R; i++) {
        for(j = 0; j < C; j++) {
            if(mat[i][j] == 1) {
                row[i] = 1;
                col[j] = 1;
            }
        }
    }

    // Modify the input matrix mat[] using the
    // above constructed row[] and col[] arrays
    for(i = 0; i < R; i++)
        for(j = 0; j < C; j++)
            if(row[i] == 1 || col[j] == 1)
                mat[i][j] = 1;
}

/* A utility function to print a 2D matrix */
voidprintMatrix(boolmat[R][C])
{
    inti, j;
    for(i = 0; i < R; i++) {
        for(j = 0; j < C; j++)
            printf("%d ", mat[i][j]);
        printf("\n");
    }
}

// Driver Code
intmain()
{
    boolmat[R][C] = { { 1, 0, 0, 1 },
                       { 0, 0, 1, 0 },
                       { 0, 0, 0, 0 } };

    printf("Input Matrix \n");
    printMatrix(mat);
    modifyMatrix(mat);
    printf("Matrix after modification \n");
    printMatrix(mat);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
