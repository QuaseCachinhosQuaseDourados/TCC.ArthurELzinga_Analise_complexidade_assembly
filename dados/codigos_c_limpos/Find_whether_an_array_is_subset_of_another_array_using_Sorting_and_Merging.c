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
void merge(int arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    /* create temp arrays */
    int L[n1], R[n2];

    /* Copy data to temp arrays L[] and R[] */
    for(i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for(j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    /* Merge the temp arrays back int o arr[l..r]*/
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
void mergeSort(int arr[], int l, int r)
{
    if(l < r) {
        // Same as (l+r)/2, but avoids overflow for
        // large l and h
        int m = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}
/* Return 1 if arr2[] is a subset of arr1[] */
int isSubset(int arr1[], int arr2[], int m, int n)
{
    int i = 0, j = 0;

    if(m < n)
        return 0;

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
        // both of them for ward
        else if(arr1[j] == arr2[i]) {
            j++;
            i++;
        }

        // If we do not have an element smaller
        // or equal to the second array then break
        else if(arr1[j] > arr2[i])
            return 0;
    }

    return(i < n) ? 0 : 1;
}

// Driver Code
int main()
{
    int arr1[] = { 11, 1, 13, 21, 3, 7 };
    int arr2[] = { 11, 3, 7, 1 };

    int m = sizeof(arr1) / sizeof(arr1[0]);
    int n = sizeof(arr2) / sizeof(arr2[0]);

    if(isSubset(arr1, arr2, m, n))
        printf("arr2[] is subset of arr1[] ");
    else
        printf("arr2[] is not a subset of arr1[] ");

    return 0;
}
