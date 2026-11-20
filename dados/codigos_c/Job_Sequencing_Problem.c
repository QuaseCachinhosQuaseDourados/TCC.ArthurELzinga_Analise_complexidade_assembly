/* Problema: Job Sequencing Problem
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/job-sequencing-problem/
 */

// C program for the above approach

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// A structure to represent a job
typedefstructJob {
  
    charid; // Job Id
    intdead; // Deadline of job
    intprofit; // Profit if job is over before or on
                // deadline
} Job;

// This function is used for sorting all jobs according to
// profit
intcompare(constvoid* a, constvoid* b)
{
    Job* temp1 = (Job*)a;
    Job* temp2 = (Job*)b;
    return(temp2->profit - temp1->profit);
}

// Find minimum between two numbers.
intmin(intnum1, intnum2)
{
    return(num1 > num2) ? num2 : num1;
}

// Returns maximum profit from jobs
voidprintJobScheduling(Job arr[], intn)
{
    // Sort all jobs according to decreasing order of profit
    qsort(arr, n, sizeof(Job), compare);

    intresult[n]; // To store result (Sequence of jobs)
    boolslot[n]; // To keep track of free time slots

    // Initialize all slots to be free
    for(inti = 0; i < n; i++)
        slot[i] = false;

    // Iterate through all given jobs
    for(inti = 0; i < n; i++) {
      
        // Find a free slot for this job (Note that we start
        // from the last possible slot)
        for(intj = min(n, arr[i].dead) - 1; j >= 0; j--) {
          
            // Free slot found
            if(slot[j] == false) {
                result[j] = i; // Add this job to result
                slot[j] = true; // Make this slot occupied
                break;
            }
        }
    }

    // Print the result
    for(inti = 0; i < n; i++)
        if(slot[i])
            printf("%c ", arr[result[i]].id);
}

// Driver's code
intmain()
{
    Job arr[] = { { 'a', 2, 100 },
                  { 'b', 1, 19 },
                  { 'c', 2, 27 },
                  { 'd', 1, 25 },
                  { 'e', 3, 15 } };
    intn = sizeof(arr) / sizeof(arr[0]);
    printf(
        "Following is maximum profit sequence of jobs \n");

    // Function call
    printJobScheduling(arr, n);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
