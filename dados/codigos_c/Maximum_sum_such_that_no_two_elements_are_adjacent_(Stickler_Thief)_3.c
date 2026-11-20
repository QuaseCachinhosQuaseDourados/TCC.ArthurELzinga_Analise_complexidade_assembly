/* Problema: Maximum sum such that no two elements are adjacent (Stickler Thief)
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/maximum-sum-such-that-no-two-elements-are-adjacent/
 */

// C code to implement the approach

#include <stdio.h>

// Function to return max sum such that
// no two elements are adjacent
intfindMaxSum(intarr[], intn)
{
    intincl = arr[0];
    intexcl = 0;
    intexcl_new;
    inti;

    for(i = 1; i < n; i++) {
        
        // Current max excluding i
        excl_new = (incl > excl) ? incl : excl;

        // Current max including i
        incl = excl + arr[i];
        excl = excl_new;
    }

    // Return max of incl and excl
    return((incl > excl) ? incl : excl);
}

// Driver code
intmain()
{
    intarr[] = { 5, 5, 10, 100, 10, 5 };
    intN = sizeof(arr) / sizeof(arr[0]);
    
    // Function call
    printf("%d", findMaxSum(arr, N));
    return0;
}
