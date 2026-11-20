/* Problema: Little and Big Endian Mystery
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/little-and-big-endian-mystery/
 */

#include <stdio.h>
int main() 
{
   unsigned int i = 1;
   char*c = (char*)&i
   if(*c)    
       printf("Little endian");
   else
       printf("Big endian");
   getchar();
   return 0;
}
