/* Problema: Maximum sum such that no two elements are adjacent (Stickler Thief)
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)+O(N)
 * Fonte: https://www.geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
 */

// C code to implement the approach

#include <stdio.h>
#include <stdlib.h>

// Function to find the maximum sum
intrec(int* nums, intidx, int* dp, intsize)
{
    if(idx >= size)
        return0;
    if(dp[idx] != -1)
        returndp[idx];
    returndp[idx]
           = (rec(nums, idx + 1, dp, size)
              > nums[idx] + rec(nums, idx + 2, dp, size))
                 ? rec(nums, idx + 1, dp, size)
                 : nums[idx] + rec(nums, idx + 2, dp, size);
}

intfindMaxSum(int* nums, intN)
{
    int* dp = (int*)malloc((N + 1) * sizeof(int));
    for(inti = 0; i < N + 1; i++)
        dp[i] = -1;
    intresult = rec(nums, 0, dp, N);
    free(dp);
    returnresult;
}

// Driver Code
intmain()
{
    // Creating the array
    intarr[] = { 5, 5, 10, 100, 10, 5 };
    intN = sizeof(arr) / sizeof(arr[0]);

    // Function call
    printf("%d\n", findMaxSum(arr, N));
    return0;
}
