/* Problema: Ternary Search Tree
 * Complexidade de Tempo: O(height)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/ternary-search-tree/
 */

// C program to demonstrate Ternary Search Tree (TST) 
// insert, traverse and search operations 
#include <stdio.h> 
#include <stdlib.h> 
#define MAX 50 
 
// A node of ternary search tree 
structNode { 
    chardata; 
 
    // True if this character is last character of one of 
    // the words 
    unsigned isEndOfString : 1; 
 
    structNode *left, *eq, *right; 
}; 
 
// A utility function to create a new ternary search tree 
// node 
structNode* newNode(chardata) 
{ 
    structNode* temp 
        = (structNode*)malloc(sizeof(structNode)); 
    temp->data = data; 
    temp->isEndOfString = 0; 
    temp->left = temp->eq = temp->right = NULL; 
    returntemp; 
} 
 
// Function to insert a new word in a Ternary Search Tree 
voidinsert(structNode** root, char* word) 
{ 
    // Base Case: Tree is empty 
    if(!(*root)) 
        *root = newNode(*word); 
 
    // If current character of word is smaller than root's 
    // character, then insert this word in left subtree of 
    // root 
    if((*word) < (*root)->data) 
        insert(&((*root)->left), word); 
 
    // If current character of word is greater than root's 
    // character, then insert this word in right subtree of 
    // root 
    elseif((*word) > (*root)->data) 
        insert(&((*root)->right), word); 
 
    // If current character of word is same as root's 
    // character, 
    else{ 
        if(*(word + 1)) 
            insert(&((*root)->eq), word + 1); 
 
        // the last character of the word 
        else
            (*root)->isEndOfString = 1; 
    } 
} 
 
// A recursive function to traverse Ternary Search Tree 
voidtraverseTSTUtil(structNode* root, char* buffer, 
                     intdepth) 
{ 
    if(root) { 
        // First traverse the left subtree 
        traverseTSTUtil(root->left, buffer, depth); 
 
        // Store the character of this node 
        buffer[depth] = root->data; 
        if(root->isEndOfString) { 
            buffer[depth + 1] = '\0'; 
            printf("%s\n", buffer); 
        } 
 
        // Traverse the subtree using equal pointer (middle 
        // subtree) 
        traverseTSTUtil(root->eq, buffer, depth + 1); 
 
        // Finally Traverse the right subtree 
        traverseTSTUtil(root->right, buffer, depth); 
    } 
} 
 
// The main function to traverse a Ternary Search Tree. 
// It mainly uses traverseTSTUtil() 
voidtraverseTST(structNode* root) 
{ 
    charbuffer[MAX]; 
    traverseTSTUtil(root, buffer, 0); 
} 
 
// Function to search a given word in TST 
intsearchTST(structNode* root, char* word) 
{ 
    if(!root) 
        return0; 
 
    if(*word < (root)->data) 
        returnsearchTST(root->left, word); 
 
    elseif(*word > (root)->data) 
        returnsearchTST(root->right, word); 
 
    else{ 
        if(*(word + 1) == '\0') 
            returnroot->isEndOfString; 
 
        returnsearchTST(root->eq, word + 1); 
    } 
} 
 
// Driver program to test above functions 
intmain() 
{ 
    structNode* root = NULL; 
 
    insert(&root, "cat"); 
    insert(&root, "cats"); 
    insert(&root, "up"); 
    insert(&root, "bug"); 
 
    printf( 
        "Following is traversal of ternary search tree\n"); 
    traverseTST(root); 
 
    printf("\nFollowing are search results for cats, bu "
           "and cat respectively\n"); 
    searchTST(root, "cats") ? printf("Found\n") 
                            : printf("Not Found\n"); 
    searchTST(root, "bu") ? printf("Found\n") 
                          : printf("Not Found\n"); 
    searchTST(root, "cat") ? printf("Found\n") 
                           : printf("Not Found\n"); 
 
    return0; 
}
