/* Problema: Given a number, find the next smallest palindrome
 * Complexidade de Tempo: O(num)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/given-a-number-find-next-smallest-palindrome-larger-than-this-number/
 */

#include <stdio.h>

//A utility function to printan array
void printArray (int arr[], int n);

//A utility function to check if num has all9s
int AreAll9s (int num[], int n );

//Returns nextpalindrome of a given number num[].
//This function isforinputtype2and3
void generateNextPalindromeUtil (int num[], int n )
{
    //find the index of mid digit
    int mid =n/2;

    //A boolvariable to check if copy of left side to right issufficient ornot
    boolleftsmaller =false;

    //end of left side isalways 'mid -1'
    int i =mid -1;

    //Beginning of right side depends if n isodd oreven
    int j =(n %2)? mid +1: mid;

   //Initially, ignore the middle same digits 
    while(i >=0&& num[i] ==num[j])
        i--,j++;

    //Find if the middle digit(s) need to be incremented ornot(orcopying left 
    //side isnotsufficient)
    if( i < 0|| num[i] < num[j])
        leftsmaller =true;

    //Copy the mirror of left to tight
    while(i >=0)
    {
        num[j] =num[i];
        j++;
        i--;
    }

    //Handle the case where middle digit(s) must be incremented. 
    //This part of code isforCASE 1andCASE 2.2
    if(leftsmaller ==true)
    {
        int carry =1;
        i =mid -1;

        //If there are odd digits, then increment
        //the middle digit andstore the carry
        if(n%2==1)
        {
            num[mid] +=carry;
            carry =num[mid] /10;
            num[mid] %=10;
            j =mid +1;
        }
        else
            j =mid;

        //Add 1to the rightmost digit of the left side, propagate the carry 
        //towards MSB digit andsimultaneously copying mirror of the left side 
        //to the right side.
        while(i >=0)
        {
            num[i] +=carry;
            carry =num[i] /10;
            num[i] %=10;
            num[j++] =num[i--]; //copy mirror to right
        }
    }
}

//The function that prints nextpalindrome of a given number num[]
//with n digits.
void generateNextPalindrome( int num[], int n )
{
    int i;

    printf("Next palindrome is:");

    //Inputtype1: Allthe digits are 9, simply o/p 1
    //followed by n-10's followed by 1.
    if( AreAll9s( num, n ) )
    {
        printf( "1 ");
        for( i =1; i < n; i++)
            printf( "0 ");
        printf( "1");
    }

    //Inputtype2and3
    else
    {
        generateNextPalindromeUtil ( num, n );

        //printthe result
        printArray (num, n);
    }
}

//A utility function to check if num has all9s
int AreAll9s( int*num, int n )
{
    int i;
    for( i =0; i < n; ++i )
        if( num[i] !=9)
            return 0;
    return 1;
}

/*Utility that prints out an array on a line */
void printArray(int arr[], int n)
{
    int i;
    for(i=0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

//Driver Program to test above function
int main()
{
    int num[] ={9, 4, 1, 8, 7, 9, 7, 8, 3, 2, 2};

    int n =sizeof (num)/sizeof(num[0]);

    generateNextPalindrome( num, n );

    return 0;
}
