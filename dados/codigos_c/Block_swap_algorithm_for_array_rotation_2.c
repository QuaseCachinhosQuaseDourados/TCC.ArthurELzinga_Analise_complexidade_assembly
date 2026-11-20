/* Problema: Block swap algorithm for array rotation
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/block-swap-algorithm-for-array-rotation/
 */

// C code for above implementation 
 
#include <stdio.h> 
 
/*UTILITY FUNCTIONS*/
/* function to print an array */
voidprintArray(intarr[], intsize) 
{ 
    inti; 
    for(i = 0; i < size; i++) 
        printf("%d ", arr[i]); 
    printf("\n "); 
} 
 
/*This function swaps d elements starting at index fi 
  with d elements starting at index si */
voidswap(intarr[], intfi, intsi, intd) 
{ 
    inti, temp; 
    for(i = 0; i < d; i++) { 
        temp = arr[fi + i]; 
        arr[fi + i] = arr[si + i]; 
        arr[si + i] = temp; 
    } 
} 
 
voidleftRotate(intarr[], intd, intn) 
{ 
    inti, j; 
    if(d == 0 || d == n) 
        return; 
    /* If number of elements to be rotated is more than 
     * array size*/
    if(d > n) 
        d = d % n; 
    i = d; 
    j = n - d; 
    while(i != j) { 
        if(i < j) /*A is shorter*/
        { 
            swap(arr, d - i, d + j - i, i); 
            j -= i; 
        } 
        else/*B is shorter*/
        { 
            swap(arr, d - i, d, j); 
            i -= j; 
        } 
        // printArray(arr, 7); 
    } 
    /*Finally, block swap A and B*/
    swap(arr, d - i, d, i); 
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
