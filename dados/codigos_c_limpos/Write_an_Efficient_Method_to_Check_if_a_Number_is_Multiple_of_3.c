/* Problema: Write an Efficient Method to Check if a Number is Multiple of 3
 * Complexidade de Tempo: O(logn)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/write-an-efficient-method-to-check-if-a-number-is-multiple-of-3/
 */

// C program to check if n is a multiple of 3
#include <stdio.h>
#include<string.h>

int static dp[1001];

/* Function to check if n is a multiple of 3*/
int isMultipleOf3(int n)
{
    int odd_count = 0;
    int even_count = 0;
    
    // Base Cases
    if(n < 0)
        n = -n;
        
    if(n == 0)
        return 1;
        
    if(n == 1)
        return 0;
    
    // If a value is already present
    // in dp, return it
    if(dp[n] != -1)
        return dp[n];
    
    while(n) {
        /* If odd bit is set then
        increment odd counter */
        if(n & 1)
            odd_count++;

        /* If even bit is set then
        increment even counter */
        if(n & 2)
            even_count++;
        n = n >> 2;
    }
  
  int abs= (odd_count - even_count);
  if(abs<0)
  {
    abs= -1*abs;
  }

    dp[n] = isMultipleOf3(abs);
    
    // return dp
    return dp[n];
}

/* Program to test function isMultipleOf3 */
int main()
{
    int num = 24;
    
    memset(dp, -1, sizeof(dp));
    
    if(isMultipleOf3(num))
        printf("%d is multiple of 3", num);
    else
        printf("%d is not a multiple of 3", num);
    return 0;
}

// This code is contributed by akashish_.
