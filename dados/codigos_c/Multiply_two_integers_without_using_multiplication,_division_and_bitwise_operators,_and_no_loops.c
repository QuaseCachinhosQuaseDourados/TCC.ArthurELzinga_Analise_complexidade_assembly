/* Problema: Multiply two integers without using multiplication, division and bitwise operators, and no loops
 * Complexidade de Tempo: O(y)
 * Complexidade de Espaco: O(y)
 * Fonte: https://www.geeksforgeeks.org/multiply-two-numbers-without-using-multiply-division-bitwise-operators-and-no-loops/
 */

#include<stdio.h>
/* function to multiply two numbers x and y*/
intmultiply(intx, inty)
{
   /* 0  multiplied with anything gives 0 */
   if(y == 0)
     return0;

   /* Add x one by one */
   if(y > 0 )
     return(x + multiply(x, y-1));
 
  /* the case where y is negative */
   if(y < 0 )
     return-multiply(x, -y);
}

intmain()
{
  printf("\n %d", multiply(5, -11));
  getchar();
  return0;
}
