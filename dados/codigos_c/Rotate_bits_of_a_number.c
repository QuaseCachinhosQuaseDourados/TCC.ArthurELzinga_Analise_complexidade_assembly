/* Problema: Rotate bits of a number
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/rotate-bits-of-an-integer/
 */

#include<stdio.h>
#define INT_BITS 32

/*Function to left rotate n by d bits*/
intleftRotate(intn, unsigned intd)
{
   /* In n<<d, last d bits are 0. To put first 3 bits of n at 
     last, do bitwise or of n<<d with n >>(INT_BITS - d) */
   return(n << d)|(n >> (INT_BITS - d));
}

/*Function to right rotate n by d bits*/
intrightRotate(intn, unsigned intd)
{
   /* In n>>d, first d bits are 0. To put last 3 bits of at 
     first, do bitwise or of n>>d with n <<(INT_BITS - d) */
   return(n >> d)|(n << (INT_BITS - d));
}

/* Driver program to test above functions */
intmain()
{
  intn = 16;
  intd = 2;
  printf("Left Rotation of %d by %d is ", n, d);
  printf("%d", leftRotate(n, d));
  printf("\nRight Rotation of %d by %d is ", n, d);
  printf("%d", rightRotate(n, d));
  getchar();
} 
