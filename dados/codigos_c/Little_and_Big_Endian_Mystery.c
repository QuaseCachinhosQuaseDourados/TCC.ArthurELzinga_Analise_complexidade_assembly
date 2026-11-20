/* Problema: Little and Big Endian Mystery
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/little-and-big-endian-mystery/
 */

#include <stdio.h>
 
/* function to show bytes in memory, from location start to start+n*/
voidshow_mem_rep(char*start, intn)
{
    inti;
    for(i = 0; i < n; i++)
         printf(" %.2x", start[i]);
    printf("\n");
}
 
/*Main function to call above function for 0x01234567*/
intmain()
{
   inti = 0x01234567;
   show_mem_rep((char*)&i, sizeof(i));
   getchar();
   return0;
}
