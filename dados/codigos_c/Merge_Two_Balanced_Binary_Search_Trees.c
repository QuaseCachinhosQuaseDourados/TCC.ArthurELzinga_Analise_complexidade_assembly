/* Problema: Merge Two Balanced Binary Search Trees
 * Complexidade de Tempo: O(m+n)
 * Complexidade de Espaco: O(m+n)
 * Fonte: https://www.geeksforgeeks.org/merge-two-balanced-binary-search-trees/
 */

// C program to Merge Two Balanced Binary Search Trees
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

// A utility function to merge two sorted arrays into one
int*merge(intarr1[], intarr2[], intm, intn);

// A helper function that stores inorder traversal of a tree in inorder array
voidstoreInorder(structnode* node, intinorder[], int*index_ptr);

/* A function that constructs Balanced Binary Search Tree from a sorted array
   See https://www.geeksforgeeks.org/sorted-array-to-balanced-bst/ */
structnode* sortedArrayToBST(intarr[], intstart, intend);

/* This function merges two balanced BSTs with roots as root1 and root2.
   m and n are the sizes of the trees respectively */
structnode* mergeTrees(structnode *root1, structnode *root2, intm, intn)
{
    // Store inorder traversal of first tree in an array arr1[]
    int*arr1 = newint[m];
    inti = 0;
    storeInorder(root1, arr1, &i);

    // Store inorder traversal of second tree in another array arr2[]
    int*arr2 = newint[n];
    intj = 0;
    storeInorder(root2, arr2, &j);

    // Merge the two sorted array into one
    int*mergedArr = merge(arr1, arr2, m, n);

    // Construct a tree from the merged array and return root of the tree
    returnsortedArrayToBST (mergedArr, 0, m+n-1);
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

// A utility function to print inorder traversal of a given binary tree
voidprintInorder(structnode* node)
{
    if(node == NULL)
        return;

    /* first recur on left child */
    printInorder(node->left);

    printf("%d ", node->data);

    /* now recur on right child */
    printInorder(node->right);
}

// A utility function to merge two sorted arrays into one
int*merge(intarr1[], intarr2[], intm, intn)
{
    // mergedArr[] is going to contain result
    int*mergedArr = newint[m + n];
    inti = 0, j = 0, k = 0;

    // Traverse through both arrays
    while(i < m && j < n)
    {
        // Pick the smaller element and put it in mergedArr
        if(arr1[i] < arr2[j])
        {
            mergedArr[k] = arr1[i];
            i++;
        }
        else
        {
            mergedArr[k] = arr2[j];
            j++;
        }
        k++;
    }

    // If there are more elements in first array
    while(i < m)
    {
        mergedArr[k] = arr1[i];
        i++; k++;
    }

    // If there are more elements in second array
    while(j < n)
    {
        mergedArr[k] = arr2[j];
        j++; k++;
    }

    returnmergedArr;
}

// A helper function that stores inorder traversal of a tree rooted with node
voidstoreInorder(structnode* node, intinorder[], int*index_ptr)
{
    if(node == NULL)
        return;

    /* first recur on left child */
    storeInorder(node->left, inorder, index_ptr);

    inorder[*index_ptr] = node->data;
    (*index_ptr)++;  // increase index for next entry

    /* now recur on right child */
    storeInorder(node->right, inorder, index_ptr);
}

/* A function that constructs Balanced Binary Search Tree from a sorted array
   See https://www.geeksforgeeks.org/sorted-array-to-balanced-bst/ */
structnode* sortedArrayToBST(intarr[], intstart, intend)
{
    /* Base Case */
    if(start > end)
      returnNULL;

    /* Get the middle element and make it root */
    intmid = (start + end)/2;
    structnode *root = newNode(arr[mid]);

    /* Recursively construct the left subtree and make it
       left child of root */
    root->left =  sortedArrayToBST(arr, start, mid-1);

    /* Recursively construct the right subtree and make it
       right child of root */
    root->right = sortedArrayToBST(arr, mid+1, end);

    returnroot;
}

/* Driver program to test above functions*/
intmain()
{
    /* Create following tree as first balanced BST
           100
          /  \
        50    300
       / \
      20  70
    */
    structnode *root1  = newNode(100);
    root1->left         = newNode(50);
    root1->right        = newNode(300);
    root1->left->left   = newNode(20);
    root1->left->right  = newNode(70);

    /* Create following tree as second balanced BST
            80
           /  \
         40   120
    */
    structnode *root2  = newNode(80);
    root2->left         = newNode(40);
    root2->right        = newNode(120);

    structnode *mergedTree = mergeTrees(root1, root2, 5, 3);

    printf("Following is Inorder traversal of the merged tree \n");
    printInorder(mergedTree);

    getchar();
    return0;
}
