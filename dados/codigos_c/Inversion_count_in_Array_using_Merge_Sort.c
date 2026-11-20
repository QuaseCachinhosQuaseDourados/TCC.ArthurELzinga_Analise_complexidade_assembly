/* Problema: Inversion count in Array using Merge Sort
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/inversion-count-in-array-using-merge-sort/
 */

// C program to Count
// Inversions in an array
#include <stdio.h>
#include <stdlib.h>
intgetInvCount(intarr[], intn)
{
    intinv_count = 0;
    for(inti = 0; i < n - 1; i++)
        for(intj = i + 1; j < n; j++)
            if(arr[i] > arr[j])
                inv_count++;

    returninv_count;
}

/* Driver program to test above functions */
intmain()
{
    intarr[] = { 1, 20, 6, 4, 5 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printf(" Number of inversions are %d \n",
           getInvCount(arr, n));
    return0;
}
