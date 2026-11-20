/* Problema: Detect if two integers have opposite signs
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/detect-if-two-integers-have-opposite-signs/
 */

// C Program to Detect  
// if two integers have opposite signs. 
#include<stdbool.h> 
#include<stdio.h> 
  
booloppositeSigns(intx, inty) 
{ 
    return((x ^ y) < 0); 
} 
  
intmain() 
{ 
    intx = 100, y = -100; 
    if(oppositeSigns(x, y) == true) 
       printf("Signs are opposite"); 
    else
      printf("Signs are not opposite"); 
    return0; 
}
