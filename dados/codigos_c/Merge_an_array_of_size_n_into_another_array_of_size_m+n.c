/* Problema: Merge an array of size n into another array of size m+n
 * Complexidade de Tempo: O(m+n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/merge-one-array-of-size-n-into-another-one-of-size-mn/
 */

// C program to Merge an array of  
// size n into another array of size m + n 
#include <stdio.h> 
 
/* Assuming -1 is filled for  
   the places where element 
   is not available */
#define NA -1 
 
/* Function to move m elements  
   at the end of array mPlusN[] 
 */
voidmoveToEnd(intmPlusN[], intsize) 
{ 
    inti = 0, j = size - 1; 
    for(i = size - 1; i >= 0; i--) 
        if(mPlusN[i] != NA) { 
            mPlusN[j] = mPlusN[i]; 
            j--; 
        } 
} 
 
/* Merges array N[] of size n into array mPlusN[] 
   of size m+n*/
voidmerge(intmPlusN[], intN[], intm, intn) 
{ 
    inti = n; /* Current index of i/p part of mPlusN[]*/
    intj = 0; /* Current index of N[]*/
    intk = 0; /* Current index of output mPlusN[]*/
    while(k < (m + n))  
    { 
        /* Take an element from mPlusN[] if 
           a) value of the picked element is smaller and we 
           have not reached end of it 
           b) We have reached end of N[] */
        if((j == n)|| (i < (m + n) 
             && mPlusN[i] <= N[j]))  
        { 
            mPlusN[k] = mPlusN[i]; 
            k++; 
            i++; 
        } 
        else// Otherwise take element from N[] 
        { 
            mPlusN[k] = N[j]; 
            k++; 
            j++; 
        } 
    } 
} 
 
/* Utility that prints out an array on a line */
voidprintArray(intarr[], intsize) 
{ 
    inti; 
    for(i = 0; i < size; i++) 
        printf("%d ", arr[i]); 
 
    printf("\n"); 
} 
 
/* Driver code */
intmain() 
{ 
    /* Initialize arrays */
    intmPlusN[] = { 2, 8, NA, NA, NA, 13, NA, 15, 20 }; 
    intN[] = { 5, 7, 9, 25 }; 
    intn = sizeof(N) / sizeof(N[0]); 
    intm = sizeof(mPlusN) / sizeof(mPlusN[0]) - n; 
 
    /*Move the m elements at the end of mPlusN*/
    moveToEnd(mPlusN, m + n); 
 
    /*Merge N[] into mPlusN[] */
    merge(mPlusN, N, m, n); 
 
    /* Print the resultant mPlusN */
    printArray(mPlusN, m + n); 
 
    return0; 
}
