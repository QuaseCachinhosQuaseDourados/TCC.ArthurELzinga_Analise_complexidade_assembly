/* Problema: Search an element in a sorted and rotated  Array
 * Complexidade de Tempo: O(log N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/search-an-element-in-a-sorted-and-pivoted-array/
 */

/* Program to search an element in
   a sorted and pivoted array*/
#include <stdio.h>

intfindPivot(int[], int, int);
intbinarySearch(int[], int, int, int);

/* Searches an element key in a pivoted
   sorted array arrp[] of size n */
intpivotedBinarySearch(intarr[], intn, intkey)
{
    intpivot = findPivot(arr, 0, n - 1);

    // If we didn't find a pivot,
    // then array is not rotated at all
    if(pivot == -1)
        returnbinarySearch(arr, 0, n - 1, key);

    // If we found a pivot, then first
    // compare with pivot and then
    // search in two subarrays around pivot
    if(arr[pivot] == key)
        returnpivot;
    if(arr[0] <= key)
        returnbinarySearch(arr, 0, pivot - 1, key);
    returnbinarySearch(arr, pivot + 1, n - 1, key);
}

/* Function to get pivot. For array
   3, 4, 5, 6, 1, 2 it returns 3 (index of 6) */
intfindPivot(intarr[], intlow, inthigh)
{
    // base cases
    if(high < low)
        return-1;
    if(high == low)
        returnlow;

    intmid = (low + high) / 2; /*low + (high - low)/2;*/
    if(mid < high && arr[mid] > arr[mid + 1])
        returnmid;
    if(mid > low && arr[mid] < arr[mid - 1])
        return(mid - 1);
    if(arr[low] >= arr[mid])
        returnfindPivot(arr, low, mid - 1);
    returnfindPivot(arr, mid + 1, high);
}

/* Standard Binary Search function*/
intbinarySearch(intarr[], intlow, inthigh, intkey)
{
    if(high < low)
        return-1;
    intmid = (low + high) / 2; /*low + (high - low)/2;*/
    if(key == arr[mid])
        returnmid;
    if(key > arr[mid])
        returnbinarySearch(arr, (mid + 1), high, key);
    returnbinarySearch(arr, low, (mid - 1), key);
}

/* Driver program to check above functions */
intmain()
{
    // Let us search 3 in below array
    intarr1[] = { 5, 6, 7, 8, 9, 10, 1, 2, 3 };
    intn = sizeof(arr1) / sizeof(arr1[0]);
    intkey = 3;
    printf("Index of the element is : %d",
           pivotedBinarySearch(arr1, n, key));
    return0;
}
