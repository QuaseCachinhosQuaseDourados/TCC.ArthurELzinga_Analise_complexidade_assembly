/* Problema: Permutations of given String
 * Complexidade de Tempo: O(N * N!)
 * Complexidade de Espaco: O(N * N!)
 * Fonte: https://www.geeksforgeeks.org/write-a-c-program-to-print-all-permutations-of-a-given-string/
 */

// C program to print all permutations with duplicates 
// allowed 
#include <stdio.h> 
#include <string.h> 
 
/* Function to swap values at two pointers */
voidswap(char* x, char* y) 
{ 
    chartemp; 
    temp = *x; 
    *x = *y; 
    *y = temp; 
} 
 
/* Function to print permutations of string 
This function takes three parameters: 
1. String 
2. Starting index of the string 
3. Ending index of the string. */
voidpermute(char* a, intl, intr) 
{ 
    inti; 
    if(l == r) 
        printf("%s\n", a); 
    else{ 
        for(i = l; i <= r; i++) { 
            swap((a + l), (a + i)); 
            permute(a, l + 1, r); 
            swap((a + l), (a + i)); // backtrack 
        } 
    } 
} 
 
/* Driver code */
intmain() 
{ 
    charstr[] = "ABC"; 
    intn = strlen(str); 
    permute(str, 0, n - 1); 
    return0; 
}
