/* Problema: Level Order Traversal (Breadth First Search or BFS) of Binary Tree
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/level-order-tree-traversal/
 */

// Recursive C program for level
// order traversal of Binary Tree
#include <stdio.h>
#include <stdlib.h>

// A binary tree node has data,
// pointer to left child
// and a pointer to right child
structnode {
    intdata;
    structnode *left, *right;
};

// Function prototypes
voidprintCurrentLevel(structnode* root, intlevel);
intheight(structnode* node);
structnode* newNode(intdata);

// Function to print level order traversal a tree
voidprintLevelOrder(structnode* root)
{
    inth = height(root);
    inti;
    for(i = 1; i <= h; i++)
        printCurrentLevel(root, i);
}

// Print nodes at a current level
voidprintCurrentLevel(structnode* root, intlevel)
{
    if(root == NULL)
        return;
    if(level == 1)
        printf("%d ", root->data);
    elseif(level > 1) {
        printCurrentLevel(root->left, level - 1);
        printCurrentLevel(root->right, level - 1);
    }
}

// Compute the "height" of a tree -- the number of
// nodes along the longest path from the root node
// down to the farthest leaf node
intheight(structnode* node)
{
    if(node == NULL)
        return0;
    else{
        
        // Compute the height of each subtree
        intlheight = height(node->left);
        intrheight = height(node->right);

        // Use the larger one
        if(lheight > rheight)
            return(lheight + 1);
        else
            return(rheight + 1);
    }
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

// Driver program to test above functions
intmain()
{
    structnode* root = newNode(1);
    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);

    printf("Level Order traversal of binary tree is \n");
    printLevelOrder(root);

    return0;
}
