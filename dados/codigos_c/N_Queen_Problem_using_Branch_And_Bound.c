/* Problema: N Queen Problem using Branch And Bound
 * Complexidade de Tempo: O(N!)
 * Complexidade de Espaco: O(N^2)
 * Fonte: https://www.geeksforgeeks.org/n-queen-problem-using-branch-and-bound/
 */

/* C++ program to solve N Queen Problem using Branch
   and Bound */
#include<stdio.h>
#include<string.h>
#include<stdbool.h>
#define N 8

/* A utility function to print solution */
voidprintSolution(intboard[N][N])
{
    for(inti = 0; i < N; i++)
    {
        for(intj = 0; j < N; j++)
            printf("%2d ", board[i][j]);
        printf("\n");
    }
}

/* A Optimized function to check if a queen can
be placed on board[row][col] */
boolisSafe(introw, intcol, intslashCode[N][N],
            intbackslashCode[N][N], boolrowLookup[],
      boolslashCodeLookup[], boolbackslashCodeLookup[] )
{
    if(slashCodeLookup[slashCode[row][col]] ||
        backslashCodeLookup[backslashCode[row][col]] ||
        rowLookup[row])
    returnfalse;

    returntrue;
}

/* A recursive utility function 
to solve N Queen problem */
boolsolveNQueensUtil(intboard[N][N], intcol,
    intslashCode[N][N], intbackslashCode[N][N], 
                                  boolrowLookup[N],
                            boolslashCodeLookup[], 
                           boolbackslashCodeLookup[] )
{
    /* base case: If all queens are placed
    then return true */
    if(col >= N)
        returntrue;

    /* Consider this column and try placing
       this queen in all rows one by one */
    for(inti = 0; i < N; i++)
    {
        /* Check if queen can be placed on
           board[i][col] */
        if( isSafe(i, col, slashCode, 
                    backslashCode, rowLookup,
          slashCodeLookup, backslashCodeLookup) )
        {
            /* Place this queen in board[i][col] */
            board[i][col] = 1;
            rowLookup[i] = true;
            slashCodeLookup[slashCode[i][col]] = true;
            backslashCodeLookup[backslashCode[i][col]] = true;

            /* recur to place rest of the queens */
            if( solveNQueensUtil(board, col + 1, 
                                  slashCode, backslashCode,
             rowLookup, slashCodeLookup, backslashCodeLookup) )
                returntrue;

            /* If placing queen in board[i][col]
            doesn't lead to a solution, then backtrack */

            /* Remove queen from board[i][col] */
            board[i][col] = 0;
            rowLookup[i] = false;
            slashCodeLookup[slashCode[i][col]] = false;
            backslashCodeLookup[backslashCode[i][col]] = false;
        }
    }

    /* If queen can not be place in any row in
        this column col then return false */
    returnfalse;
}

/* This function solves the N Queen problem using
Branch and Bound. It mainly uses solveNQueensUtil() to
solve the problem. It returns false if queens
cannot be placed, otherwise return true and
prints placement of queens in the form of 1s.
Please note that there may be more than one
solutions, this function prints one of the
feasible solutions.*/
boolsolveNQueens()
{
    intboard[N][N];
    memset(board, 0, sizeofboard);

    // helper matrices
    intslashCode[N][N];
    intbackslashCode[N][N];

    // arrays to tell us which rows are occupied
    boolrowLookup[N] = {false};

    //keep two arrays to tell us 
    // which diagonals are occupied
    boolslashCodeLookup[2*N - 1] = {false};
    boolbackslashCodeLookup[2*N - 1] = {false};

    // initialize helper matrices
    for(intr = 0; r < N; r++) 
        for(intc = 0; c < N; c++) {
          slashCode[r] = r + c, 
            backslashCode[r] = r - c + 7; 
        }

    if(solveNQueensUtil(board, 0, 
                          slashCode, backslashCode,
      rowLookup, slashCodeLookup, backslashCodeLookup) == 
                                                 false)
    {
        printf("Solution does not exist");
        returnfalse;
    }

    // solution found
    printSolution(board);
    returntrue;
}

// Driver program to test above function
intmain()
{
    solveNQueens();

    return0;
}
