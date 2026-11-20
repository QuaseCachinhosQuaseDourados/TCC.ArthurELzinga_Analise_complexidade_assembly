/* Problema: Majority Element
 * Complexidade de Tempo: O(N*log N)
 * Complexidade de Espaco: O(log N)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

#include <stdio.h>

intcountOccurrences(intarr[], intn, intnum) {
    intcount = 0;
    for(inti = 0; i < n; i++) {
        if(arr[i] == num)
            count++;
    }
    returncount;
}

intfindMajorityUtil(intarr[], intlow, inthigh) {
    // Base case: single element array
    if(low == high)
        returnarr[low];

    // Divide the array into left
  // and right halves
    intmid = (low + high) / 2;
    intleftMajority = findMajorityUtil(arr, low, mid);
    intrightMajority = findMajorityUtil(arr, mid+1, high);

    // If left and right halves have the
  //same majority element
    if(leftMajority == rightMajority)
        returnleftMajority;

    // Count the occurrences of the majority
  // element in the entire array
    intleftCount = countOccurrences(arr, high-low+1, leftMajority);
    intrightCount = countOccurrences(arr, high-low+1, rightMajority);

    // Return the element that occurs
  // more than n/2 times
    if(leftCount > (high-low+1) / 2)
        returnleftMajority;
    if(rightCount > (high-low+1) / 2)
        returnrightMajority;

    // No majority element
    return-1;
}

voidfindMajority(intarr[], intn) {
    intmajority = findMajorityUtil(arr, 0, n-1);
    if(majority != -1)
        printf("%d\n", majority);
    else
        printf("No Majority Element\n");
}

intmain() {
    intarr[] = {1, 3, 3, 3, 2};
    intn = sizeof(arr) / sizeof(arr[0]);

    findMajority(arr, n);

    return0;
}
