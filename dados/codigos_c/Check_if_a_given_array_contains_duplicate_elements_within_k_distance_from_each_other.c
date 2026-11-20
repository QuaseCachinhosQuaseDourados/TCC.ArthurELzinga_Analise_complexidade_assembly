/* Problema: Check if a given array contains duplicate elements within k distance from each other
 * Complexidade de Tempo: O(N*K)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/check-given-array-contains-duplicate-elements-within-k-distance/
 */

// C program to Check if a given array contains duplicate
// elements within k distance from each other

#include <stdbool.h>
#include <stdio.h>

boolcheckDuplicatesWithinK(intarr[], intn, intk)
{
    // traversing the input array
    for(inti = 0; i < n; i++) {
        intj = i + 1;
        intrange = k;
        // searching in next k-1 elements if its duplicate
        // is present or not
        while(range > 0 && j < n) {
            if(arr[i] == arr[j])
                returntrue;
            j++;
            range--;
        }
    }
    returnfalse;
}

// Driver method to test above method
intmain()
{
    intarr[] = { 10, 5, 3, 4, 3, 5, 6 };
    intn = sizeof(arr) / sizeof(arr[0]);
    if(checkDuplicatesWithinK(arr, n, 3))
        printf("Yes");
    else
        printf("No");
}

// This code is contributed by Aditya Kumar (adityakumar129)
