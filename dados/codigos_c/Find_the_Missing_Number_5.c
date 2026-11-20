/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

// C program to find the missing Number

#include <stdio.h>

// Function to find the missing number
intgetMissingNo(inta[], intn)
{
    inti = 0;
    while(i < n) {
        intcorrect = a[i] - 1;
        if(a[i] < n && a[i] != a[correct]) {
            inttemp = a[i];
            a[i] = a[correct];
            a[correct] = temp;
        }
        else{
            i++;
        }
    }

    for(inti = 0; i < n; i++) {
        if(i != a[i] - 1) {
            returni + 1;
        }
    }

    returnn;
}

// Driver code
intmain()
{
    intarr[] = { 1, 2, 3, 5 };
    intN = sizeof(arr) / sizeof(arr[0]);

    // Function call
    intmiss = getMissingNo(arr, N);
    printf("%d", miss);
    return0;
}
