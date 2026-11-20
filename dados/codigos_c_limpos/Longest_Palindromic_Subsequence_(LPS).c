/* Problema: Longest Palindromic Subsequence (LPS)
 * Complexidade de Tempo: O(2n)
 * Complexidade de Espaco: O(n2)
 * Fonte: https://www.geeksforgeeks.org/long est-palindromic-subsequence-dp-12/
 */

// C program of above approach
#include <stdio.h>
#include <string.h>

// A utility function to get max of two int egers
int max(int x, int y) { return(x > y) ? x : y; }

// Returns the length of the long est palindromic subsequence
// in seq
int lps(char* seq, int i, int j)
{
    // Base Case 1: If there is only 1 char acter
    if(i == j)
        return 1;

    // Base Case 2: If there are only 2 char acters and both
    // are same
    if(seq[i] == seq[j] && i + 1 == j)
        return 2;

    // If the first and last char acters match
    if(seq[i] == seq[j])
        return lps(seq, i + 1, j - 1) + 2;

    // If the first and last char acters do not match
    return max(lps(seq, i, j - 1), lps(seq, i + 1, j));
}

/* Driver program to test above functions */
int main()
{
    char seq[] = "GEEKSFORGEEKS";
    int n = strlen(seq);
    printf("The length of the LPS is %d",
           lps(seq, 0, n - 1));
    getchar();
    return 0;
}
