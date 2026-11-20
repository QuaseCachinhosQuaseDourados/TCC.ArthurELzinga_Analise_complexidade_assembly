/* Problema: Queue – Linked List Implementation
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/queue-linked-list-implementation/
 */

// A C program to demonstrate linked list based
// implementation of queue
#include <stdio.h>
#include <stdlib.h>

// A linked list (LL) node to store a queue entry
structQNode {
    intkey;
    structQNode* next;
};

// The queue, front stores the front node of LL and rear
// stores the last node of LL
structQueue {
    structQNode *front, *rear;
};

// A utility function to create a new linked list node.
structQNode* newNode(intk)
{
    structQNode* temp
        = (structQNode*)malloc(sizeof(structQNode));
    temp->key = k;
    temp->next = NULL;
    returntemp;
}

// A utility function to create an empty queue
structQueue* createQueue()
{
    structQueue* q
        = (structQueue*)malloc(sizeof(structQueue));
    q->front = q->rear = NULL;
    returnq;
}

// The function to add a key k to q
voidenQueue(structQueue* q, intk)
{
    // Create a new LL node
    structQNode* temp = newNode(k);

    // If queue is empty, then new node is front and rear
    // both
    if(q->rear == NULL) {
        q->front = q->rear = temp;
        return;
    }

    // Add the new node at the end of queue and change rear
    q->rear->next = temp;
    q->rear = temp;
}

// Function to remove a key from given queue q
voiddeQueue(structQueue* q)
{
    // If queue is empty, return NULL.
    if(q->front == NULL)
        return;

    // Store previous front and move front one node ahead
    structQNode* temp = q->front;

    q->front = q->front->next;

    // If front becomes NULL, then change rear also as NULL
    if(q->front == NULL)
        q->rear = NULL;

    free(temp);
}

// Driver code
intmain()
{
    structQueue* q = createQueue();
    enQueue(q, 10);
    enQueue(q, 20);
    deQueue(q);
    deQueue(q);
    enQueue(q, 30);
    enQueue(q, 40);
    enQueue(q, 50);
    deQueue(q);
    printf("Queue Front : %d \n", ((q->front != NULL) ? (q->front)->key : -1));
    printf("Queue Rear : %d", ((q->rear != NULL) ? (q->rear)->key : -1));
    return0;
}
