/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

#include <stdio.h>

// Function to get the missing element
int getMissingNo(int a[], int n)
{
    int i, total = 1;

    for(i = 2; i < (n + 1); i++) {
        total += i;
        total -= a[i - 2];
    }
    return total;
}

// Driver code
void main()
{
    int arr[] = { 1, 2, 3, 5 };
    int N = sizeof(arr) / sizeof(arr[0]);

    printf("%d", getMissingNo(arr, N));
}
// This code is contributed by Aditya Kumar (adityakumar129)
