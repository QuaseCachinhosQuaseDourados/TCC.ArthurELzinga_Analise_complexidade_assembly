/* Problema: Insertion in an AVL Tree
 * Complexidade de Tempo: O(log(n))
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/insertion-in-an-avl-tree/
 */

// C program to insert a node in AVL tree 
#include<stdio.h> 
#include<stdlib.h> 
 
// An AVL tree node 
structNode 
{ 
    intkey; 
    structNode *left; 
    structNode *right; 
    intheight; 
}; 
 
// A utility function to get the height of the tree 
intheight(structNode *N) 
{ 
    if(N == NULL) 
        return0; 
    returnN->height; 
} 
 
// A utility function to get maximum of two integers 
intmax(inta, intb) 
{ 
    return(a > b)? a : b; 
} 
 
/* Helper function that allocates a new node with the given key and 
    NULL left and right pointers. */
structNode* newNode(intkey) 
{ 
    structNode* node = (structNode*) 
                        malloc(sizeof(structNode)); 
    node->key   = key; 
    node->left   = NULL; 
    node->right  = NULL; 
    node->height = 1;  // new node is initially added at leaf 
    return(node); 
} 
 
// A utility function to right rotate subtree rooted with y 
// See the diagram given above. 
structNode *rightRotate(structNode *y) 
{ 
    structNode *x = y->left; 
    structNode *T2 = x->right; 
 
    // Perform rotation 
    x->right = y; 
    y->left = T2; 
 
    // Update heights 
    y->height = max(height(y->left), 
                    height(y->right)) + 1; 
    x->height = max(height(x->left), 
                    height(x->right)) + 1; 
 
    // Return new root 
    returnx; 
} 
 
// A utility function to left rotate subtree rooted with x 
// See the diagram given above. 
structNode *leftRotate(structNode *x) 
{ 
    structNode *y = x->right; 
    structNode *T2 = y->left; 
 
    // Perform rotation 
    y->left = x; 
    x->right = T2; 
 
    //  Update heights 
    x->height = max(height(x->left),    
                    height(x->right)) + 1; 
    y->height = max(height(y->left), 
                    height(y->right)) + 1; 
 
    // Return new root 
    returny; 
} 
 
// Get Balance factor of node N 
intgetBalance(structNode *N) 
{ 
    if(N == NULL) 
        return0; 
    returnheight(N->left) - height(N->right); 
} 
 
// Recursive function to insert a key in the subtree rooted 
// with node and returns the new root of the subtree. 
structNode* insert(structNode* node, intkey) 
{ 
    /* 1.  Perform the normal BST insertion */
    if(node == NULL) 
        return(newNode(key)); 
 
    if(key < node->key) 
        node->left  = insert(node->left, key); 
    elseif(key > node->key) 
        node->right = insert(node->right, key); 
    else// Equal keys are not allowed in BST 
        returnnode; 
 
    /* 2. Update height of this ancestor node */
    node->height = 1 + max(height(node->left), 
                        height(node->right)); 
 
    /* 3. Get the balance factor of this ancestor 
          node to check whether this node became 
          unbalanced */
    intbalance = getBalance(node); 
 
    // If this node becomes unbalanced, then 
    // there are 4 cases 
 
    // Left Left Case 
    if(balance > 1 && key < node->left->key) 
        returnrightRotate(node); 
 
    // Right Right Case 
    if(balance < -1 && key > node->right->key) 
        returnleftRotate(node); 
 
    // Left Right Case 
    if(balance > 1 && key > node->left->key) 
    { 
        node->left =  leftRotate(node->left); 
        returnrightRotate(node); 
    } 
 
    // Right Left Case 
    if(balance < -1 && key < node->right->key) 
    { 
        node->right = rightRotate(node->right); 
        returnleftRotate(node); 
    } 
 
    /* return the (unchanged) node pointer */
    returnnode; 
} 
 
// A utility function to print preorder traversal 
// of the tree. 
// The function also prints height of every node 
voidpreOrder(structNode *root) 
{ 
    if(root != NULL) 
    { 
        printf("%d ", root->key); 
        preOrder(root->left); 
        preOrder(root->right); 
    } 
} 
 
/* Driver program to test above function*/
intmain() 
{ 
  structNode *root = NULL; 
 
  /* Constructing tree given in the above figure */
  root = insert(root, 10); 
  root = insert(root, 20); 
  root = insert(root, 30); 
  root = insert(root, 40); 
  root = insert(root, 50); 
  root = insert(root, 25); 
 
  /* The constructed AVL Tree would be 
            30 
           /  \ 
         20   40 
        /  \     \ 
       10  25    50 
  */
 
  printf("Preorder traversal of the constructed AVL"
         " tree is \n"); 
  preOrder(root); 
 
  return0; 
} 
