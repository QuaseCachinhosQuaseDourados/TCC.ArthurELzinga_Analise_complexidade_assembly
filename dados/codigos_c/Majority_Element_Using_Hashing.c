/* Problema: Majority Element Using Hashing:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

#include <stdio.h>
#include <stdlib.h>

voidfindMajority(intarr[], intsize)
{
    inti, j;
    intcount = 0;
    for(i = 0; i < size; i++)
    {
        intcurrent = arr[i];
        intfreq = 0;
        for(j = 0; j < size; j++)
        {
            if(arr[j] == current)
            {
                freq++;
            }
        }
        if(freq > size / 2)
        {
            count = 1;
            printf("Majority found :- %d\n", current);
            break;
        }
    }
    if(count == 0)
    {
        printf("No Majority element\n");
    }
}

// Driver code 
intmain() 
{ 
    intarr[] = {2, 2, 2, 2, 5, 5, 2, 3, 3}; 
    intn = sizeof(arr) / sizeof(arr[0]); 
      
    // Function calling 
    findMajority(arr, n); 
  
    return0; 
}
