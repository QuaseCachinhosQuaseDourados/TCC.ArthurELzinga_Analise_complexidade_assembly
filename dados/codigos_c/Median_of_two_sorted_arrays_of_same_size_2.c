/* Problema: Median of two sorted arrays of same size
 * Complexidade de Tempo: O(nlogn)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/median-of-two-sorted-arrays/
 */

// C program for the above approach
#include <stdio.h>
#include <stdlib.h>

/* This function returns
median of ar1[] and ar2[].
Assumptions in this function:
Both ar1[] and ar2[]
are sorted arrays
Both have n elements */

// compare function, compares two elements
intcompare(constvoid* num1, constvoid* num2)
{
    if(*(int*)num1 > *(int*)num2)
        return1;
    else
        return-1;
}

intgetMedian(intar1[], intar2[], intn)
{
    intj = 0;
    inti = n - 1;
    while(ar1[i] > ar2[j] && j < n && i > -1) {
        inttemp = ar1[i];
        ar1[i] = ar2[j];
        ar2[j] = temp;
        i--;
        j++;
    }

    qsort(ar1, n, sizeof(int), compare);
    qsort(ar2, n, sizeof(int), compare);

    return(ar1[n - 1] + ar2[0]) / 2;
}

// Driver Code
intmain()
{
    intar1[] = { 1, 12, 15, 26, 38 };
    intar2[] = { 2, 13, 17, 30, 45 };

    intn1 = sizeof(ar1) / sizeof(ar1[0]);
    intn2 = sizeof(ar2) / sizeof(ar2[0]);
    if(n1 == n2)
        printf("Median is %d ", getMedian(ar1, ar2, n1));
    else
        printf("Doesn't work for arrays of unequal size");
    return0;
}

// This code is contributed by Deepthi
