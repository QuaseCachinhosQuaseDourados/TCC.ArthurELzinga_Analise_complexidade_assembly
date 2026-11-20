/* Problema: Threaded Binary Tree
 * Complexidade de Tempo: None
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/threaded-binary-tree/
 */

// Utility function to find leftmost node in a tree rooted
// with n
structNode* leftMost(structNode* n)
{
    if(n == NULL)
        returnNULL;

    while(n->left != NULL)
        n = n->left;

    returnn;
}

// C code to do inorder traversal in a threaded binary tree
voidinOrder(structNode* root)
{
    structNode* cur = leftMost(root);
    while(cur != NULL) {
        printf("%d ", cur->data);

        // If this node is a thread node, then go to
        // inorder successor
        if(cur->rightThread)
            cur = cur->right;
        else// Else go to the leftmost child in right
             // subtree
            cur = leftmost(cur->right);
    }
}
