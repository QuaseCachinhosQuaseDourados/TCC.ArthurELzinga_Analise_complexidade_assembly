/* Problema: Search in a row wise and column wise sorted matrix
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
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

    // traverse through the matrix
    for(inti = 0; i < n; i++) {
        for(intj = 0; j < n; j++)
            // if the element is found
            if(mat[i][j] == x) {
                printf("Element found at (%d, %d)\n", i, j);
                return1;
            }
    }

    printf("Element not found");
    return0;
}

// Driver code
intmain()
{
    intmat[4][4] = { { 10, 20, 30, 40 },
                      { 15, 25, 35, 45 },
                      { 27, 29, 37, 48 },
                      { 32, 33, 39, 50 } };

    // Function call
    search(mat, 4, 29);

    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
