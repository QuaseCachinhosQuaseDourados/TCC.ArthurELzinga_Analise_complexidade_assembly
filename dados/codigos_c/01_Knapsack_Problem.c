/* Problema: 0/1 Knapsack Problem
 * Complexidade de Tempo: O(2N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
 */

/* A Naive recursive implementation 
of 0-1 Knapsack problem */
#include <stdio.h> 
 
// A utility function that returns 
// maximum of two integers 
intmax(inta, intb) { return(a > b) ? a : b; } 
 
// Returns the maximum value that can be 
// put in a knapsack of capacity W 
intknapSack(intW, intwt[], intval[], intn) 
{ 
    // Base Case 
    if(n == 0 || W == 0) 
        return0; 
 
    // If weight of the nth item is more than 
    // Knapsack capacity W, then this item cannot 
    // be included in the optimal solution 
    if(wt[n - 1] > W) 
        returnknapSack(W, wt, val, n - 1); 
 
    // Return the maximum of two cases: 
    // (1) nth item included 
    // (2) not included 
    else
        returnmax( 
            val[n - 1] 
                + knapSack(W - wt[n - 1], wt, val, n - 1), 
            knapSack(W, wt, val, n - 1)); 
} 
 
// Driver code 
intmain() 
{ 
    intprofit[] = { 60, 100, 120 }; 
    intweight[] = { 10, 20, 30 }; 
    intW = 50; 
    intn = sizeof(profit) / sizeof(profit[0]); 
    printf("%d", knapSack(W, weight, profit, n)); 
    return0; 
}
