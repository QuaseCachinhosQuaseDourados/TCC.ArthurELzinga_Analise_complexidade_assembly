/* Problema: How to Insert in a Sorted Array?
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-a-sorted-array/
 */

// C program to implement insert operation in 
// an sorted array. 
#include <stdio.h> 
 
// Inserts a key in arr[] of given capacity.  n is current 
// size of arr[]. This function returns n+1 if insertion 
// is successful, else n. 
intinsertSorted(intarr[], intn, intkey, intcapacity) 
{ 
    // Cannot insert more elements if n is already 
    // more than or equal to capacity 
    if(n >= capacity) 
        returnn; 
 
    inti; 
    for(i = n - 1; (i >= 0 && arr[i] > key); i--) 
        arr[i + 1] = arr[i]; 
 
    arr[i + 1] = key; 
 
    return(n + 1); 
} 
 
/* Driver code */
intmain() 
{ 
    intarr[20] = { 12, 16, 20, 40, 50, 70 }; 
    intcapacity = sizeof(arr) / sizeof(arr[0]); 
    intn = 6; 
    inti, key = 26; 
 
    printf("\nBefore Insertion: "); 
    for(i = 0; i < n; i++) 
        printf("%d  ", arr[i]); 
 
    // Function call 
    n = insertSorted(arr, n, key, capacity); 
 
    printf("\nAfter Insertion: "); 
    for(i = 0; i < n; i++) 
        printf("%d  ", arr[i]); 
 
    return0; 
}
