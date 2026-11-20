/* Problema: Check if a Binary Tree is subtree of another binary tree | Set 1
 * Complexidade de Tempo: O(M*N)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/check-if-a-binary-tree-is-subtree-of-another-binary-tree/
 */

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, left child and right child
 */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

/* A utility function to check whether trees with roots as
   root1 and root2 are identical or not */
boolareIdentical(structnode* root1, structnode* root2)
{
    /* base cases */
    if(root1 == NULL && root2 == NULL)
        returntrue;

    if(root1 == NULL || root2 == NULL)
        returnfalse;

    /* Check if the data of both roots is same and data of
       left and right subtrees are also same */
    return(root1->data == root2->data
            && areIdentical(root1->left, root2->left)
            && areIdentical(root1->right, root2->right));
}

/* This function returns true if S is a subtree of T,
 * otherwise false */
boolisSubtree(structnode* T, structnode* S)
{
    /* base cases */
    if(S == NULL)
        returntrue;

    if(T == NULL)
        returnfalse;

    /* Check the tree with root as current node */
    if(areIdentical(T, S))
        returntrue;

    /* If the tree with root as current node doesn't match
       then try left and right subtrees one by one */
    returnisSubtree(T->left, S) || isSubtree(T->right, S);
}

/* Helper function that allocates a new node with the given
   data and NULL left and right pointers. */
structnode* newNode(intdata)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;
    return(node);
}

/* Driver program to test above function */
intmain()
{
    // TREE 1
    /* Construct the following tree
              26
            /   \
          10     3
        /    \     \
      4      6      3
       \
        30
    */
    structnode* T = newNode(26);
    T->right = newNode(3);
    T->right->right = newNode(3);
    T->left = newNode(10);
    T->left->left = newNode(4);
    T->left->left->right = newNode(30);
    T->left->right = newNode(6);

    // TREE 2
    /* Construct the following tree
          10
        /    \
      4      6
       \
        30
    */
    structnode* S = newNode(10);
    S->right = newNode(6);
    S->left = newNode(4);
    S->left->right = newNode(30);

    if(isSubtree(T, S))
        printf("Tree 2 is subtree of Tree 1");
    else
        printf("Tree 2 is not a subtree of Tree 1");

    getchar();
    return0;
}
