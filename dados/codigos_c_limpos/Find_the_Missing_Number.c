/* Problema: Find the Missing Number
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/find-the-missing-number/
 */

#include <stdio.h>

void findMissing(int arr[], int N)
{
    int temp[N + 1];
    for(int i = 0; i <= N; i++) {
        temp[i] = 0;
    }

    for(int i = 0; i < N; i++) {
        temp[arr[i] - 1] = 1;
    }

    int ans;
    for(int i = 0; i <= N; i++) {
        if(temp[i] == 0)
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
}

// This code is contributed by nikhilm2302
