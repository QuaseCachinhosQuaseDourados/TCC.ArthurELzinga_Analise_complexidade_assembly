/* Problema: Print nodes at k distance from root
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(height of the binary tree)
 * Fonte: https://www.geeksforgeeks.org/print-nodes-at-k-distance-from-root/
 */

#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode
{
   intdata;
   structnode* left;
   structnode* right;
};

voidprintKDistant(structnode *root , intk)    
{
   if(root == NULL|| k < 0 ) 
      return;
   if( k == 0 )
   {
      printf( "%d ", root->data );
      return;
   }
     
      printKDistant( root->left, k-1 ) ;
      printKDistant( root->right, k-1 ) ;
   
}

/* Helper function that allocates a new node with the
   given data and NULL left and right pointers. */
structnode* newNode(intdata)
{
  structnode* node = (structnode*)
                       malloc(sizeof(structnode));
  node->data = data;
  node->left = NULL;
  node->right = NULL;

  return(node);
}

/* Driver program to test above functions*/
intmain()
{

  /* Constructed binary tree is
            1
          /   \
        2      3
      /  \    /
    4     5  8 
  */
  structnode *root = newNode(1);
  root->left        = newNode(2);
  root->right       = newNode(3);
  root->left->left  = newNode(4);
  root->left->right = newNode(5);
  root->right->left = newNode(8);  

  printKDistant(root, 2);

  getchar();
  return0;
}
