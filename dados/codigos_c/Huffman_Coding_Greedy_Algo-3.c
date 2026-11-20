/* Problema: Huffman Coding | Greedy Algo-3
 * Complexidade de Tempo: O(nlogn)
 * Complexidade de Espaco: O(N)
 * Fonte: https://www.geeksforgeeks.org/huffman-coding-greedy-algo-3/
 */

// C program for Huffman Coding 
#include <stdio.h> 
#include <stdlib.h> 
 
// This constant can be avoided by explicitly 
// calculating height of Huffman Tree 
#define MAX_TREE_HT 100 
 
// A Huffman tree node 
structMinHeapNode { 
 
    // One of the input characters 
    chardata; 
 
    // Frequency of the character 
    unsigned freq; 
 
    // Left and right child of this node 
    structMinHeapNode *left, *right; 
}; 
 
// A Min Heap:  Collection of 
// min-heap (or Huffman tree) nodes 
structMinHeap { 
 
    // Current size of min heap 
    unsigned size; 
 
    // capacity of min heap 
    unsigned capacity; 
 
    // Array of minheap node pointers 
    structMinHeapNode** array; 
}; 
 
// A utility function allocate a new 
// min heap node with given character 
// and frequency of the character 
structMinHeapNode* newNode(chardata, unsigned freq) 
{ 
    structMinHeapNode* temp = (structMinHeapNode*)malloc( 
        sizeof(structMinHeapNode)); 
 
    temp->left = temp->right = NULL; 
    temp->data = data; 
    temp->freq = freq; 
 
    returntemp; 
} 
 
// A utility function to create 
// a min heap of given capacity 
structMinHeap* createMinHeap(unsigned capacity) 
 
{ 
 
    structMinHeap* minHeap 
        = (structMinHeap*)malloc(sizeof(structMinHeap)); 
 
    // current size is 0 
    minHeap->size = 0; 
 
    minHeap->capacity = capacity; 
 
    minHeap->array = (structMinHeapNode**)malloc( 
        minHeap->capacity * sizeof(structMinHeapNode*)); 
    returnminHeap; 
} 
 
// A utility function to 
// swap two min heap nodes 
voidswapMinHeapNode(structMinHeapNode** a, 
                     structMinHeapNode** b) 
 
{ 
 
    structMinHeapNode* t = *a; 
    *a = *b; 
    *b = t; 
} 
 
// The standard minHeapify function. 
voidminHeapify(structMinHeap* minHeap, intidx) 
 
{ 
 
    intsmallest = idx; 
    intleft = 2 * idx + 1; 
    intright = 2 * idx + 2; 
 
    if(left < minHeap->size 
        && minHeap->array[left]->freq 
               < minHeap->array[smallest]->freq) 
        smallest = left; 
 
    if(right < minHeap->size 
        && minHeap->array[right]->freq 
               < minHeap->array[smallest]->freq) 
        smallest = right; 
 
    if(smallest != idx) { 
        swapMinHeapNode(&minHeap->array[smallest], 
                        &minHeap->array[idx]); 
        minHeapify(minHeap, smallest); 
    } 
} 
 
// A utility function to check 
// if size of heap is 1 or not 
intisSizeOne(structMinHeap* minHeap) 
{ 
 
    return(minHeap->size == 1); 
} 
 
// A standard function to extract 
// minimum value node from heap 
structMinHeapNode* extractMin(structMinHeap* minHeap) 
 
{ 
 
    structMinHeapNode* temp = minHeap->array[0]; 
    minHeap->array[0] = minHeap->array[minHeap->size - 1]; 
 
    --minHeap->size; 
    minHeapify(minHeap, 0); 
 
    returntemp; 
} 
 
// A utility function to insert 
// a new node to Min Heap 
voidinsertMinHeap(structMinHeap* minHeap, 
                   structMinHeapNode* minHeapNode) 
 
{ 
 
    ++minHeap->size; 
    inti = minHeap->size - 1; 
 
    while(i 
           && minHeapNode->freq 
                  < minHeap->array[(i - 1) / 2]->freq) { 
 
        minHeap->array[i] = minHeap->array[(i - 1) / 2]; 
        i = (i - 1) / 2; 
    } 
 
    minHeap->array[i] = minHeapNode; 
} 
 
