/* Problema: In-place conversion of Sorted DLL to Balanced BST
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/in-place-conversion-of-sorted-dll-to-balanced-bst/
 */

#include<stdio.h>
#include<stdlib.h>

/* A Doubly Linked List node that will also be used as a tree node */
structNode
{
    intdata;

    // For tree, next pointer can be used as right subtree pointer
    structNode* next;

    // For tree, prev pointer can be used as left subtree pointer
    structNode* prev;
};

// A utility function to count nodes in a Linked List
intcountNodes(structNode *head);

structNode* sortedListToBSTRecur(structNode **head_ref, intn);

/* This function counts the number of nodes in Linked List and then calls
   sortedListToBSTRecur() to construct BST */
structNode* sortedListToBST(structNode *head)
{
    /*Count the number of nodes in Linked List */
    intn = countNodes(head);

    /* Construct BST */
    returnsortedListToBSTRecur(&head, n);
}

/* The main function that constructs balanced BST and returns root of it.
       head_ref -->  Pointer to pointer to head node of Doubly linked list
       n  --> No. of nodes in the Doubly Linked List */
structNode* sortedListToBSTRecur(structNode **head_ref, intn)
{
    /* Base Case */
    if(n <= 0)
        returnNULL;

    /* Recursively construct the left subtree */
    structNode *left = sortedListToBSTRecur(head_ref, n/2);

    /* head_ref now refers to middle node, make middle node as root of BST*/
    structNode *root = *head_ref;

    // Set pointer to left subtree
    root->prev = left;

    /* Change head pointer of Linked List for parent recursive calls */
    *head_ref = (*head_ref)->next;

    /* Recursively construct the right subtree and link it with root
      The number of nodes in right subtree  is total nodes - nodes in
      left subtree - 1 (for root) */
    root->next = sortedListToBSTRecur(head_ref, n-n/2-1);

    returnroot;
}

/* UTILITY FUNCTIONS */
/* A utility function that returns count of nodes in a given Linked List */
intcountNodes(structNode *head)
{
    intcount = 0;
    structNode *temp = head;
    while(temp)
    {
        temp = temp->next;
        count++;
    }
    returncount;
}

/* Function to insert a node at the beginning of the Doubly Linked List */
voidpush(structNode** head_ref, intnew_data)
{
    /* allocate node */
    structNode* new_node =
            (structNode*) malloc(sizeof(structNode));

    /* put in the data  */
    new_node->data  = new_data;

    /* since we are adding at the beginning,
      prev is always NULL */
    new_node->prev = NULL;

    /* link the old list of the new node */
    new_node->next = (*head_ref);

    /* change prev of head node to new node */
    if((*head_ref) !=  NULL)
      (*head_ref)->prev = new_node ;

    /* move the head to point to the new node */
    (*head_ref)    = new_node;
}

/* Function to print nodes in a given linked list */
voidprintList(structNode *node)
{
    while(node!=NULL)
    {
        printf("%d ", node->data);
        node = node->next;
    }
}

/* A utility function to print preorder traversal of BST */
voidpreOrder(structNode* node)
{
    if(node == NULL)
        return;
    printf("%d ", node->data);
    preOrder(node->prev);
    preOrder(node->next);
}

/* Driver program to test above functions*/
intmain()
{
    /* Start with the empty list */
    structNode* head = NULL;

    /* Let us create a sorted linked list to test the functions
     Created linked list will be 7->6->5->4->3->2->1 */
    push(&head, 7);
    push(&head, 6);
    push(&head, 5);
    push(&head, 4);
    push(&head, 3);
    push(&head, 2);
    push(&head, 1);

    printf("Given Linked List\n");
    printList(head);

    /* Convert List to BST */
    structNode *root = sortedListToBST(head);
    printf("\n PreOrder Traversal of constructed BST \n ");
    preOrder(root);

    return0;
}
