/* Problema: Rat in a Maze
 * Complexidade de Tempo: O(2^(n^2))
 * Complexidade de Espaco: O(n^2)
 * Fonte: https://www.geeksforgeeks.org/rat-in-a-maze/
 */

// C++ program to solve Rat in a Maze problem using
// backtracking
#include <stdio.h>
#include <stdbool.h>
// Maze size
#define N 4

boolsolveMazeUtil(intmaze[N][N], intx, inty,intsol[N][N]);

// A utility function to print solution matrix sol[N][N] 
voidprintSolution(intsol[N][N])
{
    for(inti = 0; i < N; i++) {
        for(intj = 0; j < N; j++)
            printf(" %d ", sol[i][j]);
        printf("\n");
    }
}

// A utility function to check if x, y is valid index for
// N*N maze
boolisSafe(intmaze[N][N], intx, inty)
{
    // if (x, y outside maze) return false
    if(x >= 0 && x < N && y >= 0 && y < N && maze[x][y] == 1)
        returntrue;
    returnfalse;
}

// This function solves the Maze problem using Backtracking.
// It mainly uses solveMazeUtil() to solve the problem. It
// returns false if no path is possible, otherwise return
// true and prints the path in the form of 1s. Please note
// that there may be more than one solutions, this function
// prints one of the feasible solutions.
boolsolveMaze(intmaze[N][N])
{
    intsol[N][N] = { { 0, 0, 0, 0 },
                      { 0, 0, 0, 0 },
                      { 0, 0, 0, 0 },
                      { 0, 0, 0, 0 } };
    if(solveMazeUtil(maze, 0, 0, sol) == false) {
        printf("Solution doesn't exist");
        returnfalse;
    }
    printSolution(sol);
    returntrue;
}

// A recursive utility function to solve Maze problem
boolsolveMazeUtil(intmaze[N][N], intx, inty, intsol[N][N])
{
    // if (x, y is goal) return true
    if(x == N - 1 && y == N - 1 && maze[x][y] == 1) {
        sol[x][y] = 1;
        returntrue;
    }
    // Check if maze[x][y] is valid
    if(isSafe(maze, x, y) == true) {
        // Check if the current block is already part of
        // solution path.
        if(sol[x][y] == 1)
            returnfalse;
        // mark x, y as part of solution path
        sol[x][y] = 1;
        /* Move forward in x direction */
        if(solveMazeUtil(maze, x + 1, y, sol) == true)
            returntrue;
        // If moving in x direction doesn't give solution
        // then Move down in y direction
        if(solveMazeUtil(maze, x, y + 1, sol) == true)
            returntrue;
        // If none of the above movements work then
        // BACKTRACK: unmark x, y as part of solution path
        sol[x][y] = 0;
        returnfalse;
    }
    returnfalse;
}

// driver program to test above function
intmain()
{
    intmaze[N][N] = { { 1, 0, 0, 0 },
                       { 1, 1, 0, 1 },
                       { 0, 1, 0, 0 },
                       { 1, 1, 1, 1 } };
    solveMaze(maze);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
