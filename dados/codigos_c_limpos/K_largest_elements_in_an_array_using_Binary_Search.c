/* Problema: K largest elements in an array using Binary Search:
 * Complexidade de Tempo: O(n * log (mx-mn))
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/k-largestor-smallest-elements-in-an-array/
 */

#include <stdio.h>

// Function to swap two int egers
void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Partition the array around the last element and get the position of the pivot element in the sorted array
int partition(int arr[], int l, int r) {
    int x = arr[r], i = l;
    for(int j = l; j <= r - 1; j++) {
        if(arr[j] <= x) {
            swap(&arr[i], &arr[j]);
            i++;
        }
    }
    swap(&arr[i], &arr[r]);
    return i;
}

// This function stops at the K'th largest element in arr[l..r] using QuickSort-based method
void KthLargest(int arr[], int l, int r, int K, int N) {
    // Partition the array around the last element and get the position of the pivot element in the sorted array
    int pos = partition(arr, l, r);

    // If position is the same as K
    if(pos - l == K - 1)
        return;

    // If position is less, recurse for the right subarray
    else if(pos - l < K - 1)
        return KthLargest(arr, pos + 1, r, K - pos + l - 1, N);

    // Else, recurse for the left subarray
    else
        return KthLargest(arr, l, pos - 1, K, N);
}

int main() {
    int arr[] = { 11, 3, 2, 1, 15, 5, 4, 45, 88, 96, 50, 45 };
    int N = sizeof(arr) / sizeof(arr[0]);
    int k = 3;

    // For Largest
    KthLargest(arr, 0, N - 1, k, N);

    // Print K Largest numbers
    printf("%d largest elements are: ", k);
    for(int i = N - 1; i >= N - k; i--)
        printf("%d ", arr[i]);
    
    printf("\n");

    return 0;
}
