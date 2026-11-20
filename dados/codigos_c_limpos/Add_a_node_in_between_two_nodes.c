/* Problema: Add a node in between two nodes:
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/int roduction-and-insertion-in-a-do ubly-linked-list/
 */

// Given a node as prev_node, insert a new node 
// after the given node
void insertAfter(struct Node* prev_node, int new_data)
{
    // Check if the given prev_node is NULL
    if(prev_node == NULL) {
        printf("the given previous node cannot be NULL");
        return;
    }

    // 1. allocate new node
    struct Node* new_node
        = (struct Node*)malloc(sizeof(struct Node));

    // 2. put in the data
    new_node->data = new_data;

    // 3. Make next of new node as next of prev_node
    new_node->next = prev_node->next;

    // 4. Make the next of prev_node as new_node
    prev_node->next = new_node;

    // 5. Make prev_node as previous of new_node
    new_node->prev = prev_node;

    // 6. Change previous of new_node's next node
    if(new_node->next != NULL)
        new_node->next->prev = new_node;
}
