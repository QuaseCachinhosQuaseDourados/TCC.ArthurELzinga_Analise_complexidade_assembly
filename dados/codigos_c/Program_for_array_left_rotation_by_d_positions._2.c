/* Problema: Program for array left rotation by d positions.
 * Complexidade de Tempo: O(N*d)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/array-rotation/
 */

// C program to rotate an array by
// d elements
#include <stdio.h>

/* function to print an array */
voidprintArray(intarr[], intsize);

/*Function to get gcd of a and b*/
intgcd(inta, intb);

/*Function to left rotate arr[] of size n by d*/
voidleftRotate(intarr[], intd, intn)
{
    inti, j, k, temp;
    /* To handle if d >= n */
    d = d % n;
    intg_c_d = gcd(d, n);
    for(i = 0; i < g_c_d; i++) {
        /* move i-th values of blocks */
        temp = arr[i];
        j = i;
        while(1) {
            k = j + d;
            if(k >= n)
                k = k - n;
            if(k == i)
                break;
            arr[j] = arr[k];
            j = k;
        }
        arr[j] = temp;
    }
}

/*UTILITY FUNCTIONS*/
/* function to print an array */
voidprintArray(intarr[], intn)
{
    inti;
    for(i = 0; i < n; i++)
        printf("%d ", arr[i]);
}

/*Function to get gcd of a and b*/
intgcd(inta, intb)
{
    if(b == 0)
        returna;
    else
        returngcd(b, a % b);
}

/* Driver program to test above functions */
intmain()
{
    intarr[] = { 1, 2, 3, 4, 5, 6, 7 };
    leftRotate(arr, 2, 7);
    printArray(arr, 7);
    getchar();
    return0;
}
