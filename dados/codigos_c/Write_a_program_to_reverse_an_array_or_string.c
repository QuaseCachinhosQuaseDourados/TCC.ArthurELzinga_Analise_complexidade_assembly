/* Problema: Write a program to reverse an array or string
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/write-a-program-to-reverse-an-array-or-string/
 */

// Iterative C program to reverse an array 
#include<stdio.h> 
 
/* Function to reverse arr[] from start to end*/
voidrvereseArray(intarr[], intstart, intend) 
{ 
    inttemp; 
    while(start < end) 
    { 
        temp = arr[start];    
        arr[start] = arr[end]; 
        arr[end] = temp; 
        start++; 
        end--; 
    }    
}      
 
/* Utility that prints out an array on a line */
voidprintArray(intarr[], intsize) 
{ 
  inti; 
  for(i=0; i < size; i++) 
    printf("%d ", arr[i]); 
 
  printf("\n"); 
}  
 
/* Driver function to test above functions */
intmain()  
{ 
    intarr[] = {1, 2, 3, 4, 5, 6}; 
    intn = sizeof(arr) / sizeof(arr[0]);  
    printArray(arr, n); 
    rvereseArray(arr, 0, n-1); 
    printf("Reversed array is \n"); 
    printArray(arr, n);     
    return0; 
} 
