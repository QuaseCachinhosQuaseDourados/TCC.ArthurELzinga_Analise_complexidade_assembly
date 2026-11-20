/* Problema: Design a stack with operations on middle element
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/design-a-stack-with-find-middle-operation/
 */

/* Program to implement a stack that supports findMiddle()
   and deleteMiddle in O(1) time */
#include <stdio.h>
#include <stdlib.h>

/* A Doubly Linked List Node */
structDLLNode {
    structDLLNode* prev;
    intdata;
    structDLLNode* next;
};

/* Representation of the stack data structure that supports
   findMiddle() in O(1) time.  The Stack is implemented
   using Doubly Linked List. It maintains pointer to head
   node, pointer to middle node and count of nodes */
structmyStack {
    structDLLNode* head;
    structDLLNode* mid;
    intcount;
};

/* Function to create the stack data structure */
structmyStack* createMyStack()
{
    structmyStack* ms
        = (structmyStack*)malloc(sizeof(structmyStack));
    ms->count = 0;
    returnms;
};

/* Function to push an element to the stack */
voidpush(structmyStack* ms, intnew_data)
{
    /* allocate DLLNode and put in data */
    structDLLNode* new_DLLNode
        = (structDLLNode*)malloc(sizeof(structDLLNode));
    new_DLLNode->data = new_data;

    /* Since we are adding at the beginning,
      prev is always NULL */
    new_DLLNode->prev = NULL;

    /* link the old list of the new DLLNode */
    new_DLLNode->next = ms->head;

    /* Increment count of items in stack */
    ms->count += 1;

    /* Change mid pointer in two cases
       1) Linked List is empty
       2) Number of nodes in linked list is odd */
    if(ms->count == 1) {
        ms->mid = new_DLLNode;
    }
    else{
        ms->head->prev = new_DLLNode;

        if(ms->count & 1) // Update mid if ms->count is odd
            ms->mid = ms->mid->prev;
    }

    /* move head to point to the new DLLNode */
    ms->head = new_DLLNode;
}

/* Function to pop an element from stack */
intpop(structmyStack* ms)
{
    /* Stack underflow */
    if(ms->count == 0) {
        printf("Stack is empty\n");
        return-1;
    }

    structDLLNode* head = ms->head;
    intitem = head->data;
    ms->head = head->next;

    // If linked list doesn't become empty, update prev
    // of new head as NULL
    if(ms->head != NULL)
        ms->head->prev = NULL;

    ms->count -= 1;

    // update the mid pointer when we have even number of
    // elements in the stack, i,e move down the mid pointer.
    if(!((ms->count) & 1))
        ms->mid = ms->mid->next;

    free(head);

    returnitem;
}

// Function for finding middle of the stack
intfindMiddle(structmyStack* ms)
{
    if(ms->count == 0) {
        printf("Stack is empty now\n");
        return-1;
    }

    returnms->mid->data;
}

voiddeleteMiddle(structmyStack* ms)
{
    if(ms->count == 0) {
        printf("Stack is empty now\n");
        return;
    }
  
    ms->count -= 1;
    ms->mid->next->prev = ms->mid->prev;
    ms->mid->prev->next = ms->mid->next;

    if(ms->count % 2 != 0) {
      ms->mid=ms->mid->next;
    }else{
      ms->mid=ms->mid->prev;
    }
}

// Driver program to test functions of myStack
intmain()
{
    /* Let us create a stack using push() operation*/
    structmyStack* ms = createMyStack();
    push(ms, 11);
    push(ms, 22);
    push(ms, 33);
    push(ms, 44);
    push(ms, 55);
    push(ms, 66);
    push(ms, 77);
    push(ms, 88);
    push(ms, 99);

    printf("Popped : %d\n", pop(ms));
    printf("Popped : %d\n", pop(ms));
    printf("Middle Element : %d\n", findMiddle(ms));
      deleteMiddle(ms);
      printf("New Middle Element : %d\n", findMiddle(ms));
    return0;
}
//Updated by Amsavarthan Lv
