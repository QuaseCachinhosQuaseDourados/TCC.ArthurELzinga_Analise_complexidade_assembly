/* Problema: Sieve of Eratosthenes
 * Complexidade de Tempo: O(n*log(log(n)))
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/sieve-of-eratosthenes/
 */

// C program to print all primes smaller than or equal to 
// n using Sieve of Eratosthenes 
#include <stdio.h> 
#include <stdbool.h> 
#include <string.h> 
 
voidSieveOfEratosthenes(intn) 
{ 
   
    // Create a boolean array "prime[0..n]" and initialize 
    // all entries it as true. A value in prime[i] will 
    // finally be false if i is Not a prime, else true. 
    boolprime[n + 1]; 
    memset(prime, true, sizeof(prime)); 
 
    for(intp = 2; p * p <= n; p++) { 
        // If prime[p] is not changed, then it is a prime 
        if(prime[p] == true) { 
            // Update all multiples of p greater than or 
            // equal to the square of it numbers which are 
            // multiple of p and are less than p^2 are 
            // already been marked. 
            for(inti = p * p; i <= n; i += p) 
                prime[i] = false; 
        } 
    } 
 
    // Print all prime numbers 
    for(intp = 2; p <= n; p++) 
        if(prime[p]) 
            printf("%d ",p); 
} 
 
// Driver Code 
intmain() 
{ 
    intn = 30; 
    printf("Following are the prime numbers smaller than or equal to %d \n", n); 
    SieveOfEratosthenes(n); 
    return0; 
} 
 
// This code is contributed by Aditya Kumar (adityakumar129)
