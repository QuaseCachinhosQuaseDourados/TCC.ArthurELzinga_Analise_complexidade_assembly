/* Problema: Insertion in a Doubly Linked List
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/introduction-and-insertion-in-a-doubly-linked-list/
 */

// Given a node as prev_node, insert a new node 
// after the given node
voidinsertBefore(structNode* next_node, intnew_data)
{
    // Check if the given next_node is NULL
    if(next_node == NULL) {
        printf("the given next node cannot be NULL");
        return;
    }

    // 1. Allocate new node
    structNode* new_node
        = (structNode*)malloc(sizeof(structNode));

    // 2. Put in the data
    new_node->data = new_data;

    // 3. Make previous of new node as previous of next_node
    new_node->prev = next_node->prev;

    // 4. Make the previous of next_node as new_node
    next_node->prev = new_node;

    // 5. Make next_node as next of new_node
    new_node->next = next_node;

    // 6. Change next of new_node's previous node
    if(new_node->prev != NULL)
        new_node->prev->next = new_node;
    else
        head = new_node;
}
