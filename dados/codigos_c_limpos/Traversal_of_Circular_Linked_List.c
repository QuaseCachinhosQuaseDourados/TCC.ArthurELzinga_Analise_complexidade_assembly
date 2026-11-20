/* Problema: Traversal of Circular Linked List
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/traversal-of-circular-linked-list/
 */

/* Function to traverse a given Circular linked list and print nodes */
void printList(struct Node *first)
{
    struct Node *temp = first; 

    // If linked list is not empty
    if(first != NULL) 
    {
        // Keep printing nodes till we reach the first node again
        do
        {
            printf("%d ", temp->data);
            temp = temp->next;
        }
        while(temp != first);
    }
}
