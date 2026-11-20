/* Problema: Check if pair with given Sum exists in Array (Two Sum)
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/check-if-pair-with-given-sum-exists-in-array/
 */

/*
 * This C program tells if there exists a pair in array
 * whose sum results in x.
 */

#include <stdio.h>

// Function to find and print pair
intchkPair(intA[], intsize, intx)
{
    for(inti = 0; i < (size - 1); i++) {
        for(intj = (i + 1); j < size; j++) {
            if(A[i] + A[j] == x) {
                return1;
            }
        }
    }

    return0;
}

intmain(void)
{
    intA[] = { 0, -1, 2, -3, 1 };
    intx = -2;
    intsize = sizeof(A) / sizeof(A[0]);

    if(chkPair(A, size, x)) {
        printf("Yes\n");
    }
    else{
        printf("No\n");
    }

    return0;
}
// This code is contributed by Manish Kumar (mkumar2789)
