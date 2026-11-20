/* Problema: Sorted insert for circular linked list
 * Complexidade de Tempo: O(1)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/sorted-insert-for-circular-linked-list/
 */

// Case 2 of the above algo 
elseif(current->data >= new_node->data) 
{ 
  // swap the data part of head node and new node 
  // assuming that we have a function swap(int *, int *) 
  swap(&(current->data), &(new_node->data));  

  new_node->next = (*head_ref)->next; 
  (*head_ref)->next = new_node; 
} 
