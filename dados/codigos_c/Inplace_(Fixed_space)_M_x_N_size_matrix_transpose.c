/* Problema: Inplace (Fixed space) M x N size matrix transpose
 * Complexidade de Tempo: O(R*C)
 * Complexidade de Espaco: O(size of the bitset)
 * Fonte: https://www.geeksforgeeks.org/inplace-m-x-n-size-matrix-transpose/
 */

// Program for in-place matrix transpose 
#include <stdio.h> 
#include <iostream> 
#include <bitset> 
#define HASH_SIZE 128 
 
usingnamespacestd; 
 
// A utility function to print a 2D array of size nr x nc and base address A 
voidPrint2DArray(int*A, intnr, intnc) 
{ 
    for(intr = 0; r < nr; r++) 
    { 
        for(intc = 0; c < nc; c++) 
            printf("%4d", *(A + r*nc + c)); 
 
        printf("\n"); 
    } 
 
    printf("\n\n"); 
} 
 
// Non-square matrix transpose of matrix of size r x c and base address A 
voidMatrixInplaceTranspose(int*A, intr, intc) 
{ 
    intsize = r*c - 1; 
    intt; // holds element to be replaced, eventually becomes next element to move 
    intnext; // location of 't' to be moved 
    intcycleBegin; // holds start of cycle 
    inti; // iterator 
    bitset<HASH_SIZE> b; // hash to mark moved elements 
 
    b.reset(); 
    b[0] = b[size] = 1; 
    i = 1; // Note that A[0] and A[size-1] won't move 
    while(i < size) 
    { 
        cycleBegin = i; 
        t = A[i]; 
        do
        { 
            // Input matrix [r x c] 
            // Output matrix  
            // i_new = (i*r)%(N-1) 
            next = (i*r)%size; 
            swap(A[next], t); 
            b[i] = 1; 
            i = next; 
        } 
        while(i != cycleBegin); 
 
        // Get Next Move (what about querying random location?) 
        for(i = 1; i < size && b[i]; i++) 
            ; 
        cout << endl; 
    } 
} 
 
// Driver program to test above function 
intmain(void) 
{ 
    intr = 5, c = 6; 
    intsize = r*c; 
    int*A = newint[size]; 
 
    for(inti = 0; i < size; i++) 
        A[i] = i+1; 
 
    Print2DArray(A, r, c); 
    MatrixInplaceTranspose(A, r, c); 
    Print2DArray(A, c, r); 
 
    delete[] A; 
 
    return0; 
} 
