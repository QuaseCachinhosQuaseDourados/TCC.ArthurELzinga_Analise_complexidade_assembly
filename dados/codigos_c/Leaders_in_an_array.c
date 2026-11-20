/* Problema: Leaders in an array
 * Complexidade de Tempo: O(N * N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/leaders-in-an-array/
 */

/*C Function to print leaders in an array */

#include <stdio.h>

voidprintLeaders(intarr[], intsize)
{
    inti, j;
    for(i = 0; i < size; i++) {
        for(j = i + 1; j < size; j++) {
            if(arr[i] <= arr[j])
                break;
        }
        if(j == size) // the loop didn't break
            printf("%d ", arr[i]);
    }
}

/* Driver program to test above function */
intmain()
{
    intarr[] = { 16, 17, 4, 3, 5, 2 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printLeaders(arr, n);
    return0;
}
