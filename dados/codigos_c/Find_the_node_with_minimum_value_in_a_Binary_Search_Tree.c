/* Problema: Find the node with minimum value in a Binary Search Tree
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/find-the-minimum-element-in-a-binary-search-tree/
 */

// C program to find minimum value node in binary search
// Tree.

#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

/* Helper function that allocates a new node
with the given data and NULL left and right
pointers. */
structnode* newNode(intdata)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;

    return(node);
}

/* Give a binary search tree and a number,
inserts a new node with the given number in
the correct place in the tree. Returns the new
root pointer which the caller should then use
(the standard trick to avoid using reference
parameters). */
structnode* insert(structnode* node, intdata)
{
    /* 1. If the tree is empty, return a new,
        single node */
    if(node == NULL)
        return(newNode(data));
    else{
        /* 2. Otherwise, recur down the tree */
        if(data <= node->data)
            node->left = insert(node->left, data);
        else
            node->right = insert(node->right, data);

        /* return the (unchanged) node pointer */
        returnnode;
    }
}

/* Given a non-empty binary search tree,
return the minimum data value found in that
tree. Note that the entire tree does not need
to be searched. */
intminValue(structnode* node)
{
    structnode* current = node;

    /* loop down to find the leftmost leaf */
    while(current->left != NULL) {
        current = current->left;
    }
    return(current->data);
}

/* Driver code*/
intmain()
{
    structnode* root = NULL;
    root = insert(root, 4);
    insert(root, 2);
    insert(root, 1);
    insert(root, 3);
    insert(root, 6);
    insert(root, 5);

      // Function call
    printf("\n Minimum value in BST is %d", minValue(root));
    getchar();
    return0;
}
