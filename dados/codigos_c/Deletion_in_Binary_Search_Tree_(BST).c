/* Problema: Deletion in Binary Search Tree (BST)
 * Complexidade de Tempo: O(h)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/deletion-in-binary-search-tree/
 */

// C program to implement optimized delete in BST.
#include <stdio.h>
#include <stdlib.h>

structNode {
    intkey;
    structNode *left, *right;
};

// A utility function to create a new BST node
structNode* newNode(intitem)
{
    structNode* temp = (structNode*)malloc(sizeof(structNode));
    temp->key = item;
    temp->left = temp->right = NULL;
    returntemp;
}

// A utility function to do inorder traversal of BST
voidinorder(structNode* root)
{
    if(root != NULL) {
        inorder(root->left);
        printf("%d ", root->key);
        inorder(root->right);
    }
}

/* A utility function to insert a new node with given key in
 * BST */
structNode* insert(structNode* node, intkey)
{
    /* If the tree is empty, return a new node */
    if(node == NULL)
        returnnewNode(key);

    /* Otherwise, recur down the tree */
    if(key < node->key)
        node->left = insert(node->left, key);
    else
        node->right = insert(node->right, key);

    /* return the (unchanged) node pointer */
    returnnode;
}

/* Given a binary search tree and a key, this function
   deletes the key and returns the new root */
structNode* deleteNode(structNode* root, intk)
{
    // Base case
    if(root == NULL)
        returnroot;

    // Recursive calls for ancestors of
    // node to be deleted
    if(root->key > k) {
        root->left = deleteNode(root->left, k);
        returnroot;
    }
    elseif(root->key < k) {
        root->right = deleteNode(root->right, k);
        returnroot;
    }

    // We reach here when root is the node
    // to be deleted.

    // If one of the children is empty
    if(root->left == NULL) {
        structNode* temp = root->right;
        free(root);
        returntemp;
    }
    elseif(root->right == NULL) {
        structNode* temp = root->left;
        free(root);
        returntemp;
    }

    // If both children exist
    else{

        structNode* succParent = root;

        // Find successor
        structNode* succ = root->right;
        while(succ->left != NULL) {
            succParent = succ;
            succ = succ->left;
        }

        // Delete successor.  Since successor
        // is always left child of its parent
        // we can safely make successor's right
        // right child as left of its parent.
        // If there is no succ, then assign
        // succ->right to succParent->right
        if(succParent != root)
            succParent->left = succ->right;
        else
            succParent->right = succ->right;

        // Copy Successor Data to root
        root->key = succ->key;

        // Delete Successor and return root
        free(succ);
        returnroot;
    }
}

// Driver Code
intmain()
{
    /* Let us create following BST
              50
           /     \
          30      70
         /  \    /  \
       20   40  60   80 */
    structNode* root = NULL;
    root = insert(root, 50);
    root = insert(root, 30);
    root = insert(root, 20);
    root = insert(root, 40);
    root = insert(root, 70);
    root = insert(root, 60);

    printf("Original BST: ");
    inorder(root);
  
    printf("\n\nDelete a Leaf Node: 20\n");
    root = deleteNode(root, 20);
    printf("Modified BST tree after deleting Leaf Node:\n");
    inorder(root);

    printf("\n\nDelete Node with single child: 70\n");
    root = deleteNode(root, 70);
    printf("Modified BST tree after deleting single child Node:\n");
    inorder(root);

    printf("\n\nDelete Node with both child: 50\n");
    root = deleteNode(root, 50);
    printf("Modified BST tree after deleting both child Node:\n");
    inorder(root);

    return0;
}
