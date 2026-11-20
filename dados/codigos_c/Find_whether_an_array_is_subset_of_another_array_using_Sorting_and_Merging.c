/* Problema: Find whether an array is subset of another array using Sorting and Merging
 * Complexidade de Tempo: O(mLog(m) + nLog(n))
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-whether-an-array-is-subset-of-another-array-set-1/
 */

// C program to find whether an array
// is subset of another array
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

    /* create temp arrays */
    intL[n1], R[n2];

    /* Copy data to temp arrays L[] and R[] */
    for(i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for(j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    /* Merge the temp arrays back into arr[l..r]*/
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray
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

    /* Copy the remaining elements of L[], if there
    are any */
    while(i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    /* Copy the remaining elements of R[], if there
    are any */
    while(j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

/* l is for left index and r is right index of the
sub-array of arr to be sorted */
voidmergeSort(intarr[], intl, intr)
{
    if(l < r) {
        // Same as (l+r)/2, but avoids overflow for
        // large l and h
        intm = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}
/* Return 1 if arr2[] is a subset of arr1[] */
intisSubset(intarr1[], intarr2[], intm, intn)
{
    inti = 0, j = 0;

    if(m < n)
        return0;

    // Sort both the arrays
    mergeSort(arr1, 0, m - 1);
    mergeSort(arr2, 0, n - 1);

    // Iterate till they do not exceed their sizes
    while(i < n && j < m) {
        // If the element is smaller then
        // Move ahead in the first array
        if(arr1[j] < arr2[i])
            j++;
        // If both are equal, then move
        // both of them forward
        elseif(arr1[j] == arr2[i]) {
            j++;
            i++;
        }

        // If we do not have an element smaller
        // or equal to the second array then break
        elseif(arr1[j] > arr2[i])
            return0;
    }

    return(i < n) ? 0 : 1;
}

// Driver Code
intmain()
{
    intarr1[] = { 11, 1, 13, 21, 3, 7 };
    intarr2[] = { 11, 3, 7, 1 };

    intm = sizeof(arr1) / sizeof(arr1[0]);
    intn = sizeof(arr2) / sizeof(arr2[0]);

    if(isSubset(arr1, arr2, m, n))
        printf("arr2[] is subset of arr1[] ");
    else
        printf("arr2[] is not a subset of arr1[] ");

    return0;
}
