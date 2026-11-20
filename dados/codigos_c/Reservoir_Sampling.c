/* Problema: Reservoir Sampling
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(k)
 * Fonte: https://www.geeksforgeeks.org/reservoir-sampling/
 */

// An efficient program to randomly select k items from a stream of items

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// A utility function to print an array
voidprintArray(intstream[], intn)
{
    for(inti = 0; i < n; i++)
        printf("%d ", stream[i]);
    printf("\n");
}

// A function to randomly select k items from stream[0..n-1].
voidselectKItems(intstream[], intn, intk)
{
    inti;  // index for elements in stream[]

    // reservoir[] is the output array. Initialize it with
    // first k elements from stream[]
    intreservoir[k];
    for(i = 0; i < k; i++)
        reservoir[i] = stream[i];

    // Use a different seed value so that we don't get
    // same result each time we run this program
    srand(time(NULL));

    // Iterate from the (k+1)th element to nth element
    for(; i < n; i++)
    {
        // Pick a random index from 0 to i.
        intj = rand() % (i+1);

        // If the randomly  picked index is smaller than k, then replace
        // the element present at the index with new element from stream
        if(j < k)
          reservoir[j] = stream[i];
    }

    printf("Following are k randomly selected items \n");
    printArray(reservoir, k);
}

// Driver program to test above function.
intmain()
{
    intstream[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    intn = sizeof(stream)/sizeof(stream[0]);
    intk = 5;
    selectKItems(stream, n, k);
    return0;
}
