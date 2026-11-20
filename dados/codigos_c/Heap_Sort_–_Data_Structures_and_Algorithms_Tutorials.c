/* Problema: Heap Sort – Data Structures and Algorithms Tutorials
 * Complexidade de Tempo: O(N log N)
 * Complexidade de Espaco: O(log n)
 * Fonte: https://www.geeksforgeeks.org/heap-sort/
 */

// Heap Sort in C

#include <stdio.h>

// Function to swap the position of two elements

voidswap(int* a, int* b)
{

    inttemp = *a;
    *a = *b;
    *b = temp;
}

// To heapify a subtree rooted with node i
// which is an index in arr[].
// n is size of heap
voidheapify(intarr[], intN, inti)
{
    // Find largest among root,
    // left child and right child

    // Initialize largest as root
    intlargest = i;

    // left = 2*i + 1
    intleft = 2 * i + 1;

    // right = 2*i + 2
    intright = 2 * i + 2;

    // If left child is larger than root
    if(left < N && arr[left] > arr[largest])

        largest = left;

    // If right child is larger than largest
    // so far
    if(right < N && arr[right] > arr[largest])

        largest = right;

    // Swap and continue heapifying
    // if root is not largest
    // If largest is not root
    if(largest != i) {

        swap(&arr[i], &arr[largest]);

        // Recursively heapify the affected
        // sub-tree
        heapify(arr, N, largest);
    }
}

// Main function to do heap sort
voidheapSort(intarr[], intN)
{

    // Build max heap
    for(inti = N / 2 - 1; i >= 0; i--)

        heapify(arr, N, i);

    // Heap sort
    for(inti = N - 1; i >= 0; i--) {

        swap(&arr[0], &arr[i]);

        // Heapify root element
        // to get highest element at
        // root again
        heapify(arr, i, 0);
    }
}

// A utility function to print array of size n
voidprintArray(intarr[], intN)
{
    for(inti = 0; i < N; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

// Driver's code
intmain()
{
    intarr[] = { 12, 11, 13, 5, 6, 7 };
    intN = sizeof(arr) / sizeof(arr[0]);

    // Function call
    heapSort(arr, N);
    printf("Sorted array is\n");
    printArray(arr, N);
}

// This code is contributed by _i_plus_plus_.
