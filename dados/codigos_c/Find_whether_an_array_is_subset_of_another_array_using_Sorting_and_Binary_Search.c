/* Problema: Find whether an array is subset of another array using Sorting and Binary Search
 * Complexidade de Tempo: O(mLog(m) + nlog(m))
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/find-whether-an-array-is-subset-of-another-array-set-1/
 */

// C program to find whether an array
// is subset of another array
#include <stdbool.h>
#include <stdio.h>
/* Function prototypes */
voidquickSort(int* arr, intsi, intei);
intbinarySearch(intarr[], intlow, inthigh, intx);

/* Return 1 if arr2[] is a subset of arr1[] */
boolisSubset(intarr1[], intarr2[], intm, intn)
{
    inti = 0;

    quickSort(arr1, 0, m - 1);
    for(i = 0; i < n; i++) {
        if(binarySearch(arr1, 0, m - 1, arr2[i]) == -1)
            return0;
    }

    /* If we reach here then all elements of arr2[]
      are present in arr1[] */
    return1;
}

/* FOLLOWING FUNCTIONS ARE ONLY FOR SEARCHING
AND SORTING PURPOSE */
/* Standard Binary Search function*/
intbinarySearch(intarr[], intlow, inthigh, intx)
{
    if(high >= low) {
        /*low + (high - low)/2;*/
        intmid = (low + high) / 2;

        /* Check if arr[mid] is the first
        occurrence of x.
        arr[mid] is first occurrence if x is
        one of the following
        is true:
        (i)  mid == 0 and arr[mid] == x
        (ii) arr[mid-1] < x and arr[mid] == x
     */
        if((mid == 0 || x > arr[mid - 1])
            && (arr[mid] == x))
            returnmid;
        elseif(x > arr[mid])
            returnbinarySearch(arr, (mid + 1), high, x);
        else
            returnbinarySearch(arr, low, (mid - 1), x);
    }
    return-1;
}

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

/*Driver code */
intmain()
{
    intarr1[] = { 11, 1, 13, 21, 3, 7 };
    intarr2[] = { 11, 3, 7, 1 };

    intm = sizeof(arr1) / sizeof(arr1[0]);
    intn = sizeof(arr2) / sizeof(arr2[0]);

    if(isSubset(arr1, arr2, m, n))
        printf("arr2[] is subset of arr1[] ");
    else
        printf("arr2[] is not a subset of arr1[] ");

    return0;
}
