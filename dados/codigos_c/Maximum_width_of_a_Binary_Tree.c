/* Problema: Maximum width of a Binary Tree
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(1)
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

/*Function prototypes*/
intgetWidth(structnode* root, intlevel);
intheight(structnode* node);
structnode* newNode(intdata);

/* Function to get the maximum width of a binary tree*/
intgetMaxWidth(structnode* root)
{
    intmaxWidth = 0;
    intwidth;
    inth = height(root);
    inti;

    /* Get width of each level and compare
       the width with maximum width so far */
    for(i = 1; i <= h; i++) {
        width = getWidth(root, i);
        if(width > maxWidth)
            maxWidth = width;
    }

    returnmaxWidth;
}

/* Get width of a given level */
intgetWidth(structnode* root, intlevel)
{

    if(root == NULL)
        return0;

    if(level == 1)
        return1;

    elseif(level > 1)
        returngetWidth(root->left, level - 1)
               + getWidth(root->right, level - 1);
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
/* Driver code*/
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
  
    // Function call
    printf("Maximum width is %d \n", getMaxWidth(root));
    getchar();
    return0;
}
