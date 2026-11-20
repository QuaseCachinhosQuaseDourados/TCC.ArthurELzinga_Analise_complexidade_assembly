/* Problema: K largest elements in an array using Quick Sort partitioning algorithm:
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/k-largestor-smallest-elements-in-an-array/
 */

#include <stdio.h>

// Function to swap two integers
voidswap(int* a, int* b) {
    inttemp = *a;
    *a = *b;
    *b = temp;
}

// Partition the array around the last element and get the position of the pivot element in the sorted array
intpartition(intarr[], intl, intr) {
    intx = arr[r], i = l;
    for(intj = l; j <= r - 1; j++) {
        if(arr[j] <= x) {
            swap(&arr[i], &arr[j]);
            i++;
        }
    }
    swap(&arr[i], &arr[r]);
    returni;
}

// This function stops at the K'th largest element in arr[l..r] using QuickSort-based method
voidKthLargest(intarr[], intl, intr, intK, intN) {
    // Partition the array around the last element and get the position of the pivot element in the sorted array
    intpos = partition(arr, l, r);

    // If position is the same as K
    if(pos - l == K - 1)
        return;

    // If position is less, recurse for the right subarray
    elseif(pos - l < K - 1)
        returnKthLargest(arr, pos + 1, r, K - pos + l - 1, N);

    // Else, recurse for the left subarray
    else
        returnKthLargest(arr, l, pos - 1, K, N);
}

intmain() {
    intarr[] = { 11, 3, 2, 1, 15, 5, 4, 45, 88, 96, 50, 45 };
    intN = sizeof(arr) / sizeof(arr[0]);
    intk = 3;

    // For Largest
    KthLargest(arr, 0, N - 1, k, N);

    // Print K Largest numbers
    printf("%d largest elements are: ", k);
    for(inti = N - 1; i >= N - k; i--)
        printf("%d ", arr[i]);
    
    printf("\n");

    return0;
}
