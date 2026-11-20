/* Problema: Next Greater Element (NGE) for every element in given Array
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/next-greater-element/
 */

// Simple C program to print next greater elements
// in a given array
#include <stdio.h>

/* prints element and NGE pair for all elements of
arr[] of size n */
voidprintNGE(intarr[], intn)
{
    intnext, i, j;
    for(i = 0; i < n; i++) {
        next = -1;
        for(j = i + 1; j < n; j++) {
            if(arr[i] < arr[j]) {
                next = arr[j];
                break;
            }
        }
        printf("%d -- %dn", arr[i], next);
    }
}

intmain()
{
    intarr[] = { 11, 13, 21, 3 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printNGE(arr, n);
    return0;
}
