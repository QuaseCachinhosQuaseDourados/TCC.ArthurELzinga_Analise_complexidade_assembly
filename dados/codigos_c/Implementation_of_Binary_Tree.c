/* Problema: Implementation of Binary Tree:
 * Complexidade de Tempo: None
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/introduction-to-binary-tree-data-structure-and-algorithm-tutorials/
 */

#include <stdio.h>
#include <stdlib.h>

structnode {
    intdata;
    structnode* left;
    structnode* right;
};

// newNode() allocates a new node
// with the given data and NULL left
// and right pointers.
structnode* newNode(intdata)
{
    // Allocate memory for new node
    structnode* node
        = (structnode*)malloc(sizeof(structnode));

    // Assign data to this node
    node->data = data;

    // Initialize left and
    // right children as NULL
    node->left = NULL;
    node->right = NULL;
    return(node);
}

intmain()
{
    // Create root
    structnode* root = newNode(1);

    /* following is the tree after above statement
        1
       /  \
     NULL NULL
    */
    root->left = newNode(2);
    root->right = newNode(3);

    /* 2 and 3 become left and right children of 1
            1
           / \
          2   3
         / \ / \
    NULL NULL NULL NULL
    */
    root->left->left = newNode(4);

    /* 4 becomes left child of 2
         1
        / \
       2   3
      /  \ / \
     4 NULL NULL NULL
     /   \
    NULL NULL
    */
    getchar();
    return0;
}
