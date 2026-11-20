/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

#include <stdio.h>

// Function to find the missing number
intgetMissingNo(inta[], intn)
{
    inti, total;
    total = (n + 1) * (n + 2) / 2;
    for(i = 0; i < n; i++)
        total -= a[i];
    returntotal;
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
