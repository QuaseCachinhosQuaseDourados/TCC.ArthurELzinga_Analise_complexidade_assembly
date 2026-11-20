/* Problema: Reversal algorithm for Array rotation
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/program-for-array-rotation-continued-reversal-algorithm/
 */

// C/C++ program for reversal algorithm of array rotation
#include <stdio.h>

/*Utility function to print an array */
voidprintArray(intarr[], intsize);

/* Utility function to reverse arr[] from start to end */
voidreverseArray(intarr[], intstart, intend);

/* Function to left rotate arr[] of size n by d */
voidleftRotate(intarr[], intd, intn)
{

    if(d == 0)
        return;
    // in case the rotating factor is
    // greater than array length
    d = d % n;

    reverseArray(arr, 0, d - 1);
    reverseArray(arr, d, n - 1);
    reverseArray(arr, 0, n - 1);
}

/*UTILITY FUNCTIONS*/
/* function to print an array */
voidprintArray(intarr[], intsize)
{
    inti;
    for(i = 0; i < size; i++)
        printf("%d ", arr[i]);
}

/*Function to reverse arr[] from index start to end*/
voidreverseArray(intarr[], intstart, intend)
{
    inttemp;
    while(start < end) {
        temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

/* Driver program to test above functions */
intmain()
{
    intarr[] = { 1, 2, 3, 4, 5, 6, 7 };
    intn = sizeof(arr) / sizeof(arr[0]);
    intd = 2;

    leftRotate(arr, d, n);
    printArray(arr, n);
    return0;
}
