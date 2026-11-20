/* Problema: Sort elements by frequency using BST:
 * Complexidade de Tempo: O(N log N)
 * Complexidade de Espaco: O(N log N)
 * Fonte: https://www.geeksforgeeks.org/sort-elements-by-frequency/
 */

struct tree {
    int element;
    int first_index /*To handle ties in counts*/
        int count;
} BST;
