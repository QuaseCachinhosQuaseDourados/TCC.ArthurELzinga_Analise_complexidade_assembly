/* Problema: Search, Insert, and Delete in an Unsorted Array | Array Operations
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-an-unsorted-array/
 */

// C Program to Insert an element
// at a specific position in an Array

#include <stdio.h>

// Function to insert element
// at a specific position
voidinsertElement(intarr[], intn, intx, intpos)
{
    // shift elements to the right
    // which are on the right side of pos
    for(inti = n - 1; i >= pos; i--)
        arr[i + 1] = arr[i];

    arr[pos] = x;
}

// Driver's code
intmain()
{
    intarr[15] = { 2, 4, 1, 8, 5 };
    intn = 5;

    printf("Before insertion : ");
    for(inti = 0; i < n; i++)
        printf("%d ", arr[i]);

    printf("\n");

    intx = 10, pos = 2;
  
      // Function call
    insertElement(arr, n, x, pos);
    n++;

    printf("After insertion : ");
    for(inti = 0; i < n; i++)
        printf("%d ", arr[i]);

    return0;
}
