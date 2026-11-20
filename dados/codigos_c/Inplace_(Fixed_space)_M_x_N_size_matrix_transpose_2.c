/* Problema: Inplace (Fixed space) M x N size matrix transpose
 * Complexidade de Tempo: O(MN)
 * Complexidade de Espaco: O(MN)
 * Fonte: https://www.geeksforgeeks.org/inplace-m-x-n-size-matrix-transpose/
 */

#include <stdio.h> 
#include <iostream> 
#include <bitset> 
#define HASH_SIZE 128 
 
usingnamespacestd; 
 
typedefchardata_t; 
 
voidPrint2DArray(charA[], intnr, intnc) { 
   intsize = nr*nc; 
   for(inti = 0; i < size; i++) 
      printf("%4c", *(A + i)); 
 
   printf("\n"); 
} 
 
voidMatrixTransposeInplaceArrangement(data_t A[], intr, intc) { 
   intsize = r*c - 1; 
   data_t t; // holds element to be replaced, eventually becomes next element to move 
   intnext; // location of 't' to be moved 
   intcycleBegin; // holds start of cycle 
   inti; // iterator 
   bitset<HASH_SIZE> b; // hash to mark moved elements 
 
   b.reset(); 
   b[0] = b[size] = 1; 
   i = 1; // Note that A[0] and A[size-1] won't move 
   while( i < size ) { 
      cycleBegin = i; 
      t = A[i]; 
      do{ 
         // Input matrix [r x c] 
         // Output matrix  
         // i_new = (i*r)%size 
         next = (i*r)%size; 
         swap(A[next], t); 
         b[i] = 1; 
         i = next; 
      } while( i != cycleBegin ); 
 
      // Get Next Move (what about querying random location?) 
      for(i = 1; i < size && b[i]; i++) 
         ; 
      cout << endl; 
   } 
} 
 
voidFill(data_t buf[], intsize) { 
   // Fill abcd ... 
   for(inti = 0; i < size; i++) 
   buf[i] = 'a'+i; 
 
   // Fill 0123 ... 
   buf += size; 
   for(inti = 0; i < size; i++) 
      buf[i] = '0'+i; 
} 
 
voidTestCase_01(void) { 
   intr = 2, c = 10; 
   intsize = r*c; 
   data_t *A = newdata_t[size]; 
 
   Fill(A, c); 
 
   Print2DArray(A, r, c), cout << endl; 
   MatrixTransposeInplaceArrangement(A, r, c); 
   Print2DArray(A, c, r), cout << endl; 
 
   delete[] A; 
} 
 
intmain() { 
   TestCase_01(); 
 
   return0; 
} 
