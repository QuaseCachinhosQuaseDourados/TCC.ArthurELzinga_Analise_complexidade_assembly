/* Problema: Merge Sort – Data Structure and Algorithms Tutorials
 * Complexidade de Tempo: O(N log(N))
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/merge-sort/
 */

// C program for Merge Sort
#include <stdio.h>
#include <stdlib.h>

// Merges two subarrays of arr[].
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
voidmerge(intarr[], intl, intm, intr)
{
    inti, j, k;
    intn1 = m - l + 1;
    intn2 = r - m;

    // Create temp arrays
    intL[n1], R[n2];

    // Copy data to temp arrays L[] and R[]
    for(i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for(j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    // Merge the temp arrays back into arr[l..r
    i = 0;
    j = 0;
    k = l;
    while(i < n1 && j < n2) {
        if(L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else{
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    // Copy the remaining elements of L[],
    // if there are any
    while(i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    // Copy the remaining elements of R[],
    // if there are any
    while(j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

// l is for left index and r is right index of the
// sub-array of arr to be sorted
voidmergeSort(intarr[], intl, intr)
{
    if(l < r) {
        intm = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}

// Function to print an array
voidprintArray(intA[], intsize)
{
    inti;
    for(i = 0; i < size; i++)
        printf("%d ", A[i]);
    printf("\n");
}

// Driver code
intmain()
{
    intarr[] = { 12, 11, 13, 5, 6, 7 };
    intarr_size = sizeof(arr) / sizeof(arr[0]);

    printf("Given array is \n");
    printArray(arr, arr_size);

    mergeSort(arr, 0, arr_size - 1);

    printf("\nSorted array is \n");
    printArray(arr, arr_size);
    return0;
}
