/* Problema: Find the first circular tour that visits all petrol pumps
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-a-tour-that-visits-all-stations/
 */

// C program to find circular tour for a truck
#include <stdio.h>

// A petrol pump has petrol and distance to next petrol pump
structpetrolPump
{
  intpetrol;
  intdistance;
};

// The function returns starting point if there is a possible solution,
// otherwise returns -1
intprintTour(structpetrolPump arr[], intn)
{
    // Consider first petrol pump as a starting point
    intstart = 0;
    intend =  1;

    intcurr_petrol = arr[start].petrol - arr[start].distance;

    /* Run a loop while all petrol pumps are not visited.
      And we have reached first petrol pump again with 0 or more petrol */
    while(end != start || curr_petrol < 0)
    {
        // If current amount of petrol in truck becomes less than 0, then
        // remove the starting petrol pump from tour
        while(curr_petrol < 0 && start != end)
        {
            // Remove starting petrol pump. Change start
            curr_petrol -= arr[start].petrol - arr[start].distance;
            start = (start + 1)%n;

            // If 0 is being considered as start again, then there is no
            // possible solution
            if(start == 0)
               return-1;
        }

        // Add a petrol pump to current tour
        curr_petrol += arr[end].petrol - arr[end].distance;

        end = (end + 1)%n;
    }

    // Return starting point
    returnstart;
}

// Driver program to test above functions
intmain()
{
    structpetrolPump arr[] = {{6, 4}, {3, 6}, {7, 3}};

    intn = sizeof(arr)/sizeof(arr[0]);
    intstart = printTour(arr, n);

    (start == -1)? printf("No solution"): printf("Start = %d", start);

    return0;
}
