/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

// C program to Find the missing element

#include <stdio.h>
#include <stdlib.h>

void findMissing(int arr[], int size)
{
    int i;

    for(i = 0; i < size; i++) {
        if(abs(arr[i]) - 1 == size) {
            continue;
        }
        int ind = abs(arr[i]) - 1;
        arr[ind] *= -1;
    }

    int ans = size + 1;
    for(i = 0; i < size; i++) {
        if(arr[i] > 0)
            ans = i + 1;
    }
    printf("%d", ans);
}

/* Driver code */
int main()
{
    int arr[] = { 1, 3, 7, 5, 6, 2 };
    int n = sizeof(arr) / sizeof(arr[0]);
    findMissing(arr, n);
    return 0;
}
