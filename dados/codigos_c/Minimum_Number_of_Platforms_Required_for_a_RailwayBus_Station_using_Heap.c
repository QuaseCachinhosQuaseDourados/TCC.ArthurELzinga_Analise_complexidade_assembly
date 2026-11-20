/* Problema: Minimum Number of Platforms Required for a Railway/Bus Station using Heap:
 * Complexidade de Tempo: O(N*log(N))
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/minimum-number-platforms-required-railwaybus-station/
 */

// C program to find minimum number of platforms required on
// a railway station

// Importing the required header files
#include <stdio.h>
#include <stdlib.h>

// Creating MACRO for finding the maximum number
#define max(x, y) (((x) > (y)) ? (x) : (y))
// Creating MACRO for finding the minimum number
#define min(x, y) (((x) < (y)) ? (x) : (y))

// below method is needed for the sort function
// compare function, compares two elements
intcompare(constvoid* num1, constvoid* num2)
{
    if(*(int*)num1 > *(int*)num2)
        return1;
    else
        return-1;
}

// Returns minimum number of platforms required
intfindPlatform(intarr[], intdep[], intn)
{
    // Sort arrival and departure arrays
    qsort(arr, n, sizeof(int), compare);
    qsort(dep, n, sizeof(int), compare);

    // plat_needed indicates number of platforms
    // needed at a time
    intplat_needed = 1, result = 1;
    inti = 1, j = 0;

    // Similar to merge in merge sort to process
    // all events in sorted order
    while(i < n && j < n) {
        // If next event in sorted order is arrival,
        // increment count of platforms needed
        if(arr[i] <= dep[j]) {
            plat_needed++;
            i++;
        }

        // Else decrement count of platforms needed
        elseif(arr[i] > dep[j]) {
            plat_needed--;
            j++;
        }

        // Update result if needed
        if(plat_needed > result)
            result = plat_needed;
    }

    returnresult;
}

// Driver Code
intmain()
{
    intarr[] = { 900, 940, 950, 1100, 1500, 1800 };
    intdep[] = { 910, 1200, 1120, 1130, 1900, 2000 };
    intn = sizeof(arr) / sizeof(arr[0]);
    printf("%d", findPlatform(arr, dep, n));
    return0;
}
