/* Problema: Count Inversions in an array using Merge Sort:
 * Complexidade de Tempo: O(N * log N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/inversion-count-in-array-using-merge-sort/
 */

// C program to Count
// Inversions in an array
// using Merge Sort
#include <stdio.h>
#include <stdlib.h>

int_mergeSort(intarr[], inttemp[], intleft, intright);
intmerge(intarr[], inttemp[], intleft, intmid,
          intright);

// This function sorts the input array and returns the
// number of inversions in the array
intmergeSort(intarr[], intarray_size)
{
    int* temp = (int*)malloc(sizeof(int) * array_size);
    return_mergeSort(arr, temp, 0, array_size - 1);
}

// An auxiliary recursive function
// that sorts the input
// array and returns the number
// of inversions in the array.
int_mergeSort(intarr[], inttemp[], intleft, intright)
{
    intmid, inv_count = 0;
    if(right > left) {
        // Divide the array into two parts and call
        // _mergeSortAndCountInv() for each of the parts
        mid = (right + left) / 2;

        // Inversion count will be the sum of inversions in
        // left-part, right-part and number of inversions in
        // merging
        inv_count += _mergeSort(arr, temp, left, mid);
        inv_count += _mergeSort(arr, temp, mid + 1, right);

        // Merge the two parts
        inv_count += merge(arr, temp, left, mid + 1, right);
    }
    returninv_count;
}

// This function merges two sorted
// arrays and returns inversion
// count in the arrays.
intmerge(intarr[], inttemp[], intleft, intmid,
          intright)
{
    inti, j, k;
    intinv_count = 0;

    i = left;
    j = mid;
    k = left;
    while((i <= mid - 1) && (j <= right)) {
        if(arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        }
        else{
            temp[k++] = arr[j++];

            /*this is tricky -- see above
             * explanation/diagram for merge()*/
            inv_count = inv_count + (mid - i);
        }
    }

    // Copy the remaining elements of left subarray
    // (if there are any) to temp
    while(i <= mid - 1)
        temp[k++] = arr[i++];

    // Copy the remaining elements of right subarray
    // (if there are any) to temp
    while(j <= right)
        temp[k++] = arr[j++];

    // Copy back the merged elements to original array
    for(i = left; i <= right; i++)
        arr[i] = temp[i];

    returninv_count;
}

// Driver code
intmain(intargv, char** args)
{
    intarr[] = { 1, 20, 6, 4, 5 };
    printf(" Number of inversions are %d \n",
           mergeSort(arr, 5));
    getchar();
    return0;
}
