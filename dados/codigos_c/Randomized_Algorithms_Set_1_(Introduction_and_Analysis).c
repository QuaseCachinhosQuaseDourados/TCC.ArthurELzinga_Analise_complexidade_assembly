/* Problema: Randomized Algorithms | Set 1 (Introduction and Analysis)
 * Complexidade de Tempo: O(n Log n)
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/randomized-algorithms-set-1-introduction-and-analysis/
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

intfind_solution(intn) {
  // seed the random number generator with the current time
  srand(time(0));
  // randomly select a number between 1 and n and return it as the solution
  returnrand() % n + 1;
}

intmain() {
  intn = 10;  // the range of possible solutions is 1 to n
  printf("Solution: %d\n", find_solution(n));
  return0;
}
