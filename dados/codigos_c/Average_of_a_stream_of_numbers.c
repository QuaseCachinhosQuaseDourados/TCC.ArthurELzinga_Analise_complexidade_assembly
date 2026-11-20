/* Problema: Average of a stream of numbers
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/average-of-a-stream-of-numbers/
 */

#include <stdio.h>

// Returns the new average after including x
floatgetAvg(intx)
{
    staticintsum, n;

    sum += x;
    return(((float)sum) / ++n);
}

// Prints average of a stream of numbers
voidstreamAvg(floatarr[], intn)
{
    floatavg = 0;
    for(inti = 0; i < n; i++) {
        avg = getAvg(arr[i]);
        printf("Average of %d numbers is %f \n", i + 1, avg);
    }
    return;
}

// Driver program to test above functions
intmain()
{
    floatarr[] = { 10, 20, 30, 40, 50, 60 };
    intn = sizeof(arr) / sizeof(arr[0]);
    streamAvg(arr, n);

    return0;
}
