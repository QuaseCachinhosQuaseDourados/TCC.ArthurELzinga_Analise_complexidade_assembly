/* Problema: Search an element in a sorted and rotated  Array
 * Complexidade de Tempo: O(log N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/
 */

// Search an element in sorted and rotated
// array using single pass of Binary Search
#include <stdio.h>

// Returns index of key in arr[l..h] if
// key is present, otherwise returns -1
intsearch(intarr[], intl, inth, intkey)
{
    if(l > h)
        return-1;

    intmid = (l + h) / 2;
    if(arr[mid] == key)
        returnmid;

    /* If arr[l...mid] is sorted */
    if(arr[l] <= arr[mid]) {
        /* As this subarray is sorted, we can quickly
        check if key lies in half or other half */
        if(key >= arr[l] && key <= arr[mid])
            returnsearch(arr, l, mid - 1, key);
        /*If key not lies in first half subarray,
           Divide other half  into two subarrays,
           such that we can quickly check if key lies
           in other half */
        returnsearch(arr, mid + 1, h, key);
    }

    /* If arr[l..mid] first subarray is not sorted, then
    arr[mid... h] must be sorted subarray */
    if(key >= arr[mid] && key <= arr[h])
        returnsearch(arr, mid + 1, h, key);

    returnsearch(arr, l, mid - 1, key);
}

// Driver program
intmain()
{
    intarr[] = { 4, 5, 6, 7, 8, 9, 1, 2, 3 };
    intn = sizeof(arr) / sizeof(arr[0]);
    intkey = 3;
    inti = search(arr, 0, n - 1, key);

    if(i != -1)
        printf("Index: %d\n", i);
    else
        printf("Key not found");
}

// This code is contributed by Aditya Kumar (adityakumar129)
