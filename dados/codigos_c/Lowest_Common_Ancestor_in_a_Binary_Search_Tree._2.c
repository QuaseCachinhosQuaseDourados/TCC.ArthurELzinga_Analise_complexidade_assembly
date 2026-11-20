/* Problema: Lowest Common Ancestor in a Binary Search Tree.
 * Complexidade de Tempo: O(H)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/lowest-common-ancestor-in-a-binary-search-tree/
 */

// A recursive C program to find LCA of two nodes n1 and n2.
#include <stdio.h>
#include <stdlib.h>

structnode {
    intdata;
    structnode *left, *right;
};

/* Function to find LCA of n1 and n2. The function assumes
that both n1 and n2 are present in BST */
structnode* lca(structnode* root, intn1, intn2)
{
    while(root != NULL) {
        // If both n1 and n2 are smaller than root, then LCA
        // lies in left
        if(root->data > n1 && root->data > n2)
            root = root->left;

        // If both n1 and n2 are greater than root, then LCA
        // lies in right
        elseif(root->data < n1 && root->data < n2)
            root = root->right;

        else
            break;
    }
    returnroot;
}

/* Helper function that allocates a new node with the given
 * data.*/
structnode* newNode(intdata)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = node->right = NULL;
    return(node);
}

/* Driver code */
intmain()
{
    // Let us construct the BST shown in the above figure
    structnode* root = newNode(20);
    root->left = newNode(8);
    root->right = newNode(22);
    root->left->left = newNode(4);
    root->left->right = newNode(12);
    root->left->right->left = newNode(10);
    root->left->right->right = newNode(14);

    // Function calls      
    intn1 = 10, n2 = 14;
    structnode* t = lca(root, n1, n2);
    printf("LCA of %d and %d is %d \n", n1, n2, t->data);

    n1 = 14, n2 = 8;
    t = lca(root, n1, n2);
    printf("LCA of %d and %d is %d \n", n1, n2, t->data);

    n1 = 10, n2 = 22;
    t = lca(root, n1, n2);
    printf("LCA of %d and %d is %d \n", n1, n2, t->data);

    getchar();
    return0;
}
