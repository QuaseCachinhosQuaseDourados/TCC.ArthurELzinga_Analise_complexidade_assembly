/* Problema: Delete Operation:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-an-unsorted-array/
 */

// C program to implement delete operation in a
// unsorted array
#include <stdio.h>

// To search a key to be deleted
intfindElement(intarr[], intn, intkey);

// Function to delete an element
intdeleteElement(intarr[], intn, intkey)
{
    // Find position of element to be deleted
    intpos = findElement(arr, n, key);

    if(pos == -1) {
        printf("Element not found");
        returnn;
    }

    // Deleting element
    inti;
    for(i = pos; i < n - 1; i++)
        arr[i] = arr[i + 1];

    returnn - 1;
}

// Function to implement search operation
intfindElement(intarr[], intn, intkey)
{
    inti;
    for(i = 0; i < n; i++)
        if(arr[i] == key)
            returni;

    return-1;
}

// Driver's code
intmain()
{
    inti;
    intarr[] = { 10, 50, 30, 40, 20 };

    intn = sizeof(arr) / sizeof(arr[0]);
    intkey = 30;

    printf("Array before deletion\n");
    for(i = 0; i < n; i++)
        printf("%d  ", arr[i]);
    
      // Function call
    n = deleteElement(arr, n, key);

    printf("\nArray after deletion\n");
    for(i = 0; i < n; i++)
        printf("%d  ", arr[i]);

    return0;
}
