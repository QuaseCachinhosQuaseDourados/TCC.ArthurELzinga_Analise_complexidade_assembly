/* Problema: Activity Selection Problem | Greedy Algo-1
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/activity-selection-problem-greedy-algo-1/
 */

// C program for activity selection problem.

// The following implementation assumes that the activities
// are already sorted according to their finish time
#include <stdio.h>

// Prints a maximum set of activities that can be done by a
// single person, one at a time.
voidprintMaxActivities(ints[], intf[], intn)
{
    inti, j;

    printf("Following activities are selected\n");

    // The first activity always gets selected
    i = 0;
    printf("%d ", i);

    // Consider rest of the activities
    for(j = 1; j < n; j++) {
        // If this activity has start time greater than or
        // equal to the finish time of previously selected
        // activity, then select it
        if(s[j] >= f[i]) {
            printf("%d ", j);
            i = j;
        }
    }
}

// Driver code
intmain()
{
    ints[] = { 1, 3, 0, 5, 8, 5 };
    intf[] = { 2, 4, 6, 7, 9, 9 };
    intn = sizeof(s) / sizeof(s[0]);

    // Function call
    printMaxActivities(s, f, n);
    return0;
}
