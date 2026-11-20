/* Problema: Leaders in an array
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/leaders-in-an-array/
 */

#include <stdio.h>

/* C Function to print leaders in an array */
voidprintLeaders(intarr[], intsize)
{
    intmax_from_right = arr[size - 1];

    /* Rightmost element is always leader */
    printf("%d ", max_from_right);

    for(inti = size - 2; i >= 0; i--) {
        if(max_from_right < arr[i]) {
            max_from_right = arr[i];
            printf("%d ", max_from_right);
        }
    }
}

/* Driver program to test above function*/
intmain()
{
    intarr[] = { 16, 17, 4, 3, 5, 2 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printLeaders(arr, n);
    return0;
}
