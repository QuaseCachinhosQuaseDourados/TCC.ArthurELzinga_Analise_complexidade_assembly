/* Problema: Check BST using specified range of minimum and maximum values of nodes:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/a-program-to-check-if-a-binary-tree-is-bst-or-not/
 */

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

intisBSTUtil(structnode* node, intmin, intmax);

/* Returns true if the given tree is a binary search tree
 (efficient version). */
intisBST(structnode* node)
{
    return(isBSTUtil(node, INT_MIN, INT_MAX));
}

/* Returns true if the given tree is a BST and its
   values are >= min and <= max. */
intisBSTUtil(structnode* node, intmin, intmax)
{
    /* an empty tree is BST */
    if(node == NULL)
        return1;

    /* false if this node violates the min/max constraint */
    if(node->data < min || node->data > max)
        return0;

    /* otherwise check the subtrees recursively,
     tightening the min or max constraint */
    returnisBSTUtil(node->left, min, node->data - 1)
           && // Allow only distinct values
           isBSTUtil(node->right, node->data + 1,
                     max); // Allow only distinct values
}

/* Helper function that allocates a new node with the
   given data and NULL left and right pointers. */
structnode* newNode(intdata)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;

    return(node);
}

/* Driver code*/
intmain()
{
    structnode* root = newNode(4);
    root->left = newNode(2);
    root->right = newNode(5);
    root->left->left = newNode(1);
    root->left->right = newNode(3);

      // Function call
    if(isBST(root))
        printf("Is BST");
    else
        printf("Not a BST");

    getchar();
    return0;
}
