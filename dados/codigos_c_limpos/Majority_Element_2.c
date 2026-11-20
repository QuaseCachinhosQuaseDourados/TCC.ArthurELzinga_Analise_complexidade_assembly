/* Problema: Majority Element
 * Complexidade de Tempo: O(N*log N)
 * Complexidade de Espaco: O(log N)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

#include <stdio.h>

int countOccurrences(int arr[], int n, int num) {
    int count = 0;
    for(int i = 0; i < n; i++) {
        if(arr[i] == num)
            count++;
    }
    return count;
}

int findMajorityUtil(int arr[], int low, int high) {
    // Base case: single element array
    if(low == high)
        return arr[low];

    // Divide the array int o left
  // and right halves
    int mid = (low + high) / 2;
    int leftMajority = findMajorityUtil(arr, low, mid);
    int rightMajority = findMajorityUtil(arr, mid+1, high);

    // If left and right halves have the
  //same majority element
    if(leftMajority == rightMajority)
        return leftMajority;

    // Count the occurrences of the majority
  // element in the entire array
    int leftCount = countOccurrences(arr, high-low+1, leftMajority);
    int rightCount = countOccurrences(arr, high-low+1, rightMajority);

    // Return the element that occurs
  // more than n/2 times
    if(leftCount > (high-low+1) / 2)
        return leftMajority;
    if(rightCount > (high-low+1) / 2)
        return rightMajority;

    // No majority element
    return-1;
}

void findMajority(int arr[], int n) {
    int majority = findMajorityUtil(arr, 0, n-1);
    if(majority != -1)
        printf("%d\n", majority);
    else
        printf("No Majority Element\n");
}

int main() {
    int arr[] = {1, 3, 3, 3, 2};
    int n = sizeof(arr) / sizeof(arr[0]);

    findMajority(arr, n);

    return 0;
}
