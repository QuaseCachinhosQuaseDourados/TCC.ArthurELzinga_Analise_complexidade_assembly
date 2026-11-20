/* Problema: Closest Pair of Points using Divide and Conquer algorithm
 * Complexidade de Tempo: T(n x Logn x Logn)
 * Complexidade de Espaco: O(log n)
 * Fonte: https://www.geeksforgeeks.org/closest-pair-of-points-using-divide-and-conquer-algorithm/
 */

// A divide and conquer program in C/C++ to find the smallest distance from a
// given set of points.

#include <stdio.h>
#include <float.h>
#include <stdlib.h>
#include <math.h>

// A structure to represent a Point in 2D plane
structPoint
{
    intx, y;
};

/* Following two functions are needed for library function qsort().
   Refer: http://www.cplusplus.com/reference/clibrary/cstdlib/qsort/ */

// Needed to sort array of points according to X coordinate
intcompareX(constvoid* a, constvoid* b)
{
    Point *p1 = (Point *)a,  *p2 = (Point *)b;
    return(p1->x - p2->x);
}
// Needed to sort array of points according to Y coordinate
intcompareY(constvoid* a, constvoid* b)
{
    Point *p1 = (Point *)a,   *p2 = (Point *)b;
    return(p1->y - p2->y);
}

// A utility function to find the distance between two points
floatdist(Point p1, Point p2)
{
    returnsqrt( (p1.x - p2.x)*(p1.x - p2.x) +
                 (p1.y - p2.y)*(p1.y - p2.y)
               );
}

// A Brute Force method to return the smallest distance between two points
// in P[] of size n
floatbruteForce(Point P[], intn)
{
    floatmin = FLT_MAX;
    for(inti = 0; i < n; ++i)
        for(intj = i+1; j < n; ++j)
            if(dist(P[i], P[j]) < min)
                min = dist(P[i], P[j]);
    returnmin;
}

// A utility function to find a minimum of two float values
floatmin(floatx, floaty)
{
    return(x < y)? x : y;
}


// A utility function to find the distance between the closest points of
// strip of a given size. All points in strip[] are sorted according to
// y coordinate. They all have an upper bound on minimum distance as d.
// Note that this method seems to be a O(n^2) method, but it's a O(n)
// method as the inner loop runs at most 6 times
floatstripClosest(Point strip[], intsize, floatd)
{
    floatmin = d;  // Initialize the minimum distance as d

    qsort(strip, size, sizeof(Point), compareY); 

    // Pick all points one by one and try the next points till the difference
    // between y coordinates is smaller than d.
    // This is a proven fact that this loop runs at most 6 times
    for(inti = 0; i < size; ++i)
        for(intj = i+1; j < size && (strip[j].y - strip[i].y) < min; ++j)
            if(dist(strip[i],strip[j]) < min)
                min = dist(strip[i], strip[j]);

    returnmin;
}

// A recursive function to find the smallest distance. The array P contains
// all points sorted according to x coordinate
floatclosestUtil(Point P[], intn)
{
    // If there are 2 or 3 points, then use brute force
    if(n <= 3)
        returnbruteForce(P, n);

    // Find the middle point
    intmid = n/2;
    Point midPoint = P[mid];

    // Consider the vertical line passing through the middle point
    // calculate the smallest distance dl on left of middle point and
    // dr on right side
    floatdl = closestUtil(P, mid);
    floatdr = closestUtil(P + mid, n-mid);

    // Find the smaller of two distances
    floatd = min(dl, dr);

    // Build an array strip[] that contains points close (closer than d)
    // to the line passing through the middle point
    Point strip[n];
    intj = 0;
    for(inti = 0; i < n; i++)
        if(abs(P[i].x - midPoint.x) < d)
            strip[j] = P[i], j++;

    // Find the closest points in strip.  Return the minimum of d and closest
    // distance is strip[]
    returnmin(d, stripClosest(strip, j, d) );
}

// The main function that finds the smallest distance
// This method mainly uses closestUtil()
floatclosest(Point P[], intn)
{
    qsort(P, n, sizeof(Point), compareX);

    // Use recursive function closestUtil() to find the smallest distance
    returnclosestUtil(P, n);
}

// Driver program to test above functions
intmain()
{
    Point P[] = {{2, 3}, {12, 30}, {40, 50}, {5, 1}, {12, 10}, {3, 4}};
    intn = sizeof(P) / sizeof(P[0]);
    printf("The smallest distance is %f ", closest(P, n));
    return0;
}
