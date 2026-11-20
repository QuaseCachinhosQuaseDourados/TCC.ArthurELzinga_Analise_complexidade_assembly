/* Problema: Detect if two int egers have opposite signs
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/detect-if-two-int egers-have-opposite-signs/
 */

// C Program to Detect  
// if two int egers have opposite signs. 
#include<stdbool.h> 
#include<stdio.h> 
  
booloppositeSigns(int x, int y) 
{ 
    return((x ^ y) < 0); 
} 
  
int main() 
{ 
    int x = 100, y = -100; 
    if(oppositeSigns(x, y) == true) 
       printf("Signs are opposite"); 
    else
      printf("Signs are not opposite"); 
    return 0; 
}