// A standard function to build min heap 
voidbuildMinHeap(structMinHeap* minHeap) 
 
{ 
 
    intn = minHeap->size - 1; 
    inti; 
 
    for(i = (n - 1) / 2; i >= 0; --i) 
        minHeapify(minHeap, i); 
} 
 
// A utility function to print an array of size n 
voidprintArr(intarr[], intn) 
{ 
    inti; 
    for(i = 0; i < n; ++i) 
        printf("%d", arr[i]); 
 
    printf("\n"); 
} 
 
// Utility function to check if this node is leaf 
intisLeaf(structMinHeapNode* root) 
 
{ 
 
    return!(root->left) && !(root->right); 
} 
 
// Creates a min heap of capacity 
// equal to size and inserts all character of 
// data[] in min heap. Initially size of 
// min heap is equal to capacity 
structMinHeap* createAndBuildMinHeap(chardata[], 
                                      intfreq[], intsize) 
 
{ 
 
    structMinHeap* minHeap = createMinHeap(size); 
 
    for(inti = 0; i < size; ++i) 
        minHeap->array[i] = newNode(data[i], freq[i]); 
 
    minHeap->size = size; 
    buildMinHeap(minHeap); 
 
    returnminHeap; 
} 
 
// The main function that builds Huffman tree 
structMinHeapNode* buildHuffmanTree(chardata[], 
                                     intfreq[], intsize) 
 
{ 
    structMinHeapNode *left, *right, *top; 
 
    // Step 1: Create a min heap of capacity 
    // equal to size.  Initially, there are 
    // modes equal to size. 
    structMinHeap* minHeap 
        = createAndBuildMinHeap(data, freq, size); 
 
    // Iterate while size of heap doesn't become 1 
    while(!isSizeOne(minHeap)) { 
 
        // Step 2: Extract the two minimum 
        // freq items from min heap 
        left = extractMin(minHeap); 
        right = extractMin(minHeap); 
 
        // Step 3:  Create a new internal 
        // node with frequency equal to the 
        // sum of the two nodes frequencies. 
        // Make the two extracted node as 
        // left and right children of this new node. 
        // Add this node to the min heap 
        // '$' is a special value for internal nodes, not 
        // used 
        top = newNode('$', left->freq + right->freq); 
 
        top->left = left; 
        top->right = right; 
 
        insertMinHeap(minHeap, top); 
    } 
 
    // Step 4: The remaining node is the 
    // root node and the tree is complete. 
    returnextractMin(minHeap); 
} 
 
// Prints huffman codes from the root of Huffman Tree. 
// It uses arr[] to store codes 
voidprintCodes(structMinHeapNode* root, intarr[], 
                inttop) 
 
{ 
 
    // Assign 0 to left edge and recur 
    if(root->left) { 
 
        arr[top] = 0; 
        printCodes(root->left, arr, top + 1); 
    } 
 
    // Assign 1 to right edge and recur 
    if(root->right) { 
 
        arr[top] = 1; 
        printCodes(root->right, arr, top + 1); 
    } 
 
    // If this is a leaf node, then 
    // it contains one of the input 
    // characters, print the character 
    // and its code from arr[] 
    if(isLeaf(root)) { 
 
        printf("%c: ", root->data); 
        printArr(arr, top); 
    } 
} 
 
// The main function that builds a 
// Huffman Tree and print codes by traversing 
// the built Huffman Tree 
voidHuffmanCodes(chardata[], intfreq[], intsize) 
 
{ 
    // Construct Huffman Tree 
    structMinHeapNode* root 
        = buildHuffmanTree(data, freq, size); 
 
    // Print Huffman codes using 
    // the Huffman tree built above 
    intarr[MAX_TREE_HT], top = 0; 
 
    printCodes(root, arr, top); 
} 
 
// Driver code 
intmain() 
{ 
 
    chararr[] = { 'a', 'b', 'c', 'd', 'e', 'f'}; 
    intfreq[] = { 5, 9, 12, 13, 16, 45 }; 
 
    intsize = sizeof(arr) / sizeof(arr[0]); 
 
    HuffmanCodes(arr, freq, size); 
 
    return0; 
}
