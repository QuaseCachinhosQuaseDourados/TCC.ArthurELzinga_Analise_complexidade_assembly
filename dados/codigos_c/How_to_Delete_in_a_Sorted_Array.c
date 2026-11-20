/* Problema: How to Delete in a Sorted Array?
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(log N)
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-a-sorted-array/
 */

// C program to implement delete operation in a 
// sorted array 
#include <stdio.h> 
 
// To search a key to be deleted 
intbinarySearch(intarr[], intlow, inthigh, intkey); 
 
/* Function to delete an element */
intdeleteElement(intarr[], intn, intkey) 
{ 
    // Find position of element to be deleted 
    intpos = binarySearch(arr, 0, n - 1, key); 
 
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
 
intbinarySearch(intarr[], intlow, inthigh, intkey) 
{ 
    if(high < low) 
        return-1; 
    intmid = (low + high) / 2; 
    if(key == arr[mid]) 
        returnmid; 
    if(key > arr[mid]) 
        returnbinarySearch(arr, (mid + 1), high, key); 
    returnbinarySearch(arr, low, (mid - 1), key); 
} 
 
// Driver code 
intmain() 
{ 
    inti; 
    intarr[] = { 10, 20, 30, 40, 50 }; 
 
    intn = sizeof(arr) / sizeof(arr[0]); 
    intkey = 30; 
 
    printf("Array before deletion\n"); 
    for(i = 0; i < n; i++) 
        printf("%d  ", arr[i]); 
 
    // Function call 
    n = deleteElement(arr, n, key); 
 
    printf("\n\nArray after deletion\n"); 
    for(i = 0; i < n; i++) 
        printf("%d  ", arr[i]); 
}
