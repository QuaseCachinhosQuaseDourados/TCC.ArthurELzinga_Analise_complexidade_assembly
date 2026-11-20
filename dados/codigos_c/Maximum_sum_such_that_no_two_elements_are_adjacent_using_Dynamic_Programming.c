/* Problema: Maximum sum such that no two elements are adjacent using Dynamic Programming:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
 */

// C code to implement the approach

#include <stdio.h>

// Function to find the maximum sum
intfindMaxSum(intarr[], intN)
{
    // Declare dp array
    intdp[N][2];
    if(N == 1) {
        returnarr[0];
    }

    // Initialize the values in dp array
    dp[0][0] = 0;
    dp[0][1] = arr[0];

    // Loop to find the maximum possible sum
    for(inti = 1; i < N; i++) {
        dp[i][1] = dp[i - 1][0] + arr[i];
        dp[i][0] = (dp[i - 1][1] > dp[i - 1][0])
                       ? dp[i - 1][1]
                       : dp[i - 1][0];
    }

    // Return the maximum sum
    return(dp[N - 1][0] > dp[N - 1][1]) ? dp[N - 1][0]
                                         : dp[N - 1][1];
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
