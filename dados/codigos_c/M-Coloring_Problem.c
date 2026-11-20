/* Problema: M-Coloring Problem
 * Complexidade de Tempo: O(mV)
 * Complexidade de Espaco: O(V)
 * Fonte: https://www.geeksforgeeks.org/m-coloring-problem/
 */

// C program for solution of M
// Coloring problem using backtracking

#include <stdbool.h>
#include <stdio.h>

// Number of vertices in the graph
#define V 4

voidprintSolution(intcolor[]);

/* A utility function to check if
   the current color assignment
   is safe for vertex v i.e. checks
   whether the edge exists or not
   (i.e, graph[v][i]==1). If exist
   then checks whether the color to
   be filled in the new vertex(c is
   sent in the parameter) is already
   used by its adjacent
   vertices(i-->adj vertices) or
   not (i.e, color[i]==c) */
boolisSafe(intv, boolgraph[V][V], intcolor[], intc)
{
    for(inti = 0; i < V; i++)
        if(graph[v][i] && c == color[i])
            returnfalse;
    returntrue;
}

/* A recursive utility function
to solve m coloring problem */
boolgraphColoringUtil(boolgraph[V][V], intm, intcolor[],
                       intv)
{
    /* base case: If all vertices are
       assigned a color then return true */
    if(v == V)
        returntrue;

    /* Consider this vertex v and
       try different colors */
    for(intc = 1; c <= m; c++) {
        /* Check if assignment of color
           c to v is fine*/
        if(isSafe(v, graph, color, c)) {
            color[v] = c;

            /* recur to assign colors to
               rest of the vertices */
            if(graphColoringUtil(graph, m, color, v + 1)
                == true)
                returntrue;

            /* If assigning color c doesn't
               lead to a solution then remove it */
            color[v] = 0;
        }
    }

    /* If no color can be assigned to
       this vertex then return false */
    returnfalse;
}

/* This function solves the m Coloring
   problem using Backtracking. It mainly
   uses graphColoringUtil() to solve the
   problem. It returns false if the m
   colors cannot be assigned, otherwise
   return true and prints assignments of
   colors to all vertices. Please note
   that there may be more than one solutions,
   this function prints one of the
   feasible solutions.*/
boolgraphColoring(boolgraph[V][V], intm)
{
    // Initialize all color values as 0.
    // This initialization is needed
    // correct functioning of isSafe()
    intcolor[V];
    for(inti = 0; i < V; i++)
        color[i] = 0;

    // Call graphColoringUtil() for vertex 0
    if(graphColoringUtil(graph, m, color, 0) == false) {
        printf("Solution does not exist");
        returnfalse;
    }

    // Print the solution
    printSolution(color);
    returntrue;
}

/* A utility function to print solution */
voidprintSolution(intcolor[])
{
    printf("Solution Exists:"
           " Following are the assigned colors \n");
    for(inti = 0; i < V; i++)
        printf(" %d ", color[i]);
    printf("\n");
}

// Driver code
intmain()
{
    /* Create following graph and test
       whether it is 3 colorable
      (3)---(2)
       |   / |
       |  /  |
       | /   |
      (0)---(1)
    */
    boolgraph[V][V] = {
        { 0, 1, 1, 1 },
        { 1, 0, 1, 0 },
        { 1, 1, 0, 1 },
        { 1, 0, 1, 0 },
    };
    intm = 3; // Number of colors

    // Function call
    graphColoring(graph, m);
    return0;
}
