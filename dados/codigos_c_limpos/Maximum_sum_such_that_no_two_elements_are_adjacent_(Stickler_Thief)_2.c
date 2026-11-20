/* Problema: Maximum sum such that no two elements are adjacent (Stickler Thief)
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)+O(N)
 * Fonte: https://www.geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
 */

// C code to implement the approach

#include <stdio.h>
#include <stdlib.h>

// Function to find the maximum sum
int rec(int* nums, int idx, int* dp, int size)
{
    if(idx >= size)
        return 0;
    if(dp[idx] != -1)
        return dp[idx];
    return dp[idx]
           = (rec(nums, idx + 1, dp, size)
              > nums[idx] + rec(nums, idx + 2, dp, size))
                 ? rec(nums, idx + 1, dp, size)
                 : nums[idx] + rec(nums, idx + 2, dp, size);
}

int findMaxSum(int* nums, int N)
{
    int* dp = (int*)malloc((N + 1) * sizeof(int));
    for(int i = 0; i < N + 1; i++)
        dp[i] = -1;
    int result = rec(nums, 0, dp, N);
    free(dp);
    return result;
}

// Driver Code
int main()
{
    // Creating the array
    int arr[] = { 5, 5, 10, 100, 10, 5 };
    int N = sizeof(arr) / sizeof(arr[0]);

    // Function call
    printf("%d\n", findMaxSum(arr, N));
    return 0;
}
