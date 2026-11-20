/* Problema: Queue using Stacks
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/queue-using-stacks/
 */

/* C Program to implement a queue using two stacks */
#include <stdio.h>
#include <stdlib.h>

/* structure of a stack node */
structsNode {
    intdata;
    structsNode* next;
};

/* Function to push an item to stack*/
voidpush(structsNode** top_ref, intnew_data);

/* Function to pop an item from stack*/
intpop(structsNode** top_ref);

/* structure of queue having two stacks */
structqueue {
    structsNode* stack1;
    structsNode* stack2;
};

/* Function to enqueue an item to queue */
voidenQueue(structqueue* q, intx)
{
    push(&q->stack1, x);
}

/* Function to deQueue an item from queue */
intdeQueue(structqueue* q)
{
    intx;

    /* If both stacks are empty then error */
    if(q->stack1 == NULL && q->stack2 == NULL) {
        return-1;
    }

    /* Move elements from stack1 to stack 2 only if
       stack2 is empty */
    if(q->stack2 == NULL) {
        while(q->stack1 != NULL) {
            x = pop(&q->stack1);
            push(&q->stack2, x);
        }
    }

    x = pop(&q->stack2);
    returnx;
}

/* Function to push an item to stack*/
voidpush(structsNode** top_ref, intnew_data)
{
    /* allocate node */
    structsNode* new_node = (structsNode*)malloc(sizeof(structsNode));
    if(new_node == NULL) {
        printf("Stack overflow \n");
        getchar();
        exit(0);
    }

    /* put in the data */
    new_node->data = new_data;

    /* link the old list of the new node */
    new_node->next = (*top_ref);

    /* move the head to point to the new node */
    (*top_ref) = new_node;
}

/* Function to pop an item from stack*/
intpop(structsNode** top_ref)
{
    intres;
    structsNode* top;

    /*If stack is empty then error */
    if(*top_ref == NULL) {
        return-1;
    }
    else{
        top = *top_ref;
        res = top->data;
        *top_ref = top->next;
        free(top);
        returnres;
    }
}

/* Driver function to test anove functions */
intmain()
{
    /* Create a queue with items 1 2 3*/
    structqueue* q = (structqueue*)malloc(sizeof(structqueue));
    q->stack1 = NULL;
    q->stack2 = NULL;
    enQueue(q, 1);
    enQueue(q, 2);
    enQueue(q, 3);

    /* Dequeue items */
    printf("%d ", deQueue(q));
    printf("%d ", deQueue(q));
    printf("%d ", deQueue(q));

    return0;
}
