/* Problema: QuickSort on Doubly Linked List
 * Complexidade de Tempo: O(N log N)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/quicksort-for-linked-list/
 */

// C program to sort a linked list using Quicksort
#include <stdio.h>
#include <stdlib.h>

/* a node of the doubly linked list */
structNode
{
    intdata;
    structNode *next;
    structNode *prev;
};

/* A utility function to swap two elements */
voidswap ( int* a, int* b )
{ intt = *a; *a = *b; *b = t; }

// A utility function to find last node of linked list
structNode *lastNode(structNode *root)
{
    while(root && root->next)
        root = root->next;
    returnroot;
}

/* Considers last element as pivot, places the 
pivot element at its correct position in sorted array, 
and places all smaller (smaller than pivot) to left
of pivot and all greater elements to right of pivot */
structNode* partition(structNode *l, structNode *h)
{
    // set pivot as h element
    intx = h->data;

    // similar to i = l-1 for array implementation
    structNode *i = l->prev;

    // Similar to "for (int j = l; j <= h- 1; j++)"
    for(structNode *j = l; j != h; j = j->next)
    {
        if(j->data <= x)
        {
            // Similar to i++ for array
            i = (i == NULL) ? l : i->next;

            swap(&(i->data), &(j->data));
        }
    }
    i = (i == NULL) ? l : i->next; // Similar to i++
    swap(&(i->data), &(h->data));
    returni;
}

/* A recursive implementation of quicksort for linked list */
void_quickSort(structNode* l, structNode *h)
{
    if(h != NULL && l != h && l != h->next)
    {
        structNode *p = partition(l, h);
        _quickSort(l, p->prev);
        _quickSort(p->next, h);
    }
}

// The main function to sort a linked list.
// It mainly calls _quickSort()
voidquickSort(structNode *head)
{
    // Find last node
    structNode *h = lastNode(head);

    // Call the recursive QuickSort
    _quickSort(head, h);
}

// A utility function to print contents of arr
voidprintList(structNode *head)
{
    while(head)
    {
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}

/* Function to insert a node at the 
beginning of the Doubly Linked List */
voidpush(structNode** head_ref, intnew_data)
{
    structNode* new_node = (structNode*) 
               malloc(sizeof(structNode)); /* allocate node */
    new_node->data = new_data;

    /* since we are adding at the beginning,
    prev is always NULL */
    new_node->prev = NULL;

    /* link the old list of the new node */
    new_node->next = (*head_ref);

    /* change prev of head node to new node */
    if((*head_ref) != NULL) (*head_ref)->prev = new_node ;

    /* move the head to point to the new node */
    (*head_ref) = new_node;
}

// Driver Code
intmain(intargc, char**argv)
{
    structNode *a = NULL;
    push(&a, 5);
    push(&a, 20);
    push(&a, 4);
    push(&a, 3);
    push(&a, 30);

    printf("Linked List before sorting \n");
    printList(a);

    quickSort(a);

    printf("Linked List after sorting \n");
    printList(a);

    return0;
}
