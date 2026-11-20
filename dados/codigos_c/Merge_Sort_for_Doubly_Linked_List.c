/* Problema: Merge Sort for Doubly Linked List
 * Complexidade de Tempo: Θ(nLogn)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/merge-sort-for-doubly-linked-list/
 */

// C program for merge sort on doubly linked list
#include<stdio.h>
#include<stdlib.h>
structNode
{
    intdata;
    structNode *next, *prev;
};

structNode *split(structNode *head);

// Function to merge two linked lists
structNode *merge(structNode *first, structNode *second)
{
    // If first linked list is empty
    if(!first)
        returnsecond;

    // If second linked list is empty
    if(!second)
        returnfirst;

    // Pick the smaller value
    if(first->data < second->data)
    {
        first->next = merge(first->next,second);
        first->next->prev = first;
        first->prev = NULL;
        returnfirst;
    }
    else
    {
        second->next = merge(first,second->next);
        second->next->prev = second;
        second->prev = NULL;
        returnsecond;
    }
}

// Function to do merge sort
structNode *mergeSort(structNode *head)
{
    if(!head || !head->next)
        returnhead;
    structNode *second = split(head);

    // Recur for left and right halves
    head = mergeSort(head);
    second = mergeSort(second);

    // Merge the two sorted halves
    returnmerge(head,second);
}

// A utility function to insert a new node at the
// beginning of doubly linked list
voidinsert(structNode **head, intdata)
{
    structNode *temp =
        (structNode *)malloc(sizeof(structNode));
    temp->data = data;
    temp->next = temp->prev = NULL;
    if(!(*head))
        (*head) = temp;
    else
    {
        temp->next = *head;
        (*head)->prev = temp;
        (*head) = temp;
    }
}

// A utility function to print a doubly linked list in
// both forward and backward directions
voidprint(structNode *head)
{
    structNode *temp = head;
    printf("Forward Traversal using next pointer\n");
    while(head)
    {
        printf("%d ",head->data);
        temp = head;
        head = head->next;
    }
    printf("\nBackward Traversal using prev pointer\n");
    while(temp)
    {
        printf("%d ", temp->data);
        temp = temp->prev;
    }
}

// Utility function to swap two integers
voidswap(int*A, int*B)
{
    inttemp = *A;
    *A = *B;
    *B = temp;
}

// Split a doubly linked list (DLL) into 2 DLLs of
// half sizes
structNode *split(structNode *head)
{
    structNode *fast = head,*slow = head;
    while(fast->next && fast->next->next)
    {
        fast = fast->next->next;
        slow = slow->next;
    }
    structNode *temp = slow->next;
    slow->next = NULL;
    returntemp;
}

// Driver program
intmain(void)
{
    structNode *head = NULL;
    insert(&head,5);
    insert(&head,20);
    insert(&head,4);
    insert(&head,3);
    insert(&head,30);
    insert(&head,10);
    head = mergeSort(head);
    printf("\n\nLinked List after sorting\n");
    print(head);
    return0;
}
