/* Problema: Traversal of Circular Linked List
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/traversal-of-circular-linked-list/
 */

// C program to implement
// the above approach
#include<stdio.h>
#include<stdlib.h>

/* structure for a node */
structNode
{
    intdata;
    structNode *next;
};

/* Function to insert a node at the beginning of a Circular
   linked list */
voidpush(structNode **head_ref, intdata)
{
    structNode *ptr1 = (structNode *)malloc(sizeof(structNode));
    structNode *temp = *head_ref;
    ptr1->data = data;
    ptr1->next = *head_ref;

    /* If linked list is not NULL then set the next of last node */
    if(*head_ref != NULL)
    {
        while(temp->next != *head_ref)
            temp = temp->next;
        temp->next = ptr1;
    }
    else
        ptr1->next = ptr1; /*For the first node */

    *head_ref = ptr1;
}

/* Function to print nodes in a given Circular linked list */
voidprintList(structNode *head)
{
    structNode *temp = head;
    if(head != NULL)
    {
        do
        {
            printf("%d ", temp->data);
            temp = temp->next;
        }
        while(temp != head);
    }
}

/* Driver program to test above functions */
intmain()
{
    /* Initialize lists as empty */
    structNode *head = NULL;

    /* Created linked list will be 11->2->56->12 */
    push(&head, 12);
    push(&head, 56);
    push(&head, 2);
    push(&head, 11);

    printf("Contents of Circular Linked List\n ");
    printList(head);

    return0;
}
