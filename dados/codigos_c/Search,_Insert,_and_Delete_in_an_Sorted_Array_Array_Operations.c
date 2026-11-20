/* Problema: Search, Insert, and Delete in an Sorted Array | Array Operations
 * Complexidade de Tempo: O(log(n))
 * Complexidade de Espaco: O(log(n))
 * Fonte: https://www.geeksforgeeks.org/search-insert-and-delete-in-a-sorted-array/
 */

// C program to implement binary search in sorted array 
#include <stdio.h> 
 
intbinarySearch(intarr[], intlow, inthigh, intkey) 
{ 
    if(high < low) 
        return-1; 
    intmid = (low + high) / 2; /*low + (high - low)/2;*/
    if(key == arr[mid]) 
        returnmid; 
    if(key > arr[mid]) 
        returnbinarySearch(arr, (mid + 1), high, key); 
    returnbinarySearch(arr, low, (mid - 1), key); 
} 
 
/* Driver Code */
intmain() 
{ 
    // Let us search 3 in below array 
    intarr[] = { 5, 6, 7, 8, 9, 10 }; 
    intn, key; 
 
    n = sizeof(arr) / sizeof(arr[0]); 
    key = 10; 
 
    // Function call 
    printf("Index: %d\n", binarySearch(arr, 0, n - 1, key)); 
    return0; 
}
