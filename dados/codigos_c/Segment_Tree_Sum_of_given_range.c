/* Problema: Segment Tree | Sum of given range
 * Complexidade de Tempo: O(N*log(N))
 * Complexidade de Espaco: O(N*log(N))
 * Fonte: https://www.geeksforgeeks.org/segment-tree-sum-of-given-range/
 */

// C program to show segment tree operations like construction, query
// and update
#include <stdio.h>
#include <math.h>

// A utility function to get the middle index from corner indexes.
intgetMid(ints, inte) {  returns + (e -s)/2;  }

/*  A recursive function to get the sum of values in given range
    of the array. The following are parameters for this function.

    st    --> Pointer to segment tree
    si    --> Index of current node in the segment tree. Initially
              0 is passed as root is always at index 0
    ss & se  --> Starting and ending indexes of the segment represented
                 by current node, i.e., st[si]
    qs & qe  --> Starting and ending indexes of query range */
intgetSumUtil(int*st, intss, intse, intqs, intqe, intsi)
{
    // If segment of this node is a part of given range, then return
    // the sum of the segment
    if(qs <= ss && qe >= se)
        returnst[si];

    // If segment of this node is outside the given range
    if(se < qs || ss > qe)
        return0;

    // If a part of this segment overlaps with the given range
    intmid = getMid(ss, se);
    returngetSumUtil(st, ss, mid, qs, qe, 2*si+1) +
           getSumUtil(st, mid+1, se, qs, qe, 2*si+2);
}

/* A recursive function to update the nodes which have the given 
   index in their range. The following are parameters
    st, si, ss and se are same as getSumUtil()
    i    --> index of the element to be updated. This index is 
             in the input array.
   diff --> Value to be added to all nodes which have i in range */
voidupdateValueUtil(int*st, intss, intse, inti, intdiff, intsi)
{
    // Base Case: If the input index lies outside the range of 
    // this segment
    if(i < ss || i > se)
        return;

    // If the input index is in range of this node, then update 
    // the value of the node and its children
    st[si] = st[si] + diff;
    if(se != ss)
    {
        intmid = getMid(ss, se);
        updateValueUtil(st, ss, mid, i, diff, 2*si + 1);
        updateValueUtil(st, mid+1, se, i, diff, 2*si + 2);
    }
}

// The function to update a value in input array and segment tree.
// It uses updateValueUtil() to update the value in segment tree
voidupdateValue(intarr[], int*st, intn, inti, intnew_val)
{
    // Check for erroneous input index
    if(i < 0 || i > n-1)
    {
        printf("Invalid Input");
        return;
    }

    // Get the difference between new value and old value
    intdiff = new_val - arr[i];

    // Update the value in array
    arr[i] = new_val;

    // Update the values of nodes in segment tree
    updateValueUtil(st, 0, n-1, i, diff, 0);
}

// Return sum of elements in range from index qs (query start)
// to qe (query end).  It mainly uses getSumUtil()
intgetSum(int*st, intn, intqs, intqe)
{
    // Check for erroneous input values
    if(qs < 0 || qe > n-1 || qs > qe)
    {
        printf("Invalid Input");
        return-1;
    }

    returngetSumUtil(st, 0, n-1, qs, qe, 0);
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
    // right subtrees and store the sum of values in this node
    intmid = getMid(ss, se);
    st[si] =  constructSTUtil(arr, ss, mid, st, si*2+1) +
              constructSTUtil(arr, mid+1, se, st, si*2+2);
    returnst[si];
}

/* Function to construct segment tree from given array. This function
   allocates memory for segment tree and calls constructSTUtil() to
   fill the allocated memory */
int*constructST(intarr[], intn)
{
    // Allocate memory for the segment tree

    //Height of segment tree
    intx = (int)(ceil(log2(n))); 

    //Maximum size of segment tree
    intmax_size = 2*(int)pow(2, x) - 1; 

    // Allocate memory
    int*st = newint[max_size];

    // Fill the allocated memory st
    constructSTUtil(arr, 0, n-1, st, 0);

    // Return the constructed segment tree
    returnst;
}

// Driver program to test above functions
intmain()
{
    intarr[] = {1, 3, 5, 7, 9, 11};
    intn = sizeof(arr)/sizeof(arr[0]);

    // Build segment tree from given array
    int*st = constructST(arr, n);

    // Print sum of values in array from index 1 to 3
    printf("Sum of values in given range = %dn", 
            getSum(st, n, 1, 3));

    // Update: set arr[1] = 10 and update corresponding 
    // segment tree nodes
    updateValue(arr, st, n, 1, 10);

    // Find sum after the value is updated
    printf("Updated sum of values in given range = %dn",
             getSum(st, n, 1, 3));
    return0;
}
