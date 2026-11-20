/* Problema: Binary Tree to Binary Search Tree Conversion
 * Complexidade de Tempo: O(nlogn)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/binary-tree-to-binary-search-tree-conversion/
 */

/* A program to convert Binary Tree to Binary Search Tree */
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node structure */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

/* A helper function that stores inorder traversal of a tree rooted
with node */
voidstoreInorder(structnode* node, intinorder[], int* index_ptr)
{
    // Base Case
    if(node == NULL)
        return;

    /* first store the left subtree */
    storeInorder(node->left, inorder, index_ptr);

    /* Copy the root's data */
    inorder[*index_ptr] = node->data;
    (*index_ptr)++; // increase index for next entry

    /* finally store the right subtree */
    storeInorder(node->right, inorder, index_ptr);
}

/* A helper function to count nodes in a Binary Tree */
intcountNodes(structnode* root)
{
    if(root == NULL)
        return0;
    returncountNodes(root->left) + countNodes(root->right) + 1;
}

// Following function is needed for library function qsort()
intcompare(constvoid* a, constvoid* b)
{
    return(*(int*)a - *(int*)b);
}

/* A helper function that copies contents of arr[] to Binary Tree.
This function basically does Inorder traversal of Binary Tree and
one by one copy arr[] elements to Binary Tree nodes */
voidarrayToBST(int* arr, structnode* root, int* index_ptr)
{
    // Base Case
    if(root == NULL)
        return;

    /* first update the left subtree */
    arrayToBST(arr, root->left, index_ptr);

    /* Now update root's data and increment index */
    root->data = arr[*index_ptr];
    (*index_ptr)++;

    /* finally update the right subtree */
    arrayToBST(arr, root->right, index_ptr);
}

// This function converts a given Binary Tree to BST
voidbinaryTreeToBST(structnode* root)
{
    // base case: tree is empty
    if(root == NULL)
        return;

    /* Count the number of nodes in Binary Tree so that
    we know the size of temporary array to be created */
    intn = countNodes(root);

    // Create a temp array arr[] and store inorder traversal of tree in arr[]
    int* arr = newint[n];
    inti = 0;
    storeInorder(root, arr, &i);

    // Sort the array using library function for quick sort
    qsort(arr, n, sizeof(arr[0]), compare);

    // Copy array elements back to Binary Tree
    i = 0;
    arrayToBST(arr, root, &i);

    // delete dynamically allocated memory to avoid memory leak
    delete[] arr;
}

/* Utility function to create a new Binary Tree node */
structnode* newNode(intdata)
{
    structnode* temp = newstructnode;
    temp->data = data;
    temp->left = NULL;
    temp->right = NULL;
    returntemp;
}

/* Utility function to print inorder traversal of Binary Tree */
voidprintInorder(structnode* node)
{
    if(node == NULL)
        return;

    /* first recur on left child */
    printInorder(node->left);

    /* then print the data of node */
    printf("%d ", node->data);

    /* now recur on right child */
    printInorder(node->right);
}

/* Driver function to test above functions */
intmain()
{
    structnode* root = NULL;

    /* Constructing tree given in the above figure
        10
        / \
        30 15
    /     \
    20     5 */
    root = newNode(10);
    root->left = newNode(30);
    root->right = newNode(15);
    root->left->left = newNode(20);
    root->right->right = newNode(5);

    // convert Binary Tree to BST
    binaryTreeToBST(root);

    printf("Following is Inorder Traversal of the converted BST: \n");
    printInorder(root);

    return0;
}
