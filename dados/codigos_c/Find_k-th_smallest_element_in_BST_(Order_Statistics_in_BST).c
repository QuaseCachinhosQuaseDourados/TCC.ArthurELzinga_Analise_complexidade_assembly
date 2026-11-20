/* Problema: Find k-th smallest element in BST (Order Statistics in BST)
 * Complexidade de Tempo: O(n)
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
} Node;

structNode* new_node(intx)
{
    structNode* p = malloc(sizeof(structNode));
    p->data = x;
    p->left = NULL;
    p->right = NULL;
    returnp;
}

// Recursive function to insert an key into BST
Node* insert(Node* root, intx)
{
    if(root == NULL)
        returnnew_node(x);
    if(x < root->data)
        root->left = insert(root->left, x);
    elseif(x > root->data)
        root->right = insert(root->right, x);
    returnroot;
}

// Function to find k'th smallest element in BST
// Here count denotes the number of nodes processed so far
intcount = 0;
Node* kthSmallest(Node* root, intk)
{
    // base case
    if(root == NULL)
        returnNULL;

    // search in left subtree
    Node* left = kthSmallest(root->left, k);

    // if k'th smallest is found in left subtree, return it
    if(left != NULL)
        returnleft;

    // if current element is k'th smallest, return it
    count++;
    if(count == k)
        returnroot;

    // else search in right subtree
    returnkthSmallest(root->right, k);
}

// Function to print k'th smallest element in BST
voidprintKthSmallest(Node* root, intk)
{
    // maintain index to count number of nodes processed so far
    Node* res = kthSmallest(root, k);
    if(res == NULL)
        printf("There are less than k nodes in the BST");
    else
        printf("K-th Smallest Element is %d", res->data);
}

// main function
intmain()
{
    Node* root = NULL;
    intkeys[] = { 20, 8, 22, 4, 12, 10, 14 };
    intkeys_size = sizeof(keys) / sizeof(keys[0]);

    for(inti = 0; i < keys_size; i++)
        root = insert(root, keys[i]);

    intk = 3;
    printKthSmallest(root, k);
    return0;
}

// This code is contributed by Aditya Kumar (adityakumar129)
