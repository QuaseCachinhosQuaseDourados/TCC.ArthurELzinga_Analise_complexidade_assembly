/* Problema: Naive algorithm for Pattern Searching
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/naive-algorithm-for-pattern-searching/
 */

// C program for Naive Pattern Searching algorithm
#include <stdio.h>
#include <string.h>

voidsearch(char* pat, char* txt)
{
    intM = strlen(pat);
    intN = strlen(txt);

    /* A loop to slide pat[] one by one */
    for(inti = 0; i <= N - M; i++) {
        intj;

        /* For current index i, check for pattern match */
        for(j = 0; j < M; j++)
            if(txt[i + j] != pat[j])
                break;

        if(j
            == M) // if pat[0...M-1] = txt[i, i+1, ...i+M-1]
            printf("Pattern found at index %d \n", i);
    }
}

// Driver's code
intmain()
{
    chartxt[] = "AABAACAADAABAAABAA";
    charpat[] = "AABA";
  
      // Function call
    search(pat, txt);
    return0;
}
