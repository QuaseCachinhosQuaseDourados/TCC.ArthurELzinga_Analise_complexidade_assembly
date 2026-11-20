/* Problema: Rat in a Maze
 * Complexidade de Tempo: O(4^(m*n))
 * Complexidade de Espaco: O(m*n)
 * Fonte: https://www.geeksforgeeks.org/rat-in-a-maze/
 */

#include <stdio.h>
#include <string.h>

#define MAX_N 100

void solve(int i, int j, int arr[MAX_N][MAX_N], int n, char ans[MAX_N * MAX_N], char move[MAX_N * MAX_N],
           int dir[4], int djr[4], int visited[MAX_N][MAX_N], int* ans_count) {
  //if we reach the last cell of the matrix. just add the current move to the list of answers (ans) and return from the function, effectively stopping any further exploration. 
  if(i == n - 1 && j == n - 1) {
        strcpy(ans + (*ans_count), move);
        (*ans_count) += strlen(move);
        ans[(*ans_count)++] = ' ';
        return;
    }
   //initialise a string direction using char array which represents all the directions.

    char direction[] = "DLRU";
    for(int ind = 0; ind < 4; ind++) {
      //calculate the next row index based on the current i (row) and the di array, which holds values for direction changes.
        int nexti = i + dir[ind];
      //calculate the next column index based on the current j (column) and the dj array, which holds values for direction changes.
        int nextj = j + djr[ind];
      // to check whether is is valid to move to the next cell
      // make sure to check if the next cell has been visited before.

        if(nexti >= 0 && nextj >= 0 && nexti < n && nextj < n && visited[nexti][nextj] == 0 && arr[nexti][nextj] == 1) {
          //Also Mark the current cell as visited to prevent revisiting it during the same path exploration.  
          visited[i][j] = 1;
          //assigns the char acter from direction[ind] to the position just after the last char acter in the move string
            move[strlen(move)] = direction[ind];
          // Recursively call the solve function with the updated position , the updated path move(adding the current direction), and the current direction), and the updated state information.
            solve(nexti, nextj, arr, n, ans, move, dir, djr, visited, ans_count);
           // Reset the current cell's visited status to 0 to allow backtracking(an essential step)  
          visited[i][j] = 0;
          // Backtrack by removing the last char acter
            move[strlen(move) - 1] = '\0';  
        }
    }
}

void findPath(int m[MAX_N][MAX_N], int n) {
   //we int ialise with char Array to get all the required values.
    char ans[MAX_N * MAX_N];
    int ans_count = 0;
    char move[MAX_N * MAX_N];
    int dir[] = {1, 0, 0, -1};
    int djr[] = {0, -1, 1, 0};
  //for visited cell
    int visited[MAX_N][MAX_N] = {0};
   //if top-left corner of the grid is equal to 1 to verify if there is a valid starting point in the grid.
    if(m[0][0] == 1) {
        solve(0, 0, m, n, ans, move, dir, djr, visited, &ans_count);
    }

    if(ans_count == 0) {
        printf("-1\n");
    } else{
      // Remove the trailing space
        ans[ans_count - 1] = '\0';  // Remove the trailing space
        printf("%s\n", ans);
    }
}

int main() {
    int n = 4;
    int m[MAX_N][MAX_N] = {{1, 0, 0, 0}, {1, 1, 0, 1}, {1, 1, 0, 0}, {0, 1, 1, 1}};

    findPath(m, n);

    return 0;
}
