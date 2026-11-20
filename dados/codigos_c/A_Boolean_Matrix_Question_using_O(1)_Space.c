/* Problema: A Boolean Matrix Question using O(1) Space:
 * Complexidade de Tempo: O(M*N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/a-boolean-matrix-question/
 */

#include <stdbool.h>
#include <stdio.h>

#define R 3
#define C 4

voidmodifyMatrix(intmat[R][C])
{
    // variables to check if there are any 1
    // in first row and column
    boolrow_flag = false;
    boolcol_flag = false;

    // updating the first row and col if 1
    // is encountered
    for(inti = 0; i < R; i++) {
        for(intj = 0; j < C; j++) {
            if(i == 0 && mat[i][j] == 1)
                row_flag = true;

            if(j == 0 && mat[i][j] == 1)
                col_flag = true;

            if(mat[i][j] == 1) {
                mat[0][j] = 1;
                mat[i][0] = 1;
            }
        }
    }

    // Modify the input matrix mat[] using the
    // first row and first column of Matrix mat
    for(inti = 1; i < R; i++)
        for(intj = 1; j < C; j++)
            if(mat[0][j] == 1 || mat[i][0] == 1)
                mat[i][j] = 1;

    // modify first row if there was any 1
    if(row_flag == true)
        for(inti = 0; i < C; i++)
            mat[0][i] = 1;

    // modify first col if there was any 1
    if(col_flag == true)
        for(inti = 0; i < R; i++)
            mat[i][0] = 1;
}

/* A utility function to print a 2D matrix */
voidprintMatrix(intmat[R][C])
{
    for(inti = 0; i < R; i++) {
        for(intj = 0; j < C; j++)
            printf("%d ", mat[i][j]);
        printf("\n");
    }
}

// Driver function to test the above function
intmain()
{

    intmat[R][C] = { { 1, 0, 0, 1 },
                      { 0, 0, 1, 0 },
                      { 0, 0, 0, 0 } };

    printf("Input Matrix :\n");
    printMatrix(mat);
    modifyMatrix(mat);
    printf("Matrix After Modification :\n");
    printMatrix(mat);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
