/* Problema: The Stock Span Problem
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/the-stock-span-problem/
 */

// C program for brute force method to calculate stock span
// values
#include <stdio.h>

// Fills array S[] with span values
voidcalculateSpan(intprice[], intn, intS[])
{
    // Span value of first day is always 1
    S[0] = 1;

    // Calculate span value of remaining days by linearly
    // checking previous days
    for(inti = 1; i < n; i++) {
        S[i] = 1; // Initialize span value

        // Traverse left while the next element on left is
        // smaller than price[i]
        for(intj = i - 1;
             (j >= 0) && (price[i] >= price[j]); j--)
            S[i]++;
    }
}

// A utility function to print elements of array
voidprintArray(intarr[], intn)
{
    for(inti = 0; i < n; i++)
        printf("%d ", arr[i]);
}

// Driver program to test above function
intmain()
{
    intprice[] = { 10, 4, 5, 90, 120, 80 };
    intn = sizeof(price) / sizeof(price[0]);
    intS[n];

    // Fill the span values in array S[]
    calculateSpan(price, n, S);

    // print the calculated span values
    printArray(S, n);

    return0;
}
