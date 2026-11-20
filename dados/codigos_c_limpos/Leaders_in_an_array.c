/* Problema: Leaders in an array
 * Complexidade de Tempo: O(N * N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/leaders-in-an-array/
 */

/*C Function to print leaders in an array */

#include <stdio.h>

void printLeaders(int arr[], int size)
{
    int i, j;
    for(i = 0; i < size; i++) {
        for(j = i + 1; j < size; j++) {
            if(arr[i] <= arr[j])
                break;
        }
        if(j == size) // the loop didn't break
            printf("%d ", arr[i]);
    }
}

/* Driver program to test above function */
int main()
{
    int arr[] = { 16, 17, 4, 3, 5, 2 };
    int n = sizeof(arr) / sizeof(arr[0]);
    printLeaders(arr, n);
    return 0;
}
