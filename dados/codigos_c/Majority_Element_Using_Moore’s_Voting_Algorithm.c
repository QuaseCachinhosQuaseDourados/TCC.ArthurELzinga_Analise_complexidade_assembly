/* Problema: Majority Element Using Moore’s Voting Algorithm:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

/* Program for finding out majority element in an array */
#include <stdio.h>
#define bool int

intfindCandidate(int*, int);
boolisMajority(int*, int, int);

/* Function to print Majority Element */
voidprintMajority(inta[], intsize)
{
    /* Find the candidate for Majority*/
    intcand = findCandidate(a, size);

    /* Print the candidate if it is Majority*/
    if(isMajority(a, size, cand))
        printf(" %d ", cand);
    else
        printf("No Majority Element");
}

/* Function to find the candidate for Majority */
intfindCandidate(inta[], intsize)
{
    intmaj_index = 0, count = 1;
    inti;
    for(i = 1; i < size; i++) {
        if(a[maj_index] == a[i])
            count++;
        else
            count--;
        if(count == 0) {
            maj_index = i;
            count = 1;
        }
    }
    returna[maj_index];
}

/* Function to check if the candidate occurs more than n/2
 * times */
boolisMajority(inta[], intsize, intcand)
{
    inti, count = 0;
    for(i = 0; i < size; i++)
        if(a[i] == cand)
            count++;
    if(count > size / 2)
        return1;
    else
        return0;
}

/* Driver code */
intmain()
{
    inta[] = { 1, 3, 3, 1, 2 };
    intsize = (sizeof(a)) / sizeof(a[0]);
  
    // Function call
    printMajority(a, size);
    getchar();
    return0;
}
