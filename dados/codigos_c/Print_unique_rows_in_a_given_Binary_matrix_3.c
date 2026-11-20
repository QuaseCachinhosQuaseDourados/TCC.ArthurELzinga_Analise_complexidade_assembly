/* Problema: Print unique rows in a given Binary matrix
 * Complexidade de Tempo: O(ROW x COL)
 * Complexidade de Espaco: O(ROW x COL)
 * Fonte: https://www.geeksforgeeks.org/print-unique-rows/
 */

//Given a binary matrix of M X N of integers, you need to return only unique rows of binary array
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define ROW 4
#define COL 5

// A Trie node
typedefstructNode
{
    boolisEndOfCol;
    structNode *child[2]; // Only two children needed for 0 and 1
} Node;


// A utility function to allocate memory for a new Trie node
Node* newNode()
{
    Node* temp = (Node *)malloc( sizeof( Node ) );
    temp->isEndOfCol = 0;
    temp->child[0] = temp->child[1] = NULL;
    returntemp;
}

// Inserts a new matrix row to Trie.  If row is already
// present, then returns 0, otherwise insets the row and
// return 1
boolinsert( Node** root, int(*M)[COL], introw, intcol )
{
    // base case
    if( *root == NULL )
        *root = newNode();

    // Recur if there are more entries in this row
    if( col < COL )
        returninsert ( &( (*root)->child[ M[row][col] ] ), M, row, col+1 );

    else// If all entries of this row are processed
    {
        // unique row found, return 1
        if( !( (*root)->isEndOfCol ) )
            return(*root)->isEndOfCol = 1;

        // duplicate row found, return 0
        return0;
    }
}

// A utility function to print a row
voidprintRow( int(*M)[COL], introw )
{
    inti;
    for( i = 0; i < COL; ++i )
        printf( "%d ", M[row][i] );
    printf("\n");
}

// The main function that prints all unique rows in a
// given matrix.
voidfindUniqueRows( int(*M)[COL] )
{
    Node* root = NULL; // create an empty Trie
    inti;

    // Iterate through all rows
    for( i = 0; i < ROW; ++i )
        // insert row to TRIE
        if( insert(&root, M, i, 0) )
            // unique row found, print it
            printRow( M, i );
}

// Driver program to test above functions
intmain()
{
    intM[ROW][COL] = {{0, 1, 0, 0, 1},
        {1, 0, 1, 1, 0},
        {0, 1, 0, 0, 1},
        {1, 0, 1, 0, 0}
    };

    findUniqueRows( M );

    return0;
}
