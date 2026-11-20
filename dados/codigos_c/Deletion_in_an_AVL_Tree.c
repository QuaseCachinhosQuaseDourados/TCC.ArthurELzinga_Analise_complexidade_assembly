/* Problema: Deletion in an AVL Tree
 * Complexidade de Tempo: O(Log n)
 * Complexidade de Espaco: O(1)
 * Fonte: https://www.geeksforgeeks.org/deletion-in-an-avl-tree/
 */

// C program to delete a node from AVL Tree
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

// A utility function to get maximum of two integers
intmax(inta, intb);

// A utility function to get height of the tree
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
    y->height = max(height(y->left), height(y->right))+1;
    x->height = max(height(x->left), height(x->right))+1;

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
    x->height = max(height(x->left), height(x->right))+1;
    y->height = max(height(y->left), height(y->right))+1;

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

structNode* insert(structNode* node, intkey)
{
    /* 1.  Perform the normal BST rotation */
    if(node == NULL)
        return(newNode(key));

    if(key < node->key)
        node->left  = insert(node->left, key);
    elseif(key > node->key)
        node->right = insert(node->right, key);
    else// Equal keys not allowed
        returnnode;

    /* 2. Update height of this ancestor node */
    node->height = 1 + max(height(node->left),
                           height(node->right));

    /* 3. Get the balance factor of this ancestor
          node to check whether this node became
          unbalanced */
    intbalance = getBalance(node);

    // If this node becomes unbalanced, then there are 4 cases

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

/* Given a non-empty binary search tree, return the
   node with minimum key value found in that tree.
   Note that the entire tree does not need to be
   searched. */
structNode * minValueNode(structNode* node)
{
    structNode* current = node;

    /* loop down to find the leftmost leaf */
    while(current->left != NULL)
        current = current->left;

    returncurrent;
}

// Recursive function to delete a node with given key
// from subtree with given root. It returns root of
// the modified subtree.
structNode* deleteNode(structNode* root, intkey)
{
    // STEP 1: PERFORM STANDARD BST DELETE

    if(root == NULL)
        returnroot;

    // If the key to be deleted is smaller than the
    // root's key, then it lies in left subtree
    if( key < root->key )
        root->left = deleteNode(root->left, key);

    // If the key to be deleted is greater than the
    // root's key, then it lies in right subtree
    elseif( key > root->key )
        root->right = deleteNode(root->right, key);

    // if key is same as root's key, then This is
    // the node to be deleted
    else
    {
        // node with only one child or no child
        if( (root->left == NULL) || (root->right == NULL) )
        {
            structNode *temp = root->left ? root->left :
                                             root->right;

            // No child case
            if(temp == NULL)
            {
                temp = root;
                root = NULL;
            }
            else// One child case
             *root = *temp; // Copy the contents of
                            // the non-empty child
            free(temp);
        }
        else
        {
            // node with two children: Get the inorder
            // successor (smallest in the right subtree)
            structNode* temp = minValueNode(root->right);

            // Copy the inorder successor's data to this node
            root->key = temp->key;

            // Delete the inorder successor
            root->right = deleteNode(root->right, temp->key);
        }
    }

    // If the tree had only one node then return
    if(root == NULL)
      returnroot;

    // STEP 2: UPDATE HEIGHT OF THE CURRENT NODE
    root->height = 1 + max(height(root->left),
                           height(root->right));

    // STEP 3: GET THE BALANCE FACTOR OF THIS NODE (to
    // check whether this node became unbalanced)
    intbalance = getBalance(root);

    // If this node becomes unbalanced, then there are 4 cases

    // Left Left Case
    if(balance > 1 && getBalance(root->left) >= 0)
        returnrightRotate(root);

    // Left Right Case
    if(balance > 1 && getBalance(root->left) < 0)
    {
        root->left =  leftRotate(root->left);
        returnrightRotate(root);
    }

    // Right Right Case
    if(balance < -1 && getBalance(root->right) <= 0)
        returnleftRotate(root);

    // Right Left Case
    if(balance < -1 && getBalance(root->right) > 0)
    {
        root->right = rightRotate(root->right);
        returnleftRotate(root);
    }

    returnroot;
}

// A utility function to print preorder traversal of
// the tree.
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
    root = insert(root, 9);
    root = insert(root, 5);
    root = insert(root, 10);
    root = insert(root, 0);
    root = insert(root, 6);
    root = insert(root, 11);
    root = insert(root, -1);
    root = insert(root, 1);
    root = insert(root, 2);

    /* The constructed AVL Tree would be
            9
           /  \
          1    10
        /  \     \
       0    5     11
      /    /  \
     -1   2    6
    */

    printf("Preorder traversal of the constructed AVL "
           "tree is \n");
    preOrder(root);

    root = deleteNode(root, 10);

    /* The AVL Tree after deletion of 10
            1
           /  \
          0    9
        /     /  \
       -1    5     11
           /  \
          2    6
    */

    printf("\nPreorder traversal after deletion of 10 \n");
    preOrder(root);

    return0;
}
