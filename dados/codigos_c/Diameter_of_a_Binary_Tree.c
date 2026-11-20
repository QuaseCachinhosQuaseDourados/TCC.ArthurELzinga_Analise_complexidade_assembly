/* Problema: Diameter of a Binary Tree
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/diameter-of-a-binary-tree/
 */

// Recursive optimized C program to find the diameter of a
// Binary Tree
#include <stdio.h>
#include <stdlib.h>

// A binary tree node has data, pointer to left child
// and a pointer to right child
structnode {
    intdata;
    structnode *left, *right;
};

// function to create a new node of tree and returns pointer
structnode* newNode(intdata);

// returns max of two integers
intmax(inta, intb) { return(a > b) ? a : b; }

// function to Compute height of a tree.
intheight(structnode* node);

// Function to get diameter of a binary tree
intdiameter(structnode* tree)
{
    // base case where tree is empty
    if(tree == NULL)
        return0;

    // get the height of left and right sub-trees
    intlheight = height(tree->left);
    intrheight = height(tree->right);

    // get the diameter of left and right sub-trees
    intldiameter = diameter(tree->left);
    intrdiameter = diameter(tree->right);

    // Return max of following three
    // 1) Diameter of left subtree
    // 2) Diameter of right subtree
    // 3) Height of left subtree + height of right subtree +
    // 1

    returnmax(lheight + rheight + 1,
               max(ldiameter, rdiameter));
}

// UTILITY FUNCTIONS TO TEST diameter() FUNCTION

//  The function Compute the "height" of a tree. Height is
//  the number f nodes along the longest path from the root
//   node down to the farthest leaf node.
intheight(structnode* node)
{
    // base case tree is empty
    if(node == NULL)
        return0;

    // If tree is not empty then height = 1 + max of left
    // height and right heights
    return1 + max(height(node->left), height(node->right));
}

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

// Driver Code
intmain()
{

    /* Constructed binary tree is
              1
            /   \
          2      3
        /  \
      4     5
    */
    structnode* root = newNode(1);
    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);

    // Function Call
    printf("Diameter of the given binary tree is %d\n",
           diameter(root));

    return0;
}
