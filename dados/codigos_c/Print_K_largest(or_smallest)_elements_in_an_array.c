/* Problema: Print K largest(or smallest) elements in an array
 * Complexidade de Tempo: O(N * log(N))
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/k-largestor-smallest-elements-in-an-array/
 */

// C code for k largest elements in an array
#include <stdio.h>
#include <stdlib.h>

// Compare function for qsort
intcmpfunc(constvoid* a, constvoid* b)
{
    return(*(int*)b - *(int*)a);
}

voidkLargest(intarr[], intn, intk)
{
    // Sort the given array arr in reverse order.
    qsort(arr, n, sizeof(int), cmpfunc);
    // Print the first kth largest elements
    for(inti = 0; i < k; i++)
        printf("%d ", arr[i]);
}

// Driver code
intmain()
{
    intarr[] = { 1, 23, 12, 9, 30, 2, 50 };
    intn = sizeof(arr) / sizeof(arr[0]);
    intk = 3;
    kLargest(arr, n, k);
}

// This code is contributed by Aditya Kumar (adityakumar129)
