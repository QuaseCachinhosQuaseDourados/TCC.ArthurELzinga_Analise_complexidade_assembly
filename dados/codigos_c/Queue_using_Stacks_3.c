/* Problema: Queue using Stacks
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/queue-using-stacks/
 */

/* Program to implement a queue using one user defined stack 
and one Function Call Stack */
#include <stdio.h>
#include <stdlib.h>

/* structure of a stack node */
structsNode {
    intdata;
    structsNode* next;
};

/* structure of queue having two stacks */
structqueue {
    structsNode* stack1;
};

/* Function to push an item to stack*/
voidpush(structsNode** top_ref, intnew_data);

/* Function to pop an item from stack*/
intpop(structsNode** top_ref);

/* Function to enqueue an item to queue */
voidenQueue(structqueue* q, intx)
{
    push(&q->stack1, x);
}

/* Function to deQueue an item from queue */
intdeQueue(structqueue* q)
{
    intx, res;

    /* If both stacks are empty then error */
    if(q->stack1 == NULL) {
        return-1;
    }
    elseif(q->stack1->next == NULL) {
        returnpop(&q->stack1);
    }
    else{
        /* pop an item from the stack1 */
        x = pop(&q->stack1);

        /* store the last deQueued item */
        res = deQueue(q);

        /* push everything back to stack1 */
        push(&q->stack1, x);
        returnres;
    }
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

/* Driver function to test above functions */
intmain()
{
    /* Create a queue with items 1 2 3*/
    structqueue* q = (structqueue*)malloc(sizeof(structqueue));
    q->stack1 = NULL;

    enQueue(q, 1);
    enQueue(q, 2);
    enQueue(q, 3);

    /* Dequeue items */
    printf("%d ", deQueue(q));
    printf("%d ", deQueue(q));
    printf("%d ", deQueue(q));

    return0;
}
