/* Problema: Majority Element using Binary Search Tree
 * Complexidade de Tempo: O(n2), O(nlogn)
 * Complexidade de Espaco: O(n)
 * Fonte: https://www.geeksforgeeks.org/majority-element/
 */

#include <stdio.h>
#include <stdlib.h>

struct node {
    int key;
    int c;
    struct node* left;
    struct node* right;
};

struct node* newNode(int item) {
    struct node* temp = (struct node*)malloc(sizeof(struct node));
    temp->key = item;
    temp->c = 1;
    temp->left = NULL;
    temp->right = NULL;
    return temp;
}

struct node* insert(struct node* node, int key, int* ma) {
    if(node == NULL) {
        if(*ma == 0)
            *ma = 1;

        return newNode(key);
    }

    if(key < node->key)
        node->left = insert(node->left, key, ma);
    else if(key > node->key)
        node->right = insert(node->right, key, ma);
    else
        node->c++;

    *ma = (*ma > node->c) ? *ma : node->c;

    return node;
}

void inorder(struct node* root, int s) {
    if(root != NULL) {
        inorder(root->left, s);

        if(root->c > (s / 2))
            printf("%d \n", root->key);

        inorder(root->right, s);
    }
}

int main() {
    int a[] = { 1, 3, 3, 3, 2 };
    int size = sizeof(a) / sizeof(a[0]);

    struct node* root = NULL;
    int ma = 0;

    for(int i = 0; i < size; i++) {
        root = insert(root, a[i], &ma);
    }

    if(ma > (size / 2))
        inorder(root, size);
    else
        printf("No majority element\n");

    return 0;
}

// This code is contributed by Vaibhav Saroj.
