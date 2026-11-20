/* Problema: Given a number, find the next smallest palindrome
 * Complexidade de Tempo: O(num)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/given-a-number-find-next-smallest-palindrome-larger-than-this-number/
 */

#include <stdio.h>

//A utility function to printan array
void printArray (intarr[], intn);

//A utility function to check ifnum has all9s
intAreAll9s (intnum[], intn );

//Returns nextpalindrome of a given number num[].
//This function isforinputtype2and3
void generateNextPalindromeUtil (intnum[], intn )
{
    //find the index of mid digit
    intmid =n/2;

    //A boolvariable to check ifcopy of left side to right issufficient ornot
    boolleftsmaller =false;

    //end of left side isalways 'mid -1'
    inti =mid -1;

    //Beginning of right side depends ifn isodd oreven
    intj =(n %2)? mid +1: mid;

   //Initially, ignore the middle same digits 
    while(i >=0&& num[i] ==num[j])
        i--,j++;

    //Find ifthe middle digit(s) need to be incremented ornot(orcopying left 
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
        intcarry =1;
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
void generateNextPalindrome( intnum[], intn )
{
    inti;

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

//A utility function to check ifnum has all9s
intAreAll9s( int*num, intn )
{
    inti;
    for( i =0; i < n; ++i )
        if( num[i] !=9)
            return0;
    return1;
}

/*Utility that prints out an array on a line */
void printArray(intarr[], intn)
{
    inti;
    for(i=0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

//Driver Program to test above function
intmain()
{
    intnum[] ={9, 4, 1, 8, 7, 9, 7, 8, 3, 2, 2};

    intn =sizeof (num)/sizeof(num[0]);

    generateNextPalindrome( num, n );

    return0;
}
