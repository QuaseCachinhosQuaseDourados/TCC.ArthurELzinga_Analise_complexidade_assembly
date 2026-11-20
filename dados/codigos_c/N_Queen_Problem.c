/* Problema: N Queen Problem
 * Complexidade de Tempo: O(N!)
 * Complexidade de Espaco: O(N2)
 * Fonte: https://www.geeksforgeeks.org/n-queen-problem-backtracking-3/
 */

// C program to solve N Queen Problem using backtracking

#define N 4
#include <stdbool.h>
#include <stdio.h>

// A utility function to print solution
voidprintSolution(intboard[N][N])
{
    for(inti = 0; i < N; i++) {
        for(intj = 0; j < N; j++) {
            if(board[i][j])
                printf("Q ");
            else
                printf(". ");
        }
        printf("\n");
    }
}

// A utility function to check if a queen can
// be placed on board[row][col]. Note that this
// function is called when "col" queens are
// already placed in columns from 0 to col -1.
// So we need to check only left side for
// attacking queens
boolisSafe(intboard[N][N], introw, intcol)
{
    inti, j;

    // Check this row on left side
    for(i = 0; i < col; i++)
        if(board[row][i])
            returnfalse;

    // Check upper diagonal on left side
    for(i = row, j = col; i >= 0 && j >= 0; i--, j--)
        if(board[i][j])
            returnfalse;

    // Check lower diagonal on left side
    for(i = row, j = col; j >= 0 && i < N; i++, j--)
        if(board[i][j])
            returnfalse;

    returntrue;
}

// A recursive utility function to solve N
// Queen problem
boolsolveNQUtil(intboard[N][N], intcol)
{
    // Base case: If all queens are placed
    // then return true
    if(col >= N)
        returntrue;

    // Consider this column and try placing
    // this queen in all rows one by one
    for(inti = 0; i < N; i++) {
        
        // Check if the queen can be placed on
        // board[i][col]
        if(isSafe(board, i, col)) {
            
            // Place this queen in board[i][col]
            board[i][col] = 1;

            // Recur to place rest of the queens
            if(solveNQUtil(board, col + 1))
                returntrue;

            // If placing queen in board[i][col]
            // doesn't lead to a solution, then
            // remove queen from board[i][col]
            board[i][col] = 0; // BACKTRACK
        }
    }

    // If the queen cannot be placed in any row in
    // this column col  then return false
    returnfalse;
}

// This function solves the N Queen problem using
// Backtracking. It mainly uses solveNQUtil() to
// solve the problem. It returns false if queens
// cannot be placed, otherwise, return true and
// prints placement of queens in the form of 1s.
// Please note that there may be more than one
// solutions, this function prints one  of the
// feasible solutions.
boolsolveNQ()
{
    intboard[N][N] = { { 0, 0, 0, 0 },
                        { 0, 0, 0, 0 },
                        { 0, 0, 0, 0 },
                        { 0, 0, 0, 0 } };

    if(solveNQUtil(board, 0) == false) {
        printf("Solution does not exist");
        returnfalse;
    }

    printSolution(board);
    returntrue;
}

// Driver program to test above function
intmain()
{
    solveNQ();
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
