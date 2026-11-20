/* Problema: Construct Tree from given Inorder and Preorder traversals
 * Complexidade de Tempo: O(n^2)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/construct-tree-from-given-inorder-and-preorder-traversal/
 */

/* program to construct tree using inorder and preorder traversals */
#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    chardata;
    structnode* left;
    structnode* right;
};

/* Prototypes for utility functions */
intsearch(chararr[], intstrt, intend, charvalue);
structnode* newNode(chardata);

/* Recursive function to construct binary of size len from
   Inorder traversal in[] and Preorder traversal pre[].  Initial values
   of inStrt and inEnd should be 0 and len -1.  The function doesn't
   do any error checking for cases where inorder and preorder
   do not form a tree */
structnode* buildTree(charin[], charpre[], intinStrt, intinEnd)
{
    staticintpreIndex = 0;

    if(inStrt > inEnd)
        returnNULL;

    /* Pick current node from Preorder traversal using preIndex
    and increment preIndex */
    structnode* tNode = newNode(pre[preIndex++]);

    /* If this node has no children then return */
    if(inStrt == inEnd)
        returntNode;

    /* Else find the index of this node in Inorder traversal */
    intinIndex = search(in, inStrt, inEnd, tNode->data);

    /* Using index in Inorder traversal, construct left and
     right subtress */
    tNode->left = buildTree(in, pre, inStrt, inIndex - 1);
    tNode->right = buildTree(in, pre, inIndex + 1, inEnd);

    returntNode;
}

/* UTILITY FUNCTIONS */
/* Function to find index of value in arr[start...end]
   The function assumes that value is present in in[] */
intsearch(chararr[], intstrt, intend, charvalue)
{
    inti;
    for(i = strt; i <= end; i++) {
        if(arr[i] == value)
            returni;
    }
}

/* Helper function that allocates a new node with the
   given data and NULL left and right pointers. */
structnode* newNode(chardata)
{
    structnode* node = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;

    return(node);
}

/* This function is here just to test buildTree() */
voidprintInorder(structnode* node)
{
    if(node == NULL)
        return;

    /* first recur on left child */
    printInorder(node->left);

    /* then print the data of node */
    printf("%c ", node->data);

    /* now recur on right child */
    printInorder(node->right);
}

/* Driver program to test above functions */
intmain()
{
    charin[] = { 'D', 'B', 'E', 'A', 'F', 'C'};
    charpre[] = { 'A', 'B', 'D', 'E', 'C', 'F'};
    intlen = sizeof(in) / sizeof(in[0]);
    structnode* root = buildTree(in, pre, 0, len - 1);

    /* Let us test the built tree by printing Inorder traversal */
    printf("Inorder traversal of the constructed tree is \n");
    printInorder(root);
    getchar();
}
