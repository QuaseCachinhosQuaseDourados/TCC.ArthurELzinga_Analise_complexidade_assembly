/* Problema: Split a Circular Linked List into two halves
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/split-a-circular-linked-list-into-two-halves/
 */

/* Program to split a circular linked list into two halves */
#include<stdio.h> 
#include<stdlib.h> 

/* structure for a node */
structNode
{
  intdata;
  structNode *next;
}; 

/* Function to split a list (starting with head) into two lists.
   head1_ref and head2_ref are references to head nodes of 
    the two resultant linked lists */
voidsplitList(structNode *head, structNode **head1_ref, 
                                            structNode **head2_ref)
{
  structNode *slow_ptr = head;
  structNode *fast_ptr = head; 

  if(head == NULL)
    return;
 
  /* If there are odd nodes in the circular list then
     fast_ptr->next becomes head and for even nodes 
     fast_ptr->next->next becomes head */
  while(fast_ptr->next != head &&
         fast_ptr->next->next != head) 
  {
     fast_ptr = fast_ptr->next->next;
     slow_ptr = slow_ptr->next;
  }  

 /* If there are even elements in list then move fast_ptr */
  if(fast_ptr->next->next == head)
    fast_ptr = fast_ptr->next;      
  
  /* Set the head pointer of first half */
  *head1_ref = head;    
     
  /* Set the head pointer of second half */
  if(head->next != head)
    *head2_ref = slow_ptr->next;
  
  /* Make second half circular */
  fast_ptr->next = slow_ptr->next;
  
  /* Make first half circular */
  slow_ptr->next = head;       
}

/* UTILITY FUNCTIONS */
/* Function to insert a node at the beginning of a Circular 
   linked list */
voidpush(structNode **head_ref, intdata)
{
  structNode *ptr1 = (structNode *)malloc(sizeof(structNode));
  structNode *temp = *head_ref; 
  ptr1->data = data;  
  ptr1->next = *head_ref; 
  
  /* If linked list is not NULL then set the next of 
    last node */
  if(*head_ref != NULL)
  {
    while(temp->next != *head_ref)
      temp = temp->next;        
    temp->next = ptr1; 
  }
  else
     ptr1->next = ptr1; /*For the first node */

  *head_ref = ptr1;     
} 

/* Function to print nodes in a given Circular linked list */
voidprintList(structNode *head)
{
  structNode *temp = head; 
  if(head != NULL)
  {
    printf("\n");
    do{
      printf("%d ", temp->data);
      temp = temp->next;
    } while(temp != head);
  }
}

/* Driver program to test above functions */
intmain()
{
  intlist_size, i; 
  
  /* Initialize lists as empty */
  structNode *head = NULL;
  structNode *head1 = NULL;
  structNode *head2 = NULL;  

  /* Created linked list will be 12->56->2->11 */
  push(&head, 12); 
  push(&head, 56);   
  push(&head, 2);   
  push(&head, 11);   

  printf("Original Circular Linked List");
  printList(head);      
 
  /* Split the list */
  splitList(head, &head1, &head2);
 
  printf("\nFirst Circular Linked List");
  printList(head1);  

  printf("\nSecond Circular Linked List");
  printList(head2);  
  
  getchar();
  return0;
} 
