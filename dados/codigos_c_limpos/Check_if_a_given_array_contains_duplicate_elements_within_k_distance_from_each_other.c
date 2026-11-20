/* Problema: Check if a given array contains duplicate elements within k distance from each other
 * Complexidade de Tempo: O(N*K)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/check-given-array-contains-duplicate-elements-within-k-distance/
 */

// C program to Check if a given array contains duplicate
// elements within k distance from each other

#include <stdbool.h>
#include <stdio.h>

boolcheckDuplicatesWithinK(int arr[], int n, int k)
{
    // traversing the input array
    for(int i = 0; i < n; i++) {
        int j = i + 1;
        int range = k;
        // searching in next k-1 elements if its duplicate
        // is present or not
        while(range > 0 && j < n) {
            if(arr[i] == arr[j])
                return true;
            j++;
            range--;
        }
    }
    return false;
}

// Driver method to test above method
int main()
{
    int arr[] = { 10, 5, 3, 4, 3, 5, 6 };
    int n = sizeof(arr) / sizeof(arr[0]);
    if(checkDuplicatesWithinK(arr, n, 3))
        printf("Yes");
    else
        printf("No");
}

// This code is contributed by Aditya Kumar (adityakumar129)
