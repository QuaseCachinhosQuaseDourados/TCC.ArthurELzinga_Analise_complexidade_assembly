/* Problema: How to Reverse a Stack using Recursion
 * Complexidade de Tempo: O(N2)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/reverse-a-stack-using-recursion/
 */

// C program to reverse a
// stack using recursion
#include <stdio.h>
#include <stdlib.h>
#define bool int

// structure of a stack node
structsNode {
    chardata;
    structsNode* next;
};

// Function Prototypes
voidpush(structsNode** top_ref, intnew_data);
intpop(structsNode** top_ref);
boolisEmpty(structsNode* top);
voidprint(structsNode* top);

// Below is a recursive function
// that inserts an element
// at the bottom of a stack.
voidinsertAtBottom(structsNode** top_ref, intitem)
{
    if(isEmpty(*top_ref))
        push(top_ref, item);
    else{

        // Hold all items in Function Call
        // Stack until we reach end of the
        // stack. When the stack becomes
        // empty, the isEmpty(*top_ref)becomes
        // true, the above if part is executed
        // and the item is inserted at the bottom
        inttemp = pop(top_ref);
        insertAtBottom(top_ref, item);

        // Once the item is inserted
        // at the bottom, push all
        // the items held in Function
        // Call Stack
        push(top_ref, temp);
    }
}

// Below is the function that
// reverses the given stack using
// insertAtBottom()
voidreverse(structsNode** top_ref)
{
    if(!isEmpty(*top_ref)) {
        // Hold all items in Function
        // Call Stack until we
        // reach end of the stack
        inttemp = pop(top_ref);
        reverse(top_ref);

        // Insert all the items (held in
        // Function Call Stack)
        // one by one from the bottom
        // to top. Every item is
        // inserted at the bottom
        insertAtBottom(top_ref, temp);
    }
}

// Driver Code
intmain()
{
    structsNode* s = NULL;
    push(&s, 4);
    push(&s, 3);
    push(&s, 2);
    push(&s, 1);

    printf("\n Original Stack ");
    print(s);
    reverse(&s);
    printf("\n Reversed Stack ");
    print(s);
    return0;
}

// Function to check if
// the stack is empty
boolisEmpty(structsNode* top)
{
    return(top == NULL) ? 1 : 0;
}

// Function to push an item to stack
voidpush(structsNode** top_ref, intnew_data)
{

    // allocate node
    structsNode* new_node
        = (structsNode*)malloc(sizeof(structsNode));

    if(new_node == NULL) {
        printf("Stack overflow \n");
        exit(0);
    }

    // put in the data
    new_node->data = new_data;

    // link the old list
    // off the new node
    new_node->next = (*top_ref);

    // move the head to
    // point to the new node
    (*top_ref) = new_node;
}

// Function to pop an item from stack
intpop(structsNode** top_ref)
{
    charres;
    structsNode* top;

    // If stack is empty then error
    if(*top_ref == NULL) {
        printf("Stack overflow \n");
        exit(0);
    }
    else{
        top = *top_ref;
        res = top->data;
        *top_ref = top->next;
        free(top);
        returnres;
    }
}

// Function to print a
// linked list
voidprint(structsNode* top)
{
    printf("\n");
    while(top != NULL) {
        printf(" %d ", top->data);
        top = top->next;
    }
}
