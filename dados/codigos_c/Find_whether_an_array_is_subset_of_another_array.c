/* Problema: Find whether an array is subset of another array
 * Complexidade de Tempo: O(m*n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-whether-an-array-is-subset-of-another-array-set-1/
 */

// C++ program to find whether an array
// is subset of another array
#include <stdio.h>
/* Return 1 if arr2[] is a subset of
arr1[] */
intisSubset(intarr1[], intarr2[], intm, intn)
{
    inti = 0;
    intj = 0;
    for(i = 0; i < n; i++) {
        for(j = 0; j < m; j++) {
            if(arr2[i] == arr1[j])
                break;
        }

        /* If the above inner loop was
        not broken at all then arr2[i]
        is not present in arr1[] */
        if(j == m)
            return0;
    }

    /* If we reach here then all
    elements of arr2[] are present
    in arr1[] */
    return1;
}

// Driver code
intmain()
{
    intarr1[] = { 11, 1, 13, 21, 3, 7 };
    intarr2[] = { 11, 3, 7, 1 };

    intm = sizeof(arr1) / sizeof(arr1[0]);
    intn = sizeof(arr2) / sizeof(arr2[0]);

    if(isSubset(arr1, arr2, m, n))
        printf("arr2[] is subset of arr1[] ");
    else
        printf("arr2[] is not a subset of arr1[]");

    getchar();
    return0;
}
