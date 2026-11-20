/* Problema: Majority Element using Binary Search Tree
 * Complexidade de Tempo: O(n2), O(nlogn)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

#include <stdio.h>
#include <stdlib.h>

structnode {
    intkey;
    intc;
    structnode* left;
    structnode* right;
};

structnode* newNode(intitem) {
    structnode* temp = (structnode*)malloc(sizeof(structnode));
    temp->key = item;
    temp->c = 1;
    temp->left = NULL;
    temp->right = NULL;
    returntemp;
}

structnode* insert(structnode* node, intkey, int* ma) {
    if(node == NULL) {
        if(*ma == 0)
            *ma = 1;

        returnnewNode(key);
    }

    if(key < node->key)
        node->left = insert(node->left, key, ma);
    elseif(key > node->key)
        node->right = insert(node->right, key, ma);
    else
        node->c++;

    *ma = (*ma > node->c) ? *ma : node->c;

    returnnode;
}

voidinorder(structnode* root, ints) {
    if(root != NULL) {
        inorder(root->left, s);

        if(root->c > (s / 2))
            printf("%d \n", root->key);

        inorder(root->right, s);
    }
}

intmain() {
    inta[] = { 1, 3, 3, 3, 2 };
    intsize = sizeof(a) / sizeof(a[0]);

    structnode* root = NULL;
    intma = 0;

    for(inti = 0; i < size; i++) {
        root = insert(root, a[i], &ma);
    }

    if(ma > (size / 2))
        inorder(root, size);
    else
        printf("No majority element\n");

    return0;
}

// This code is contributed by Vaibhav Saroj.
