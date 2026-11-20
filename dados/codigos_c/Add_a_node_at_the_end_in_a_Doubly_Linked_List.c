/* Problema: Add a node at the end in a Doubly Linked List:
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/introduction-and-insertion-in-a-doubly-linked-list/
 */

// Given a reference (pointer to pointer) to the head
// of a DLL and an int, appends a new node at the end
voidappend(structNode** head_ref, intnew_data)
{
    // 1. allocate node
    structNode* new_node
        = (structNode*)malloc(sizeof(structNode));

    structNode* last = *head_ref; /* used in step 5*/

    // 2. put in the data
    new_node->data = new_data;

    // 3. This new node is going to be the last node, so
    // make next of it as NULL
    new_node->next = NULL;

    // 4. If the Linked List is empty, then make the new
    // node as head
    if(*head_ref == NULL) {
        new_node->prev = NULL;
        *head_ref = new_node;
        return;
    }

    // 5. Else traverse till the last node
    while(last->next != NULL)
        last = last->next;

    // 6. Change the next of last node
    last->next = new_node;

    // 7. Make last node as previous of new node
    new_node->prev = last;

    return;
}
