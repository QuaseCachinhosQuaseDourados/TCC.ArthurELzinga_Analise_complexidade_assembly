/* Problema: Introduction of B-Tree
 * Complexidade de Tempo: O(log n)
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/int roduction-of-b-tree-2/
 */

BtreeSearch(x, k)
    i = 1
    
    // n[x] means number of keys in x node
    while i ≤ n[x] and k ≥ keyi[x]
        do i = i + 1
    if i  n[x] and k = keyi[x]
        then return(x, i)   
    if leaf [x]
        then return NIL
    else
        return BtreeSearch(ci[x], k)
