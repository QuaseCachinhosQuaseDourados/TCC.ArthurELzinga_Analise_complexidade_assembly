/* Problema: Pascal’s Triangle using Dynamic Programming:
 * Complexidade de Tempo: O(N^2)
 * Complexidade de Espaco: O(N^2)
 * Fonte: https://www.geeksforgeeks.org/pascal-triangle/
 */

// C program for Pascal’s Triangle
// A O(n^2) time and O(n^2) extra space 
// method for Pascal's Triangle
voidprintPascal(intn)
{
// An auxiliary array to store 
// generated pascal triangle values
intarr[n][n]; 

// Iterate through every line and print integer(s) in it
for(intline = 0; line < n; line++)
{
    // Every line has number of integers 
    // equal to line number
    for(inti = 0; i <= line; i++)
    {
    // First and last values in every row are 1
    if(line == i || i == 0)
        arr[line][i] = 1;
    // Other values are sum of values just 
    // above and left of above
    else
        arr[line][i] = arr[line-1][i-1] + arr[line-1][i];
    printf("%d ", arr[line][i]);
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
