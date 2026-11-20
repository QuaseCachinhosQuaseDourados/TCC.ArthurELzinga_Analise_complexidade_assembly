/* Problema: Maximum width of a Binary Tree
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(w)
 * Fonte: https://www.geeksforgeeks.org/maximum-width-of-a-binary-tree/
 */

// C program to calculate width of binary tree
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

// A utility function to get height of a binary tree
intheight(structnode* node);

// A utility function to allocate a new node with given data
structnode* newNode(intdata);

// A utility function that returns maximum value in arr[] of
// size n
intgetMax(intarr[], intn);

// A function that fills count array with count of nodes at
// every level of given binary tree
voidgetMaxWidthRecur(structnode* root, intcount[],
                      intlevel);

/* Function to get the maximum width of a binary tree*/
intgetMaxWidth(structnode* root)
{
    intwidth;
    inth = height(root);

    // Create an array that will store count of nodes at
    // each level
    int* count = (int*)calloc(sizeof(int), h);

    intlevel = 0;

    // Fill the count array using preorder traversal
    getMaxWidthRecur(root, count, level);

    // Return the maximum value from count array
    returngetMax(count, h);
}

// A function that fills count array with count of nodes at
// every level of given binary tree
voidgetMaxWidthRecur(structnode* root, intcount[],
                      intlevel)
{
    if(root) {
        count[level]++;
        getMaxWidthRecur(root->left, count, level + 1);
        getMaxWidthRecur(root->right, count, level + 1);
    }
}

/* UTILITY FUNCTIONS */
/* Compute the "height" of a tree -- the number of
    nodes along the longest path from the root node
    down to the farthest leaf node.*/
intheight(structnode* node)
{
    if(node == NULL)
        return0;
    else{
        /* compute the height of each subtree */
        intlHeight = height(node->left);
        intrHeight = height(node->right);
        /* use the larger one */

        return(lHeight > rHeight) ? (lHeight + 1)
                                   : (rHeight + 1);
    }
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

// Return the maximum value from count array
intgetMax(intarr[], intn)
{
    intmax = arr[0];
    inti;
    for(i = 0; i < n; i++) {
        if(arr[i] > max)
            max = arr[i];
    }
    returnmax;
}

/* Driver program to test above functions*/
intmain()
{
    structnode* root = newNode(1);
    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);
    root->right->right = newNode(8);
    root->right->right->left = newNode(6);
    root->right->right->right = newNode(7);

    /*
     Constructed binary tree is:
            1
          /  \
         2    3
       /  \     \
      4   5     8
                /  \
               6   7
    */
    printf("Maximum width is %d \n", getMaxWidth(root));
    getchar();
    return0;
}
