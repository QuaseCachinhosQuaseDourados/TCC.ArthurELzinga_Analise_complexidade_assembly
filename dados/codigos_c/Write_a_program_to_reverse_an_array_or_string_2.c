/* Problema: Write a program to reverse an array or string
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/write-a-program-to-reverse-an-array-or-string/
 */

// Recursive C program to reverse an array 
#include <stdio.h> 
 
/* Function to reverse arr[] from start to end*/
voidrvereseArray(intarr[], intstart, intend) 
{ 
   inttemp; 
   if(start >= end) 
     return; 
   temp = arr[start];    
   arr[start] = arr[end]; 
   arr[end] = temp; 
   rvereseArray(arr, start+1, end-1);    
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
    printArray(arr, 6); 
    rvereseArray(arr, 0, 5); 
    printf("Reversed array is \n"); 
    printArray(arr, 6);     
    return0; 
} 
