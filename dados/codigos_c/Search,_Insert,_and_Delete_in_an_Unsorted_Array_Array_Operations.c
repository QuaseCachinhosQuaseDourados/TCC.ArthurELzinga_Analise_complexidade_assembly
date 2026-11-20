/* Problema: Search, Insert, and Delete in an Unsorted Array | Array Operations
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-an-unsorted-array/
 */

// C program to implement linear
// search in unsorted array
#include <stdio.h>

// Function to implement search operation
intfindElement(intarr[], intn, intkey)
{
    inti;
    for(i = 0; i < n; i++)
        if(arr[i] == key)
            returni;
    
      // If the key is not found
    return-1;
}

// Driver's Code
intmain()
{
    intarr[] = { 12, 34, 10, 6, 40 };
    intn = sizeof(arr) / sizeof(arr[0]);

    // Using a last element as search element
    intkey = 40;
  
      // Function call
    intposition = findElement(arr, n, key);

    if(position == -1)
        printf("Element not found");
    else
        printf("Element Found at Position: %d",
               position + 1);

    return0;
}
