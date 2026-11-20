/* Problema: Maximum sum such that no two elements are adjacent (Stickler Thief)
 * Complexidade de Tempo: O(2N)
 * Complexidade de Espaco: O(2N)
 * Fonte: https://www.geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
 */

// C code to implement the approach

#include <stdio.h>

// Function to find the maximum sum
intrec(int* nums, intidx, intsize)
{
    if(idx >= size)
        return0;
    return(nums[idx] + rec(nums, idx + 2, size)
            > rec(nums, idx + 1, size))
               ? nums[idx] + rec(nums, idx + 2, size)
               : rec(nums, idx + 1, size);
}

intfindMaxSum(int* arr, intN) { returnrec(arr, 0, N); }

// Driver Code
intmain()
{
    // Creating the array
    intarr[] = { 5, 5, 10, 100, 10, 5 };
    intN = sizeof(arr) / sizeof(arr[0]);

    // Function call
    printf("%d", findMaxSum(arr, N));
    return0;
}
