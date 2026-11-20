/* Problema: Introduction of B-Tree
 * Complexidade de Tempo: O(log n)
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/introduction-of-b-tree-2/
 */

BtreeSearch(x, k)
    i = 1
    
    // n[x] means number of keys in x node
    whilei ≤ n[x] and k ≥ keyi[x]
        doi = i + 1
    ifi  n[x] and k = keyi[x]
        then return(x, i)   
    ifleaf [x]
        then returnNIL
    else
        returnBtreeSearch(ci[x], k)
