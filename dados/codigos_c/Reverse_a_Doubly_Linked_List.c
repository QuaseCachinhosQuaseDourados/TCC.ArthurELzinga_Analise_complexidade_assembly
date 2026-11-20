/* Problema: Reverse a Doubly Linked List
 * Complexidade de Tempo: O(N)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/reverse-a-doubly-linked-list/
 */

/* Program to reverse a doubly linked list */

#include <stdio.h>
#include <stdlib.h>

/* a node of the doubly linked list */
structNode {
    intdata;
    structNode* next;
    structNode* prev;
};

/* Function to reverse a Doubly Linked List */
voidreverse(structNode** head_ref)
{
    structNode* temp = NULL;
    structNode* current = *head_ref;

    /* swap next and prev for all nodes of
      doubly linked list */
    while(current != NULL) {
        temp = current->prev;
        current->prev = current->next;
        current->next = temp;
        current = current->prev;
    }

    /* Before changing head, check for the cases like empty
       list and list with only one node */
    if(temp != NULL)
        *head_ref = temp->prev;
}

/* UTILITY FUNCTIONS */
/* Function to insert a node at the beginning of the Doubly
 * Linked List */
voidpush(structNode** head_ref, intnew_data)
{
    /* allocate node */
    structNode* new_node
        = (structNode*)malloc(sizeof(structNode));

    /* put in the data  */
    new_node->data = new_data;

    /* since we are adding at the beginning,
      prev is always NULL */
    new_node->prev = NULL;

    /* link the old list of the new node */
    new_node->next = (*head_ref);

    /* change prev of head node to new node */
    if((*head_ref) != NULL)
        (*head_ref)->prev = new_node;

    /* move the head to point to the new node */
    (*head_ref) = new_node;
}

/* Function to print nodes in a given doubly linked list
   This function is same as printList() of singly linked
   list */
voidprintList(structNode* node)
{
    while(node != NULL) {
        printf("%d ", node->data);
        node = node->next;
    }
}

// Driver's code
intmain()
{
    /* Start with the empty list */
    structNode* head = NULL;

    /* Let us create a sorted linked list to test the
     functions Created linked list will be 10->8->4->2 */
    push(&head, 2);
    push(&head, 4);
    push(&head, 8);
    push(&head, 10);

    printf("\n Original Linked list ");
    printList(head);

    // Function call
    reverse(&head);

    printf("\n Reversed Linked list ");
    printList(head);

    getchar();
}
