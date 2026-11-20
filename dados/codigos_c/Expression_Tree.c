/* Problema: Expression Tree
 * Complexidade de Tempo: O(n)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/expression-tree/
 */

#include <stdio.h>
#include <stdlib.h>

/* A binary tree node has data, pointer to left child
   and a pointer to right child */
structnode {
    chardata;
    structnode* left;
    structnode* right;
    structnode* next;
};
 structnode *head=NULL;
/* Helper function that allocates a new node with the
   given data and NULL left and right pointers. */
structnode* newNode(chardata)
{
    structnode* node
        = (structnode*)malloc(sizeof(structnode));
    node->data = data;
    node->left = NULL;
    node->right = NULL;
    node->next = NULL;
    
    return(node); 
}
voidprintInorder(structnode* node)
{
    if(node == NULL)
        return;
    else{
    /* first recur on left child */
    printInorder(node->left);

    /* then print the data of node */
    printf("%c ", node->data);

    /* now recur on right child */
    printInorder(node->right);
    }
}

voidpush(structnode* x)
{
    if(head==NULL)
    head = x;
    else
    {
        (x)->next = head;
        head  = x;
    }
    // struct node* temp;
    // while(temp!=NULL)
    // {
    //     printf("%c ", temp->data);
    //     temp = temp->next;
    // }
}
structnode* pop()
{
    // Popping out the top most[ pointed with head] element
    structnode* p = head;
    head = head->next;
    returnp;
}
intmain()
{
    chars[] = {'A','B','C','*','+','D','/'};
    intl = sizeof(s) / sizeof(s[0]) ;
    structnode *x, *y, *z;
    for(inti = 0; i < l; i++) {
        // if read character is operator then popping two
        // other elements from stack and making a binary
        // tree
        if(s[i] == '+'|| s[i] == '-'|| s[i] == '*'
            || s[i] == '/'|| s[i] == '^') {
            z = newNode(s[i]);
            x = pop();
            y = pop();
            z->left = y;
            z->right = x;
            push(z);
        }
        else{
            z = newNode(s[i]);
            push(z);
        }
    }
    printf(" The Inorder Traversal of Expression Tree: ");
    printInorder(z);
    return0;
}
