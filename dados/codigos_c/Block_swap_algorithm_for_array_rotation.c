/* Problema: Block swap algorithm for array rotation
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(log n)
 * Fonte: https://www.geeksforgeeks.org/block-swap-algorithm-for-array-rotation/
 */

#include<stdio.h> 
 
/*Prototype for utility functions */
voidprintArray(intarr[], intsize); 
voidswap(intarr[], intfi, intsi, intd); 
 
voidleftRotate(intarr[], intd, intn) 
{  
  /* Return If number of elements to be rotated is  
    zero or equal to array size */
  if(d == 0 || d == n) 
    return; 
     
  /*If number of elements to be rotated is exactly  
    half of array size */
  if(n-d == d) 
  { 
    swap(arr, 0, n-d, d);    
    return; 
  }   
     
 /* If A is shorter*/
  if(d < n-d) 
  {   
    swap(arr, 0, n-d, d); 
    leftRotate(arr, d, n-d);     
  }     
  else/* If B is shorter*/
  { 
    swap(arr, 0, d, n-d); 
    leftRotate(arr+n-d, 2*d-n, d); /*This is tricky*/
  } 
} 
 
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
   for(i = 0; i<d; i++)    
   { 
     temp = arr[fi + i]; 
     arr[fi + i] = arr[si + i]; 
     arr[si + i] = temp; 
   }      
}      
 
/* Driver program to test above functions */
intmain() 
{ 
   intarr[] = {1, 2, 3, 4, 5, 6, 7}; 
   leftRotate(arr, 2, 7); 
   printArray(arr, 7); 
   getchar(); 
   return0; 
}     
