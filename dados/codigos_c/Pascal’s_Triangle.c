/* Problema: Pascal’s Triangle
 * Complexidade de Tempo: O(N^3)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/pascal-triangle/
 */

//  C++ code for Pascal's Triangle
#include <stdio.h>

// See https://www.geeksforgeeks.org/space-and-time-efficient-binomial-coefficient/ 
// for details of this function
intbinomialCoeff(intn, intk);

// Function to print first
// n lines of Pascal's 
// Triangle
voidprintPascal(intn)
{
    // Iterate through every line and
    // print entries in it
    for(intline = 0; line < n; line++)
    {
        // Every line has number of 
        // integers equal to line 
        // number
        for(inti = 0; i <= line; i++)
            printf("%d ",
                    binomialCoeff(line, i));
        printf("\n");
    }
}

// See https://www.geeksforgeeks.org/space-and-time-efficient-binomial-coefficient/
// for details of this function
intbinomialCoeff(intn, intk)
{
    intres = 1;
    if(k > n - k)
    k = n - k;
    for(inti = 0; i < k; ++i)
    {
        res *= (n - i);
        res /= (i + 1);
    }
    
    returnres;
}

// Driver program 
intmain()
{
    intn = 7;
    printPascal(n);
    return0;
}
