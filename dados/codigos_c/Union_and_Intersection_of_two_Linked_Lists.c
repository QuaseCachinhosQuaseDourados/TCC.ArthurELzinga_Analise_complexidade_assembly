/* Problema: Union and Intersection of two Linked Lists
 * Complexidade de Tempo: O(m*n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/union-and-intersection-of-two-linked-lists/
 */

// C program to find union
// and intersection of two unsorted
// linked lists
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
/* Linked list node */
structNode {
    intdata;
    structNode* next;
};

/* A utility function to insert a
   node at the beginning ofa linked list*/
voidpush(structNode** head_ref, intnew_data);

/* A utility function to check if
   given data is present in a list */
boolisPresent(structNode* head, intdata);

/* Function to get union of two
   linked lists head1 and head2 */
structNode* getUnion(structNode* head1,
                      structNode* head2)
{
    structNode* result = NULL;
    structNode *t1 = head1, *t2 = head2;

    // Insert all elements of
    // list1 to the result list
    while(t1 != NULL) {
        push(&result, t1->data);
        t1 = t1->next;
    }

    // Insert those elements of list2
    // which are not present in result list
    while(t2 != NULL) {
        if(!isPresent(result, t2->data))
            push(&result, t2->data);
        t2 = t2->next;
    }

    returnresult;
}

/* Function to get intersection of
  two linked lists head1 and head2 */
structNode* getIntersection(structNode* head1,
                             structNode* head2)
{
    structNode* result = NULL;
    structNode* t1 = head1;

    // Traverse list1 and search each element of it in
    // list2. If the element is present in list 2, then
    // insert the element to result
    while(t1 != NULL) {
        if(isPresent(head2, t1->data))
            push(&result, t1->data);
        t1 = t1->next;
    }

    returnresult;
}

/* A utility function to insert a
   node at the beginning of a linked list*/
voidpush(structNode** head_ref, intnew_data)
{
    /* allocate node */
    structNode* new_node
        = (structNode*)malloc(sizeof(structNode));

    /* put in the data */
    new_node->data = new_data;

    /* link the old list of the new node */
    new_node->next = (*head_ref);

    /* move the head to point to the new node */
    (*head_ref) = new_node;
}

/* A utility function to print a linked list*/
voidprintList(structNode* node)
{
    while(node != NULL) {
        printf("%d ", node->data);
        node = node->next;
    }
}

/* A utility function that returns true if data is
   present in linked list else return false */
boolisPresent(structNode* head, intdata)
{
    structNode* t = head;
    while(t != NULL) {
        if(t->data == data)
            return1;
        t = t->next;
    }
    return0;
}

/* Driver program to test above function*/
intmain()
{
    /* Start with the empty list */
    structNode* head1 = NULL;
    structNode* head2 = NULL;
    structNode* intersecn = NULL;
    structNode* unin = NULL;

    /*create a linked lists 10->15->5->20 */
    push(&head1, 20);
    push(&head1, 4);
    push(&head1, 15);
    push(&head1, 10);

    /*create a linked lists 8->4->2->10 */
    push(&head2, 10);
    push(&head2, 2);
    push(&head2, 4);
    push(&head2, 8);

    intersecn = getIntersection(head1, head2);
    unin = getUnion(head1, head2);

    printf("\n First list is \n");
    printList(head1);

    printf("\n Second list is \n");
    printList(head2);

    printf("\n Intersection list is \n");
    printList(intersecn);

    printf("\n Union list is \n");
    printList(unin);

    return0;
}
