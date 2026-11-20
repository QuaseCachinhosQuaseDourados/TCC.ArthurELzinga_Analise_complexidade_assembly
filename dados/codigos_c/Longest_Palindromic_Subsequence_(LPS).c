/* Problema: Longest Palindromic Subsequence (LPS)
 * Complexidade de Tempo: O(2n)
 * Complexidade de Espaco: O(n2)
 * Fonte: https://www.geeksforgeeks.org/longest-palindromic-subsequence-dp-12/
 */

// C program of above approach
#include <stdio.h>
#include <string.h>

// A utility function to get max of two integers
intmax(intx, inty) { return(x > y) ? x : y; }

// Returns the length of the longest palindromic subsequence
// in seq
intlps(char* seq, inti, intj)
{
    // Base Case 1: If there is only 1 character
    if(i == j)
        return1;

    // Base Case 2: If there are only 2 characters and both
    // are same
    if(seq[i] == seq[j] && i + 1 == j)
        return2;

    // If the first and last characters match
    if(seq[i] == seq[j])
        returnlps(seq, i + 1, j - 1) + 2;

    // If the first and last characters do not match
    returnmax(lps(seq, i, j - 1), lps(seq, i + 1, j));
}

/* Driver program to test above functions */
intmain()
{
    charseq[] = "GEEKSFORGEEKS";
    intn = strlen(seq);
    printf("The length of the LPS is %d",
           lps(seq, 0, n - 1));
    getchar();
    return0;
}
