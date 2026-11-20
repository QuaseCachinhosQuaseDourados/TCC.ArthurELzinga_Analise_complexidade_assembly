/* Problema: Inorder Tree Traversal without Recursion
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/inorder-tree-traversal-without-recursion/
 */

#include <stdio.h>
#include <stdlib.h>
#define bool int

// A binary tree tNode has data, pointer to left child
// and a pointer to right child
structtNode {
    intdata;
    structtNode* left;
    structtNode* right;
};

// Structure of a stack node. Linked List implementation is
// used for stack. A stack node contains a pointer to tree
// node and a pointer to next stack node
structsNode {
    structtNode* t;
    structsNode* next;
};

// Stack related functions
voidpush(structsNode** top_ref, structtNode* t);
structtNode* pop(structsNode** top_ref);
boolisEmpty(structsNode* top);

// Iterative function for inorder tree traversal
voidinOrder(structtNode* root)
{
    // Set current to root of binary tree
    structtNode* current = root;
  
    // Initialize stack s
    structsNode* s = NULL;
    booldone = 0;

    while(!done) {
        
        // Reach the left most tNode of the current tNode
        if(current != NULL) {
            
            // Place pointer to a tree node on the stack
            // before traversing the node's left subtree
            push(&s, current);
            current = current->left;
        }

        // Backtrack from the empty subtree and visit the
        // tNode at the top of the stack; however, if the
        // stack is empty, you are done
        else{
            if(!isEmpty(s)) {
                current = pop(&s);
                printf("%d ", current->data);

                // we have visited the node and its left
                // subtree. Now, it's right subtree's turn
                current = current->right;
            }
            else
                done = 1;
        }
    }
}

// Function to push an item to sNode
voidpush(structsNode** top_ref, structtNode* t)
{
    // Allocate tNode
    structsNode* new_tNode
        = (structsNode*)malloc(sizeof(structsNode));

    if(new_tNode == NULL) {
        printf("Stack Overflow \n");
        getchar();
        exit(0);
    }

    // Put in the data
    new_tNode->t = t;

    // Link the old list of the new tNode
    new_tNode->next = (*top_ref);

    // Move the head to point to the new tNode
    (*top_ref) = new_tNode;
}

// The function returns true if stack is empty,
// otherwise false
boolisEmpty(structsNode* top)
{
    return(top == NULL) ? 1 : 0;
}

// Function to pop an item from stack
structtNode* pop(structsNode** top_ref)
{
    structtNode* res;
    structsNode* top;

    // If sNode is empty then error
    if(isEmpty(*top_ref)) {
        printf("Stack Underflow \n");
        getchar();
        exit(0);
    }
    else{
        top = *top_ref;
        res = top->t;
        *top_ref = top->next;
        free(top);
        returnres;
    }
}

// Helper function that allocates a new tNode with the
// given data and NULL left and right pointers.
structtNode* newtNode(intdata)
{
    structtNode* tNode
        = (structtNode*)malloc(sizeof(structtNode));
    tNode->data = data;
    tNode->left = NULL;
    tNode->right = NULL;

    return(tNode);
}

// Driver program to test above functions
intmain()
{
    /* Constructed binary tree is
              1
            /   \
          2      3
        /  \
      4     5
    */
    structtNode* root = newtNode(1);
    root->left = newtNode(2);
    root->right = newtNode(3);
    root->left->left = newtNode(4);
    root->left->right = newtNode(5);

    inOrder(root);

    getchar();
    return0;
}
