/* Problema: Find the Maximum Depth or Height of given Binary Tree
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/find-the-maximum-depth-or-height-of-a-tree/
 */

#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

/* Compute the "maxDepth" of a tree -- the number of
    nodes along the longest path from the root node
    down to the farthest leaf node.*/
intmaxDepth(structnode* node)
{
    if(node == NULL)
        return0;
    else{
        /* compute the depth of each subtree */
        intlDepth = maxDepth(node->left);
        intrDepth = maxDepth(node->right);

        /* use the larger one */
        if(lDepth > rDepth)
            return(lDepth + 1);
        else
            return(rDepth + 1);
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

intmain()
{
    structnode* root = newNode(1);

    root->left = newNode(2);
    root->right = newNode(3);
    root->left->left = newNode(4);
    root->left->right = newNode(5);

    printf("Height of tree is %d", maxDepth(root));

    getchar();
    return0;
}
