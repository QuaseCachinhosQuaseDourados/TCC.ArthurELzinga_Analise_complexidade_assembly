/* Problema: Leaders in an array
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/leaders-in-an-array/
 */

#include <stdio.h>
#include <stdlib.h>

/* C Function to print leaders in an array */
voidprintLeaders(intarr[], intsize)
{
    /* create stack to store leaders*/
    int* sk = (int*)malloc(size * sizeof(int));
    inttop = -1;
    sk[++top] = arr[size - 1];

    for(inti = size - 2; i >= 0; i--) {
        if(arr[i] >= sk[top]) {
            sk[++top] = arr[i];
        }
    }

    /* print stack elements*/
    /* run loop till stack is not empty*/
    while(top != -1) {
        printf("%d ", sk[top--]);
    }
    free(sk);
}

/* Driver program to test above function*/
intmain()
{
    intarr[] = { 16, 17, 4, 3, 5, 2 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printLeaders(arr, n);
    return0;
}
