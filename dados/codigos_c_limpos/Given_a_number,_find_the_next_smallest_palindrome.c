/* Problema: Given a number, find the next smallest palindrome
 * Complexidade de Tempo: O(num * |num|)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/given-a-number-find-next-smallest-palindrome-larger-than-this-number/
 */

#include <stdio.h>

int isPalindrome(int num)
{
    // Declaring required variables
    int n, k, rev = 0;
    n = num;
    while(num != 0) {
        k = num % 10;
        rev = (rev * 10) + k;
        num = num / 10;
    }
    // checking if num and its reverse are same

    return(n == rev);
}

int main()
{
    // Taking any number to find the next palindrome number
    int num = 9687;
    // using while loop to find the number being palindrome
    while(!isPalindrome(num))
        num += 1;
    // printing the next palindrome number
    printf("Next palindrome number is %d", num);
    return 0;
}
// Contributed by Vikash Rautela
