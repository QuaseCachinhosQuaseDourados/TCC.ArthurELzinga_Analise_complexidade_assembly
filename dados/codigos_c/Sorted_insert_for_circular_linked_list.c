/* Problema: Sorted insert for circular linked list
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/sorted-insert-for-circular-linked-list/
 */

#include<stdio.h> 
#include<stdlib.h> 
 
/* structure for a node */
structNode 
{ 
  intdata; 
  structNode *next; 
}; 
 
/* function to insert a new_node in a list in sorted way. 
   Note that this function expects a pointer to head node 
   as this can modify the head of the input linked list */
voidsortedInsert(structNode** head_ref, structNode* new_node) 
{ 
  structNode* current = *head_ref; 
 
  // Case 1 of the above algo 
  if(current == NULL) 
  { 
     new_node->next = new_node; 
     *head_ref = new_node; 
  } 
 
  // Case 2 of the above algo 
  elseif(current->data >= new_node->data) 
  { 
    /* If value is smaller than head's value then 
      we need to change next of last node */
    while(current->next != *head_ref) 
        current = current->next; 
    current->next = new_node; 
    new_node->next = *head_ref; 
    *head_ref = new_node; 
  } 
 
  // Case 3 of the above algo 
  else
  { 
    /* Locate the node before the point of insertion */
    while(current->next!= *head_ref &&  
           current->next->data < new_node->data) 
      current = current->next; 
 
    new_node->next = current->next; 
    current->next = new_node; 
  } 
} 
 
/* Function to print nodes in a given linked list */
voidprintList(structNode *start) 
{ 
  structNode *temp; 
 
  if(start != NULL) 
  { 
    temp = start; 
    printf("\n"); 
    do{ 
      printf("%d ", temp->data); 
      temp = temp->next; 
    } while(temp != start); 
  } 
} 
 
/* Driver program to test above functions */
intmain() 
{ 
  intarr[] = {12, 56, 2, 11, 1, 90}; 
  intlist_size, i; 
 
  /* start with empty linked list */
  structNode *start = NULL; 
  structNode *temp; 
 
  /* Create linked list from the array arr[]. 
    Created linked list will be 1->2->11->12->56->90 */
  for(i = 0; i< 6; i++) 
  { 
    temp = (structNode *)malloc(sizeof(structNode)); 
    temp->data = arr[i]; 
    sortedInsert(&start, temp); 
  } 
 
  printList(start); 
 
  return0; 
} 
