/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

// C program to find the missing Number

#include <stdio.h>

// Function to find the missing number
int getMissingNo(int a[], int n)
{
    int i = 0;
    while(i < n) {
        int correct = a[i] - 1;
        if(a[i] < n && a[i] != a[correct]) {
            int temp = a[i];
            a[i] = a[correct];
            a[correct] = temp;
        }
        else{
            i++;
        }
    }

    for(int i = 0; i < n; i++) {
        if(i != a[i] - 1) {
            return i + 1;
        }
    }

    return n;
}

// Driver code
int main()
{
    int arr[] = { 1, 2, 3, 5 };
    int N = sizeof(arr) / sizeof(arr[0]);

    // Function call
    int miss = getMissingNo(arr, N);
    printf("%d", miss);
    return 0;
}
