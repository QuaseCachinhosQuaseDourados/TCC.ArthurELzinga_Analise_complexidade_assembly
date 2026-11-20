/* Problema: Rabin-Karp Algorithm for Pattern Searching
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/rabin-karp-algorithm-for-pattern-searching/
 */

/* Following program is a C implementation of Rabin Karp
Algorithm given in the CLRS book */
#include <stdio.h>
#include <string.h>

// d is the number of characters in the input alphabet
#define d 256

/* pat -> pattern
    txt -> text
    q -> A prime number
*/
voidsearch(charpat[], chartxt[], intq)
{
    intM = strlen(pat);
    intN = strlen(txt);
    inti, j;
    intp = 0; // hash value for pattern
    intt = 0; // hash value for txt
    inth = 1;

    // The value of h would be "pow(d, M-1)%q"
    for(i = 0; i < M - 1; i++)
        h = (h * d) % q;

    // Calculate the hash value of pattern and first
    // window of text
    for(i = 0; i < M; i++) {
        p = (d * p + pat[i]) % q;
        t = (d * t + txt[i]) % q;
    }

    // Slide the pattern over text one by one
    for(i = 0; i <= N - M; i++) {

        // Check the hash values of current window of text
        // and pattern. If the hash values match then only
        // check for characters one by one
        if(p == t) {
            /* Check for characters one by one */
            for(j = 0; j < M; j++) {
                if(txt[i + j] != pat[j])
                    break;
            }

            // if p == t and pat[0...M-1] = txt[i, i+1,
            // ...i+M-1]
            if(j == M)
                printf("Pattern found at index %d \n", i);
        }

        // Calculate hash value for next window of text:
        // Remove leading digit, add trailing digit
        if(i < N - M) {
            t = (d * (t - txt[i] * h) + txt[i + M]) % q;

            // We might get negative value of t, converting
            // it to positive
            if(t < 0)
                t = (t + q);
        }
    }
}

/* Driver Code */
intmain()
{
    chartxt[] = "GEEKS FOR GEEKS";
    charpat[] = "GEEK";

    // A prime number
    intq = 101;

    // function call
    search(pat, txt, q);
    return0;
}
