/* Problema: Floor and Ceil from a BST
 * Complexidade de Tempo: O(log N)
 * Complexidade de Espaco: O(log N)
 * Fonte: https://www.geeksforgeeks.org/floor-and-ceil-from-a-bst/
 */

// C Program to find ceil of a given value in BST
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has key, left child and right child */
structnode {
    intkey;
    structnode* left;
    structnode* right;
};

/* Helper function that allocates a new node with the given
key and NULL left and right pointers.*/
structnode* newNode(intkey)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->key = key;
    node->left = NULL;
    node->right = NULL;
    return(node);
}

// Function to find ceil of a given input in BST. If input
// is more than the max key in BST, return -1
intCeil(structnode* root, intinput)
{
    // Base case
    if(root == NULL)
        return-1;

    // We found equal key
    if(root->key == input)
        returnroot->key;

    // If root's key is smaller, ceil must be in right
    // subtree
    if(root->key < input)
        returnCeil(root->right, input);

    // Else, either left subtree or root has the ceil value
    intceil= Ceil(root->left, input);
    return(ceil>= input) ? ceil: root->key;
}

// Driver code
intmain()
{
    structnode* root = newNode(8);

    root->left = newNode(4);
    root->right = newNode(12);

    root->left->left = newNode(2);
    root->left->right = newNode(6);

    root->right->left = newNode(10);
    root->right->right = newNode(14);

    for(inti = 0; i < 16; i++)
        printf("%d %d\n", i, Ceil(root, i));

    return0;
}
