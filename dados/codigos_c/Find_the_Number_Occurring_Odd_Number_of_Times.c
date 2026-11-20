/* Problema: Find the Number Occurring Odd Number of Times
 * Complexidade de Tempo: O(n^2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-number-occurring-odd-number-of-times/
 */

// C program to find the element
// occurring odd number of times
#include <stdio.h>

// Function to find element occurring
// odd number of times
intgetOddOccurrence(intar[], intar_size)
{
    intres = 0; 
    for(inti = 0; i < ar_size; i++)     
        res = res ^ ar[i];
    
    returnres;
}

/* Driver function to test above function */
intmain()
{
    intar[] = {2, 3, 5, 4, 5, 2, 4, 3, 5, 2, 4, 4, 2};
    intn = sizeof(ar) / sizeof(ar[0]);
    
    // Function calling
    printf("%d", getOddOccurrence(ar, n));
    return0;
}
