/* Problema: Searching in Binary Search Tree (BST)
 * Complexidade de Tempo: O(h)
 * Complexidade de Espaco: O(h)
 * Fonte: https://www.geeksforgeeks.org/binary-search-tree-set-1-search-and-insertion/
 */

// C function to search a given key in a given BST

#include <stdio.h>
#include <stdlib.h>

structnode {
    intkey;
    structnode *left, *right;
};

// A utility function to create a new BST node
structnode* newNode(intitem)
{
    structnode* temp
        = (structnode*)malloc(sizeof(structnode));
    temp->key = item;
    temp->left = temp->right = NULL;
    returntemp;
}

// A utility function to insert
// a new node with given key in BST
structnode* insert(structnode* node, intkey)
{
    // If the tree is empty, return a new node
    if(node == NULL)
        returnnewNode(key);

    // Otherwise, recur down the tree
    if(key < node->key)
        node->left = insert(node->left, key);
    elseif(key > node->key)
        node->right = insert(node->right, key);

    // Return the (unchanged) node pointer
    returnnode;
}

// Utility function to search a key in a BST
structnode* search(structnode* root, intkey)
{
    // Base Cases: root is null or key is present at root
    if(root == NULL || root->key == key)
        returnroot;

    // Key is greater than root's key
    if(root->key < key)
        returnsearch(root->right, key);

    // Key is smaller than root's key
    returnsearch(root->left, key);
}

// Driver Code
intmain()
{
    structnode* root = NULL;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 20);
    insert(root, 40);
    insert(root, 70);
    insert(root, 60);
    insert(root, 80);

    // Key to be found
    intkey = 6;

    // Searching in a BST
    if(search(root, key) == NULL)
        printf("%d not found\n", key);
    else
        printf("%d found\n", key);

    key = 60;

    // Searching in a BST
    if(search(root, key) == NULL)
        printf("%d not found\n", key);
    else
        printf("%d found\n", key);
    return0;
}
