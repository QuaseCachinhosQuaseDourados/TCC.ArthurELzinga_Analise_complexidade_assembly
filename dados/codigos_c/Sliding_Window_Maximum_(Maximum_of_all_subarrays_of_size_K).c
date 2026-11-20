/* Problema: Sliding Window Maximum (Maximum of all subarrays of size K)
 * Complexidade de Tempo: O(N * K)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/sliding-window-maximum-maximum-of-all-subarrays-of-size-k/
 */

// C program for the above approach
#include <stdio.h>

voidprintKMax(intarr[], intN, intK)
{
    intj, max;

    for(inti = 0; i <= N - K; i++) {
        max = arr[i];

        for(j = 1; j < K; j++) {
            if(arr[i + j] > max)
                max = arr[i + j];
        }
        printf("%d ", max);
    }
}

// Driver's Code
intmain()
{
    intarr[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    intN = sizeof(arr) / sizeof(arr[0]);
    intK = 3;
  
      // Function call
    printKMax(arr, N, K);
    return0;
}
