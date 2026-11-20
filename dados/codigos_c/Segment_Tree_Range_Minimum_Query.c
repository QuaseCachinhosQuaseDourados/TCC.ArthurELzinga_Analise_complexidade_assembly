/* Problema: Segment Tree | Range Minimum Query
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/segment-tree-range-minimum-query/
 */

// C program for range minimum query using segment tree 
#include <stdio.h> 
#include <math.h> 
#include <limits.h> 
 
// A utility function to get minimum of two numbers 
intminVal(intx, inty) { return(x < y)? x: y; } 
 
// A utility function to get the middle index from corner indexes. 
intgetMid(ints, inte) {  returns + (e -s)/2;  } 
 
/*  A recursive function to get the minimum value in a given range 
     of array indexes. The following are parameters for this function. 
 
    st    --> Pointer to segment tree 
    index --> Index of current node in the segment tree. Initially 
              0 is passed as root is always at index 0 
    ss & se  --> Starting and ending indexes of the segment represented 
                  by current node, i.e., st[index] 
    qs & qe  --> Starting and ending indexes of query range */
intRMQUtil(int*st, intss, intse, intqs, intqe, intindex) 
{ 
    // If segment of this node is a part of given range, then return 
    //  the min of the segment 
    if(qs <= ss && qe >= se) 
        returnst[index]; 
 
    // If segment of this node is outside the given range 
    if(se < qs || ss > qe) 
        returnINT_MAX; 
 
    // If a part of this segment overlaps with the given range 
    intmid = getMid(ss, se); 
    returnminVal(RMQUtil(st, ss, mid, qs, qe, 2*index+1), 
                  RMQUtil(st, mid+1, se, qs, qe, 2*index+2)); 
} 
 
// Return minimum of elements in range from index qs (query start) to 
// qe (query end).  It mainly uses RMQUtil() 
intRMQ(int*st, intn, intqs, intqe) 
{ 
    // Check for erroneous input values 
    if(qs < 0 || qe > n-1 || qs > qe) 
    { 
        printf("Invalid Input"); 
        return-1; 
    } 
 
    returnRMQUtil(st, 0, n-1, qs, qe, 0); 
} 
 
// A recursive function that constructs Segment Tree for array[ss..se]. 
// si is index of current node in segment tree st 
intconstructSTUtil(intarr[], intss, intse, int*st, intsi) 
{ 
    // If there is one element in array, store it in current node of 
    // segment tree and return 
    if(ss == se) 
    { 
        st[si] = arr[ss]; 
        returnarr[ss]; 
    } 
 
    // If there are more than one elements, then recur for left and 
    // right subtrees and store the minimum of two values in this node 
    intmid = getMid(ss, se); 
    st[si] =  minVal(constructSTUtil(arr, ss, mid, st, si*2+1), 
                     constructSTUtil(arr, mid+1, se, st, si*2+2)); 
    returnst[si]; 
} 
 
/* Function to construct segment tree from given array. This function 
   allocates memory for segment tree and calls constructSTUtil() to 
   fill the allocated memory */
int*constructST(intarr[], intn) 
{ 
    // Allocate memory for segment tree 
 
    //Height of segment tree 
    intx = (int)(ceil(log2(n)));  
 
    // Maximum size of segment tree 
    intmax_size = 2*(int)pow(2, x) - 1;  
 
    int*st = newint[max_size];  
 
    // Fill the allocated memory st 
    constructSTUtil(arr, 0, n-1, st, 0); 
 
    // Return the constructed segment tree 
    returnst; 
} 
 
// Driver program to test above functions 
intmain() 
{ 
    intarr[] = {1, 3, 2, 7, 9, 11}; 
    intn = sizeof(arr)/sizeof(arr[0]); 
 
    // Build segment tree from given array 
    int*st = constructST(arr, n); 
 
    intqs = 1;  // Starting index of query range 
    intqe = 5;  // Ending index of query range 
 
    // Print minimum value in arr[qs..qe] 
    printf("Minimum of values in range [%d, %d] is = %d\n", 
                           qs, qe, RMQ(st, n, qs, qe)); 
 
    return0; 
} 
