/* Problema: Majority Element Using Hashing:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

#include <stdio.h>
#include <stdlib.h>

void findMajority(int arr[], int size)
{
    int i, j;
    int count = 0;
    for(i = 0; i < size; i++)
    {
        int current = arr[i];
        int freq = 0;
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
int main() 
{ 
    int arr[] = {2, 2, 2, 2, 5, 5, 2, 3, 3}; 
    int n = sizeof(arr) / sizeof(arr[0]); 
      
    // Function calling 
    findMajority(arr, n); 
  
    return 0; 
}
