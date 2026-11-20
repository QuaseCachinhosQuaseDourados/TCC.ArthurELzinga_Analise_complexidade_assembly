/* Problema: Insert Operation:
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-an-unsorted-array/
 */

// C program to implement insert
// operation in an unsorted array.
#include <stdio.h>

// Inserts a key in arr[] of given capacity.
// n is current size of arr[]. This
// function returns n + 1 if insertion
// is successful, else n.
intinsertSorted(intarr[], intn, intkey, intcapacity)
{

    // Cannot insert more elements if n is
    // already more than or equal to capacity
    if(n >= capacity)
        returnn;

    arr[n] = key;

    return(n + 1);
}

// Driver Code
intmain()
{
    intarr[20] = { 12, 16, 20, 40, 50, 70 };
    intcapacity = sizeof(arr) / sizeof(arr[0]);
    intn = 6;
    inti, key = 26;

    printf("\n Before Insertion: ");
    for(i = 0; i < n; i++)
        printf("%d  ", arr[i]);

    // Inserting key
    n = insertSorted(arr, n, key, capacity);

    printf("\n After Insertion: ");
    for(i = 0; i < n; i++)
        printf("%d  ", arr[i]);

    return0;
}
