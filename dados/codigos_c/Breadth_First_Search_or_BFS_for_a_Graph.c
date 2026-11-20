/* Problema: Breadth First Search or BFS for a Graph
 * Complexidade de Tempo: O(V+E)
 * Complexidade de Espaco: O(V)
 * Fonte: https://www.geeksforgeeks.org/breadth-first-search-or-bfs-for-a-graph/
 */

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 50

// This struct represents a directed graph using
// adjacency list representation
typedefstructGraph_t {

    // No. of vertices
    intV;
    booladj[MAX_VERTICES][MAX_VERTICES];
} Graph;

// Constructor
Graph* Graph_create(intV)
{
    Graph* g = malloc(sizeof(Graph));
    g->V = V;

    for(inti = 0; i < V; i++) {
        for(intj = 0; j < V; j++) {
            g->adj[i][j] = false;
        }
    }

    returng;
}

// Destructor
voidGraph_destroy(Graph* g) { free(g); }

// Function to add an edge to graph
voidGraph_addEdge(Graph* g, intv, intw)
{
    // Add w to v’s list.
    g->adj[v][w] = true;
}

// Prints BFS traversal from a given source s
voidGraph_BFS(Graph* g, ints)
{
    // Mark all the vertices as not visited
    boolvisited[MAX_VERTICES];
    for(inti = 0; i < g->V; i++) {
        visited[i] = false;
    }

    // Create a queue for BFS
    intqueue[MAX_VERTICES];
    intfront = 0, rear = 0;

    // Mark the current node as visited and enqueue it
    visited[s] = true;
    queue[rear++] = s;

    while(front != rear) {

        // Dequeue a vertex from queue and print it
        s = queue[front++];
        printf("%d ", s);

        // Get all adjacent vertices of the dequeued
        // vertex s.
        // If an adjacent has not been visited,
        // then mark it visited and enqueue it
        for(intadjacent = 0; adjacent < g->V;
             adjacent++) {
            if(g->adj[s][adjacent] && !visited[adjacent]) {
                visited[adjacent] = true;
                queue[rear++] = adjacent;
            }
        }
    }
}

// Driver code
intmain()
{
    // Create a graph
    Graph* g = Graph_create(4);
    Graph_addEdge(g, 0, 1);
    Graph_addEdge(g, 0, 2);
    Graph_addEdge(g, 1, 2);
    Graph_addEdge(g, 2, 0);
    Graph_addEdge(g, 2, 3);
    Graph_addEdge(g, 3, 3);

    printf("Following is Breadth First Traversal "
           "(starting from vertex 2) \n");
    Graph_BFS(g, 2);
    Graph_destroy(g);

    return0;
}
