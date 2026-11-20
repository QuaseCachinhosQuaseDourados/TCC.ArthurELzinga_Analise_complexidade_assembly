/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

#include <stdio.h>

voidfindMissing(intarr[], intN)
{
    inttemp[N + 1];
    for(inti = 0; i <= N; i++) {
        temp[i] = 0;
    }

    for(inti = 0; i < N; i++) {
        temp[arr[i] - 1] = 1;
    }

    intans;
    for(inti = 0; i <= N; i++) {
        if(temp[i] == 0)
            ans = i + 1;
    }
    printf("%d", ans);
}

/* Driver code */
intmain()
{
    intarr[] = { 1, 3, 7, 5, 6, 2 };
    intn = sizeof(arr) / sizeof(arr[0]);
    findMissing(arr, n);
}

// This code is contributed by nikhilm2302
