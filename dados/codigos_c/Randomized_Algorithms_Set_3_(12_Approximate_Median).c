/* Problema: Randomized Algorithms | Set 3 (1/2 Approximate Median)
 * Complexidade de Tempo: O(log n (log log n))
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/randomized-algorithms-set-3-12-approximate-median/
 */

/* C++ program to find Approximate Median using 
   1/2 Approximate Algorithm */
#include<bits/stdc++.h> 
usingnamespacestd; 
 
// This function returns the Approximate Median 
intrandApproxMedian(intarr[],intn) 
{ 
    // Declaration for the random number generator 
    random_device rand_dev; 
    mt19937 generator(rand_dev()); 
 
    // Random number generated will be in the range [0,n-1] 
    uniform_int_distribution<int> distribution(0, n-1); 
 
    if(n==0) 
        return0; 
 
    intk = 10*log2(n); // Taking c as 10 
 
    // A set stores unique elements in sorted order 
    set<int> s; 
    for(inti=0; i<k; i++) 
    { 
        // Generating a random index 
        intindex = distribution(generator); 
 
        //Inserting into the set 
        s.insert(arr[index]); 
    } 
 
    set<int> ::iterator itr = s.begin(); 
 
    // Report the median of the set at k/2 position 
    // Move the itr to k/2th position 
    advance(itr, (s.size()/2) - 1); 
 
    // Return the median 
    return*itr; 
} 
 
// Driver method to test above method 
intmain() 
{ 
    intarr[] = {1, 3, 2, 4, 5, 6, 8, 7}; 
    intn = sizeof(arr)/sizeof(int); 
    printf("Approximate Median is %d\n",randApproxMedian(arr,n)); 
    return0 
} 
