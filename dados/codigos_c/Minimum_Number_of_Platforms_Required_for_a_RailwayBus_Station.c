/* Problema: Minimum Number of Platforms Required for a Railway/Bus Station
 * Complexidade de Tempo: O(n2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/minimum-number-platforms-required-railwaybus-station/
 */

// C program to find minimum number of platforms required on
// a railway station

// Importing the required header files
#include <stdio.h>

// Creating MACRO for finding the maximum number
#define max(x, y) (((x) > (y)) ? (x) : (y))

// Function to find the minimum number of platforms
// required
intfindPlatform(intarr[], intdep[], intn)
{
    // plat_needed indicates number of platforms
    // needed at a time
    intplat_needed = 1, result = 1;

    // Run a nested for-loop to find the overlap
    for(inti = 0; i < n; i++) {

        // Initially one platform is needed
        plat_needed = 1;
        for(intj = 0; j < n; j++) {
            if(i != j)
                // Increment plat_needed when there is an
                // overlap
                if(arr[i] >= arr[j] && dep[j] >= arr[i])
                    plat_needed++;
        }

        // Update the result
        result = max(plat_needed, result);
    }
    returnresult;
}

// Driver Code
intmain()
{
    // Train 1 => Arrival : 01:00, Departure : 09:00
    // Train 2 => Arrival : 03:00, Departure : 04:00
    // Train 3 => Arrival : 05:00, Departure : 06:00
    intarr[] = { 100, 300, 500 };
    intdep[] = { 900, 400, 600 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printf("%d", findPlatform(arr, dep, n));
    return0;
}
