/* Problema: Insertion in a Doubly Linked List
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/introduction-and-insertion-in-a-doubly-linked-list/
 */

// Given a reference (pointer to pointer) to the head
// of a list and an int, inserts a new node
// on the front of the list.
voidpush(structNode** head_ref, intnew_data)
{
    // 1. allocate node
    structNode* new_node
        = (structNode*)malloc(sizeof(structNode));

    // 2. put in the data
    new_node->data = new_data;

    // 3. Make next of new node as head and previous as NULL
    new_node->next = (*head_ref);
    new_node->prev = NULL;

    // 4. change prev of head node to new node
    if((*head_ref) != NULL)
        (*head_ref)->prev = new_node;

    // 5. move the head to point to the new node
    (*head_ref) = new_node;
}
