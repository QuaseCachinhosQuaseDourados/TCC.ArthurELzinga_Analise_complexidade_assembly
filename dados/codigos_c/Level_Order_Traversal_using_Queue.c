/* Problema: Level Order Traversal using Queue
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/level-order-tree-traversal/
 */

// Iterative Queue based C program
// to do level order traversal
// of Binary Tree
#include <stdio.h>
#include <stdlib.h>
#define MAX_Q_SIZE 500

// A binary tree node has data,
// pointer to left child
// and a pointer to right child
structnode {
    intdata;
    structnode* left;
    structnode* right;
};

// Function prototypes
structnode** createQueue(int*, int*);
voidenQueue(structnode**, int*, structnode*);
structnode* deQueue(structnode**, int*);

// Given a binary tree, print its nodes in level order
// using array for implementing queue
voidprintLevelOrder(structnode* root)
{
    intrear, front;
    structnode** queue = createQueue(&front, &rear);
    structnode* temp_node = root;

    while(temp_node) {
        printf("%d ", temp_node->data);

        // Enqueue left child
        if(temp_node->left)
            enQueue(queue, &rear, temp_node->left);

        // Enqueue right child
        if(temp_node->right)
            enQueue(queue, &rear, temp_node->right);

        // Dequeue node and make it temp_node
        temp_node = deQueue(queue, &front);
    }
}

// Utility functions
structnode** createQueue(int* front, int* rear)
{
    structnode** queue = (structnode**)malloc(
        sizeof(structnode*) * MAX_Q_SIZE);

    *front = *rear = 0;
    returnqueue;
}

voidenQueue(structnode** queue, int* rear,
             structnode* new_node)
{
    queue[*rear] = new_node;
    (*rear)++;
}

structnode* deQueue(structnode** queue, int* front)
{
    (*front)++;
    returnqueue[*front - 1];
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
