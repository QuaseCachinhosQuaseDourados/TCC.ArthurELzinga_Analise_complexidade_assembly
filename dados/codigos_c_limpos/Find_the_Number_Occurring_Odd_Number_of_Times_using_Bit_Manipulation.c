/* Problema: Find the Number Occurring Odd Number of Times using Bit Manipulation:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-number-occurring-odd-number-of-times/
 */

// C program to find the element
// occurring odd number of times
#include <stdio.h>

// Function to find element occurring
// odd number of times
int getOddOccurrence(int ar[], int ar_size)
{
    int res = 0; 
    for(int i = 0; i < ar_size; i++)     
        res = res ^ ar[i];
    
    return res;
}

/* Driver function to test above function */
int main()
{
    int ar[] = {2, 3, 5, 4, 5, 2, 4, 3, 5, 2, 4, 4, 2};
    int n = sizeof(ar) / sizeof(ar[0]);
    
    // Function calling
    printf("%d", getOddOccurrence(ar, n));
    return 0;
}
