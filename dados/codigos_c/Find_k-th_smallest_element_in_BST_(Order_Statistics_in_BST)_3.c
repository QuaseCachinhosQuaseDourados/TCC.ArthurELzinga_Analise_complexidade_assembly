/* Problema: Find k-th smallest element in BST (Order Statistics in BST)
 * Complexidade de Tempo: O(h)
 * Complexidade de Espaco: O(h)
 * Fonte: https://www.geeksforgeeks.org/find-k-th-smallest-element-in-bst-order-statistics-in-bst/
 */

// A simple inorder traversal based C++ program to find k-th
// smallest element in a BST.
#include <stdio.h>
#include <stdlib.h>

// A BST node
typedefstructNode {
    intdata;
    structNode *left, *right;
    intlCount;
} Node;

Node* new_node(intx)
{
    Node* newNode = malloc(sizeof(Node));
    newNode->data = x;
    newNode->left = NULL;
    newNode->right = NULL;
    returnnewNode;
}

// Recursive function to insert an key into BST
Node* insert(Node* root, intx)
{
    if(root == NULL)
        returnnew_node(x);

    // If a node is inserted in left subtree, then lCount of
    // this node is increased. For simplicity, we are
    // assuming that all keys (tried to be inserted) are
    // distinct.
    if(x < root->data) {
        root->left = insert(root->left, x);
        root->lCount++;
    }

    elseif(x > root->data)
        root->right = insert(root->right, x);
    returnroot;
}

// Function to find k'th smallest element in BST
// Here count denotes the number of nodes processed so far
Node* kthSmallest(Node* root, intk)
{
    // base case
    if(root == NULL)
        returnNULL;
    intcount = root->lCount + 1;
    if(count == k)
        returnroot;
    if(count > k)
        returnkthSmallest(root->left, k);
    // else search in right subtree
    returnkthSmallest(root->right, k - count);
}

// main function
intmain()
{
    Node* root = NULL;
    intkeys[] = { 20, 8, 22, 4, 12, 10, 14 };
    intkeys_size = sizeof(keys) / sizeof(keys[0]);

    for(inti = 0; i < keys_size; i++)
        root = insert(root, keys[i]);
    intk = 4;
    Node* res = kthSmallest(root, k);
    if(res == NULL)
        printf("There are less than k nodes in the BST");
    else
        printf("K-th Smallest Element is %d", res->data);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
