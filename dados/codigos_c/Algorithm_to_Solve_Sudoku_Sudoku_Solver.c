/* Problema: Algorithm to Solve Sudoku | Sudoku Solver
 * Complexidade de Tempo: O(9(N*N))
 * Complexidade de Espaco: O(9(N*N))
 * Fonte: https://www.geeksforgeeks.org/sudoku-backtracking-7/
 */

#include <stdio.h>
#include <stdlib.h>

// N is the size of the 2D matrix   N*N
#define N 9

/* A utility function to print grid */
voidprint(intarr[N][N])
{
     for(inti = 0; i < N; i++)
      {
         for(intj = 0; j < N; j++)
            printf("%d ",arr[i][j]);
         printf("\n");
       }
}

// Checks whether it will be legal  
// to assign num to the
// given row, col
intisSafe(intgrid[N][N], introw, 
                       intcol, intnum)
{
    
    // Check if we find the same num 
    // in the similar row , we return 0
    for(intx = 0; x <= 8; x++)
        if(grid[row][x] == num)
            return0;

    // Check if we find the same num in the 
    // similar column , we return 0
    for(intx = 0; x <= 8; x++)
        if(grid[x][col] == num)
            return0;

    // Check if we find the same num in the 
    // particular 3*3 matrix, we return 0
    intstartRow = row - row % 3, 
                 startCol = col - col % 3;
  
    for(inti = 0; i < 3; i++)
        for(intj = 0; j < 3; j++)
            if(grid[i + startRow][j + 
                          startCol] == num)
                return0;

    return1;
}

/* Takes a partially filled-in grid and attempts
to assign values to all unassigned locations in
such a way to meet the requirements for
Sudoku solution (non-duplication across rows,
columns, and boxes) */
intsolveSudoku(intgrid[N][N], introw, intcol)
{
    
    // Check if we have reached the 8th row 
    // and 9th column (0
    // indexed matrix) , we are 
    // returning true to avoid
    // further backtracking
    if(row == N - 1 && col == N)
        return1;

    //  Check if column value  becomes 9 ,
    //  we move to next row and
    //  column start from 0
    if(col == N) 
    {
        row++;
        col = 0;
    }
  
    // Check if the current position 
    // of the grid already contains
    // value >0, we iterate for next column
    if(grid[row][col] > 0)
        returnsolveSudoku(grid, row, col + 1);

    for(intnum = 1; num <= N; num++) 
    {
        
        // Check if it is safe to place 
        // the num (1-9)  in the
        // given row ,col  ->we move to next column
        if(isSafe(grid, row, col, num)==1) 
        {
            /* assigning the num in the 
               current (row,col)
               position of the grid
               and assuming our assigned num 
               in the position
               is correct     */
            grid[row][col] = num;
          
            //  Checking for next possibility with next
            //  column
            if(solveSudoku(grid, row, col + 1)==1)
                return1;
        }
      
        // Removing the assigned num ,
        // since our assumption
        // was wrong , and we go for next 
        // assumption with
        // diff num value
        grid[row][col] = 0;
    }
    return0;
}

intmain()
{
    // 0 means unassigned cells
    intgrid[N][N] = { { 3, 0, 6, 5, 0, 8, 4, 0, 0 },
                       { 5, 2, 0, 0, 0, 0, 0, 0, 0 },
                       { 0, 8, 7, 0, 0, 0, 0, 3, 1 },
                       { 0, 0, 3, 0, 1, 0, 0, 8, 0 },
                       { 9, 0, 0, 8, 6, 3, 0, 0, 5 },
                       { 0, 5, 0, 0, 9, 0, 6, 0, 0 },
                       { 1, 3, 0, 0, 0, 0, 2, 5, 0 },
                       { 0, 0, 0, 0, 0, 0, 0, 7, 4 },
                       { 0, 0, 5, 2, 0, 6, 3, 0, 0 } };

    if(solveSudoku(grid, 0, 0)==1)
        print(grid);
    else
        printf("No solution exists");

    return0;
    // This is code is contributed by Pradeep Mondal P
}
