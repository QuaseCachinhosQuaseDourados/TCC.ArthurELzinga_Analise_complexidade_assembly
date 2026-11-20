/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

#include <stdio.h>

// Function to find the missing number
intgetMissingNo(inta[], intn)
{
    inti;

    // For xor of all the elements in array
    intx1 = a[0];

    // For xor of all the elements from 1 to n+1
    intx2 = 1;

    for(i = 1; i < n; i++)
        x1 = x1 ^ a[i];

    for(i = 2; i <= n + 1; i++)
        x2 = x2 ^ i;

    return(x1 ^ x2);
}

// Driver code
voidmain()
{
    intarr[] = { 1, 2, 3, 5 };
    intN = sizeof(arr) / sizeof(arr[0]);

    // Function call
    intmiss = getMissingNo(arr, N);
    printf("%d", miss);
}
