/* Problema: Pascal’s Triangle using Binomial Coefficient (Space Optimised):
 * Complexidade de Tempo: O(n2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/pascal-triangle/
 */

// C program for Pascal’s Triangle
// A O(n^2) time and O(1) extra space 
// function for Pascal's Triangle
voidprintPascal(intn)
{
for(intline = 1; line <= n; line++)
{
    intC = 1; // used to represent C(line, i)
    for(inti = 1; i <= line; i++) 
    {
    printf("%d ", C); // The first value in a line is always 1
    C = C * (line - i) / i; 
    }
    printf("\n");
}
}
// Driver code
intmain()
{
intn = 5;
    printPascal(n);
    return0;
}
