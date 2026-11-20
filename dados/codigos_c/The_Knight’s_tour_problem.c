/* Problema: The Knight’s tour problem
 * Complexidade de Tempo: O(8N^2)
 * Complexidade de Espaco: O(N2)
 * Fonte: https://www.geeksforgeeks.org/the-knights-tour-problem/
 */

// C program for Knight Tour problem 
#include <stdio.h> 
#define N 8 
 
intsolveKTUtil(intx, inty, intmovei, intsol[N][N], 
                intxMove[], intyMove[]); 
 
/* A utility function to check if i,j are valid indexes 
   for N*N chessboard */
intisSafe(intx, inty, intsol[N][N]) 
{ 
    return(x >= 0 && x < N && y >= 0 && y < N 
            && sol[x][y] == -1); 
} 
 
/* A utility function to print solution matrix sol[N][N] */
voidprintSolution(intsol[N][N]) 
{ 
    for(intx = 0; x < N; x++) { 
        for(inty = 0; y < N; y++) 
            printf(" %2d ", sol[x][y]); 
        printf("\n"); 
    } 
} 
 
/* This function solves the Knight Tour problem using 
   Backtracking.  This function mainly uses solveKTUtil() 
   to solve the problem. It returns false if no complete 
   tour is possible, otherwise return true and prints the 
   tour. 
   Please note that there may be more than one solutions, 
   this function prints one of the feasible solutions.  */
intsolveKT() 
{ 
    intsol[N][N]; 
 
    /* Initialization of solution matrix */
    for(intx = 0; x < N; x++) 
        for(inty = 0; y < N; y++) 
            sol[x][y] = -1; 
 
    /* xMove[] and yMove[] define next move of Knight. 
       xMove[] is for next value of x coordinate 
       yMove[] is for next value of y coordinate */
    intxMove[8] = { 2, 1, -1, -2, -2, -1, 1, 2 }; 
    intyMove[8] = { 1, 2, 2, 1, -1, -2, -2, -1 }; 
 
    // Since the Knight is initially at the first block 
    sol[0][0] = 0; 
 
    /* Start from 0,0 and explore all tours using 
       solveKTUtil() */
    if(solveKTUtil(0, 0, 1, sol, xMove, yMove) == 0) { 
        printf("Solution does not exist"); 
        return0; 
    } 
    else
        printSolution(sol); 
 
    return1; 
} 
 
/* A recursive utility function to solve Knight Tour 
   problem */
intsolveKTUtil(intx, inty, intmovei, intsol[N][N], 
                intxMove[N], intyMove[N]) 
{ 
    intk, next_x, next_y; 
    if(movei == N * N) 
        return1; 
 
    /* Try all next moves from the current coordinate x, y 
     */
    for(k = 0; k < 8; k++) { 
        next_x = x + xMove[k]; 
        next_y = y + yMove[k]; 
        if(isSafe(next_x, next_y, sol)) { 
            sol[next_x][next_y] = movei; 
            if(solveKTUtil(next_x, next_y, movei + 1, sol, 
                            xMove, yMove) 
                == 1) 
                return1; 
            else
                sol[next_x][next_y] = -1; // backtracking 
        } 
    } 
 
    return0; 
} 
 
/* Driver Code */
intmain() 
{ 
   
      // Function Call 
    solveKT(); 
    return0; 
}
