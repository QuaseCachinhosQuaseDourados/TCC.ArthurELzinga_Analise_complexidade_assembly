/* Problema: Two Sum using Sorting and Two-Pointers technique:
 * Complexidade de Tempo: O(NlogN)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/check-if-pair-with-given-sum-exists-in-array/
 */

// C program to check if given array
// has 2 elements whose sum is equal
// to the given value

#include <stdio.h>
#define bool int

voidquickSort(int*, int, int);

boolhasArrayTwoCandidates(intA[], intarr_size, intsum)
{
    intl, r;

    /* Sort the elements */
    quickSort(A, 0, arr_size - 1);

    /* Now look for the two candidates in the sorted
       array*/
    l = 0;
    r = arr_size - 1;
    while(l < r) {
        if(A[l] + A[r] == sum)
            return1;
        elseif(A[l] + A[r] < sum)
            l++;
        else// A[i] + A[j] > sum
            r--;
    }
    return0;
}

/* FOLLOWING FUNCTIONS ARE ONLY FOR SORTING
    PURPOSE */
voidexchange(int* a, int* b)
{
    inttemp;
    temp = *a;
    *a = *b;
    *b = temp;
}

intpartition(intA[], intsi, intei)
{
    intx = A[ei];
    inti = (si - 1);
    intj;

    for(j = si; j <= ei - 1; j++) {
        if(A[j] <= x) {
            i++;
            exchange(&A[i], &A[j]);
        }
    }
    exchange(&A[i + 1], &A[ei]);
    return(i + 1);
}

/* Implementation of Quick Sort
A[] --> Array to be sorted
si  --> Starting index
ei  --> Ending index
*/
voidquickSort(intA[], intsi, intei)
{
    intpi; /* Partitioning index */
    if(si < ei) {
        pi = partition(A, si, ei);
        quickSort(A, si, pi - 1);
        quickSort(A, pi + 1, ei);
    }
}

/* Driver program to test above function */
intmain()
{
    intA[] = { 1, 4, 45, 6, 10, -8 };
    intn = 16;
    intarr_size = 6;

    if(hasArrayTwoCandidates(A, arr_size, n))
        printf("Yes");
    else
        printf("No");

    getchar();
    return0;
}
