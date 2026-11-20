/* Problema: Search in a row-wise and column-wise sorted matrix in linear time complexity:
 * Complexidade de Tempo: O(M + N)
 * Complexidade de Espaco: O(M + N)
 * Fonte: https://www.geeksforgeeks.org/search-in-row-wise-and-column-wise-sorted-matrix/
 */

// C program to search an element in row-wise
// and column-wise sorted matrix
#include <stdio.h>

/* Searches the element x in mat[][]. If the
element is found, then prints its position
and returns true, otherwise prints "not found"
and returns false */
intsearch(intmat[4][4], intn, intx)
{
    if(n == 0)
        return-1;
    intsmallest = mat[0][0], largest = mat[n - 1][n - 1];
    if(x < smallest || x > largest)
        return-1;

    // set indexes for top right element
    inti = 0, j = n - 1;
    while(i < n && j >= 0) {
        if(mat[i][j] == x) {
            printf("Element found at %d, %d", i, j);
            return1;
        }
        if(mat[i][j] > x)
            j--;
        else// if mat[i][j] < x
            i++;
    }

    printf("n Element not found");
    return0; // if ( i==n || j== -1 )
}

// Driver code
intmain()
{
    intmat[4][4] = {
        { 10, 20, 30, 40 },
        { 15, 25, 35, 45 },
        { 27, 29, 37, 48 },
        { 32, 33, 39, 50 },
    };

    // Function call
    search(mat, 4, 29);
    return0;
}
