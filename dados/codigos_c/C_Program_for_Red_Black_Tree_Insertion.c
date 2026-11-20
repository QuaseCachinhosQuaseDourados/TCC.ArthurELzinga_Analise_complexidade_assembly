/* Problema: C Program for Red Black Tree Insertion
 * Complexidade de Tempo: O(log n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/c-program-red-black-tree-insertion/
 */

/** C implementation for 
    Red-Black Tree Insertion
    This code is provided by 
    costheta_z **/
#include <stdio.h>
#include <stdlib.h>

// Structure to represent each 
// node in a red-black tree
structnode {
    intd; // data
    intc; // 1-red, 0-black
    structnode* p; // parent
    structnode* r; // right-child
    structnode* l; // left child
};

// global root for the entire tree
structnode* root = NULL;

// function to perform BST insertion of a node
structnode* bst(structnode* trav, 
                      structnode* temp)
{
    // If the tree is empty, 
    // return a new node
    if(trav == NULL)
        returntemp;

    // Otherwise recur down the tree
    if(temp->d < trav->d) 
    {
        trav->l = bst(trav->l, temp);
        trav->l->p = trav;
    }
    elseif(temp->d > trav->d) 
    {
        trav->r = bst(trav->r, temp);
        trav->r->p = trav;
    }

    // Return the (unchanged) node pointer
    returntrav;
}

// Function performing right rotation 
// of the passed node
voidrightrotate(structnode* temp)
{
    structnode* left = temp->l;
    temp->l = left->r;
    if(temp->l)
        temp->l->p = temp;
    left->p = temp->p;
    if(!temp->p)
        root = left;
    elseif(temp == temp->p->l)
        temp->p->l = left;
    else
        temp->p->r = left;
    left->r = temp;
    temp->p = left;
}

// Function performing left rotation 
// of the passed node
voidleftrotate(structnode* temp)
{
    structnode* right = temp->r;
    temp->r = right->l;
    if(temp->r)
        temp->r->p = temp;
    right->p = temp->p;
    if(!temp->p)
        root = right;
    elseif(temp == temp->p->l)
        temp->p->l = right;
    else
        temp->p->r = right;
    right->l = temp;
    temp->p = right;
}

// This function fixes violations 
// caused by BST insertion
voidfixup(structnode* root, structnode* pt)
{
    structnode* parent_pt = NULL;
    structnode* grand_parent_pt = NULL;

    while((pt != root) && (pt->c != 0)
           && (pt->p->c == 1)) 
    {
        parent_pt = pt->p;
        grand_parent_pt = pt->p->p;

        /*  Case : A
             Parent of pt is left child 
             of Grand-parent of
           pt */
        if(parent_pt == grand_parent_pt->l) 
        {

            structnode* uncle_pt = grand_parent_pt->r;

            /* Case : 1
                The uncle of pt is also red
                Only Recoloring required */
            if(uncle_pt != NULL && uncle_pt->c == 1) 
            {
                grand_parent_pt->c = 1;
                parent_pt->c = 0;
                uncle_pt->c = 0;
                pt = grand_parent_pt;
            }

            else{

                /* Case : 2
                     pt is right child of its parent
                     Left-rotation required */
                if(pt == parent_pt->r) {
                    leftrotate(parent_pt);
                    pt = parent_pt;
                    parent_pt = pt->p;
                }

                /* Case : 3
                     pt is left child of its parent
                     Right-rotation required */
                rightrotate(grand_parent_pt);
                intt = parent_pt->c;
                parent_pt->c = grand_parent_pt->c;
                grand_parent_pt->c = t;
                pt = parent_pt;
            }
        }

        /* Case : B
             Parent of pt is right 
             child of Grand-parent of
           pt */
        else{
            structnode* uncle_pt = grand_parent_pt->l;

            /*  Case : 1
                The uncle of pt is also red
                Only Recoloring required */
            if((uncle_pt != NULL) && (uncle_pt->c == 1)) 
            {
                grand_parent_pt->c = 1;
                parent_pt->c = 0;
                uncle_pt->c = 0;
                pt = grand_parent_pt;
            }
            else{
                /* Case : 2
                   pt is left child of its parent
                   Right-rotation required */
                if(pt == parent_pt->l) {
                    rightrotate(parent_pt);
                    pt = parent_pt;
                    parent_pt = pt->p;
                }

                /* Case : 3
                     pt is right child of its parent
                     Left-rotation required */
                leftrotate(grand_parent_pt);
                intt = parent_pt->c;
                parent_pt->c = grand_parent_pt->c;
                grand_parent_pt->c = t;
                pt = parent_pt;
            }
        }
    }
}

// Function to print inorder traversal 
// of the fixated tree
voidinorder(structnode* trav)
{
    if(trav == NULL)
        return;
    inorder(trav->l);
    printf("%d ", trav->d);
    inorder(trav->r);
}

// driver code
intmain()
{
    intn = 7;
    inta[7] = { 7, 6, 5, 4, 3, 2, 1 };

    for(inti = 0; i < n; i++) {

        // allocating memory to the node and initializing:
        // 1. color as red
        // 2. parent, left and right pointers as NULL
        // 3. data as i-th value in the array
        structnode* temp
            = (structnode*)malloc(sizeof(structnode));
        temp->r = NULL;
        temp->l = NULL;
        temp->p = NULL;
        temp->d = a[i];
        temp->c = 1;

        // calling function that performs bst insertion of
        // this newly created node
        root = bst(root, temp);

        // calling function to preserve properties of rb
        // tree
        fixup(root, temp);
          root->c = 0;
    }

    printf("Inorder Traversal of Created Tree\n");
    inorder(root);

    return0;
}
