/* Problema: A program to check if a Binary Tree is BST or not
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(H)
 * Fonte: https://www.geeksforgeeks.org/a-program-to-check-if-a-binary-tree-is-bst-or-not/
 */

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

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

intmaxValue(structnode* node)
{
    if(node == NULL) {
        return0;
    }

    intleftMax = maxValue(node->left);
    intrightMax = maxValue(node->right);

    intvalue = 0;
    if(leftMax > rightMax) {
        value = leftMax;
    }
    else{
        value = rightMax;
    }

    if(value < node->data) {
        value = node->data;
    }

    returnvalue;
}

intminValue(structnode* node)
{
    if(node == NULL) {
        return1000000000;
    }

    intleftMax = minValue(node->left);
    intrightMax = minValue(node->right);

    intvalue = 0;
    if(leftMax < rightMax) {
        value = leftMax;
    }
    else{
        value = rightMax;
    }

    if(value > node->data) {
        value = node->data;
    }

    returnvalue;
}

/* Returns true if a binary tree is a binary search tree */
intisBST(structnode* node)
{
    if(node == NULL)
        return1;

    /* false if the max of the left is > than us */
    if(node->left != NULL
        && maxValue(node->left) > node->data)
        return0;

    /* false if the min of the right is <= than us */
    if(node->right != NULL
        && minValue(node->right) < node->data)
        return0;

    /* false if, recursively, the left or right is not a BST
     */
    if(!isBST(node->left) || !isBST(node->right))
        return0;

    /* passing all that, it's a BST */
    return1;
}

/* Driver code*/
intmain()
{
    structnode* root = newNode(4);
    root->left = newNode(5);
    root->right = newNode(6);
   // root->left->left = newNode(1);
    //root->left->right = newNode(3);

    // Function call
    if(isBST(root))
        printf("Is BST");
    else
        printf("Not a BST");

    getchar();
    return0;
}
