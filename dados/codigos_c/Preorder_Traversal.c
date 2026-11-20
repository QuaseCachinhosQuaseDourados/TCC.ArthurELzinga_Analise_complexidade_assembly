/* Problema: Preorder Traversal:
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(h)
 * Fonte: https://www.geeksforgeeks.org/tree-traversals-inorder-preorder-and-postorder/
 */

// C program for different tree traversals
#include <stdio.h>
#include <stdlib.h>

// A binary tree node has data, pointer to left child
// and a pointer to right child
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

// Helper function that allocates a new node with the
// given data and NULL left and right pointers.
structnode* newNode(intdata)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;

    return(node);
}

// Given a binary tree, print its nodes in preorder
voidprintPreorder(structnode* node)
{
    if(node == NULL)
        return;

    // First print data of node
    printf("%d ", node->data);

    // Then recur on left subtree
    printPreorder(node->left);

    // Now recur on right subtree
    printPreorder(node->right);
}

// Driver code
intmain()
{
    structnode* root = newNode(1);
    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);

    // Function call
    printf("Preorder traversal of binary tree is \n");
    printPreorder(root);

    getchar();
    return0;
}
