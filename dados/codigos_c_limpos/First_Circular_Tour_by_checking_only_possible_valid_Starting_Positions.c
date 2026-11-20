/* Problema: First Circular Tour by checking only possible valid Starting Positions:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/find-a-tour-that-visits-all-stations/
 */

// C program to find circular tour for a truck
#include <stdio.h>

// A petrol pump has petrol and distance to next petrol pump
struct petrolPump {
    int petrol;
    int distance;
};

// The function return s starting point if there is a
// possible solution, otherwise return s -1
int printTour(struct petrolPump arr[], int n)
{
    int start;

    for(int i = 0; i < n; i++) {
        // Identify the first petrol pump from where we
        // might get a full circular tour
        if(arr[i].petrol >= arr[i].distance) {
            start = i;
            break;
        }
    }

    // To store the excess petrol
    int curr_petrol = 0;

    int i;

    for(i = start; i < n;) {

        curr_petrol += (arr[i].petrol - arr[i].distance);

        // If at any point remaining petrol is less than 0,
        // it means that we cannot start our journey from
        // current start
        if(curr_petrol < 0) {

            // We move to the next petrol pump
            i++;

            // We try to identify the next petrol pump from
            // where we might get a full circular tour
            for(; i < n; i++) {
                if(arr[i].petrol >= arr[i].distance) {

                    start = i;

                    // Reset rem_petrol
                    curr_petrol = 0;

                    break;
                }
            }
        }

        else
        {
          
            // Move to the next petrolpump if curr_petrol is
            // >= 0
            i++;
        }
    }

    // If remaining petrol is less than 0 while we reach the
    // first petrol pump, it means no circular tour is
    // possible
    if(curr_petrol < 0) {
        return-1;
    }

    for(int j = 0; j < start; j++) {

        curr_petrol += (arr[j].petrol - arr[j].distance);

        // If remaining petrol is less than 0 at any point
        // before we reach initial start, it means no
        // circular tour is possible
        if(curr_petrol < 0) {
            return-1;
        }
    }

    // If we have successfully reached int ial_start, it
    // means can get a circular tour from final_start, hence
    // return it
    return start;
}

// Driver code
int main()
{
    struct petrolPump arr[]
        = { { 6, 4 }, { 3, 6 }, { 7, 3 } };

    int n = sizeof(arr) / sizeof(arr[0]);
    int start = printTour(arr, n);

    (start == -1) ? printf("No solution")
                  : printf("Start = %d", start);

    return 0;
}

// This code is contributed by jainlovely450
