/* Problema: Longest Common Subsequence (LCS)
 * Complexidade de Tempo: O(2m*n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/longest-common-subsequence-dp-4/
 */

// A Naive recursive implementation
// of LCS problem
#include <stdio.h>

intmax(inta, intb);

// Returns length of LCS for X[0..m-1],
// Y[0..n-1]
intlcs(char* X, char* Y, inti, intj)
{
    if(X[i] == 0 || Y[j] == 0)
        return0;
    if(X[i] == Y[j])
        return1 + lcs(X, Y, i + 1, j + 1);
    else
        returnmax(lcs(X, Y, i, j + 1),
                   lcs(X, Y, i + 1, j));
}

// Utility function to get max of
// 2 integers
intmax(inta, intb) { return(a > b) ? a : b; }

// Driver code
intmain()
{
    charS1[] = "BD";
    charS2[] = "ABCD";
    intm = strlen(S1);
    intn = strlen(S2);
    inti = 0, j = 0;

    // Function Call
    printf("Length of LCS is %d", lcs(S1, S2, i, j));

    return0;
}
