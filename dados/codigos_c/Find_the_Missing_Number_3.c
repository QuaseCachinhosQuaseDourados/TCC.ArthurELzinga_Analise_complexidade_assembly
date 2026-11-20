/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

#include <stdio.h>

// Function to get the missing element
intgetMissingNo(inta[], intn)
{
    inti, total = 1;

    for(i = 2; i < (n + 1); i++) {
        total += i;
        total -= a[i - 2];
    }
    returntotal;
}

// Driver code
voidmain()
{
    intarr[] = { 1, 2, 3, 5 };
    intN = sizeof(arr) / sizeof(arr[0]);

    printf("%d", getMissingNo(arr, N));
}
// This code is contributed by Aditya Kumar (adityakumar129)
