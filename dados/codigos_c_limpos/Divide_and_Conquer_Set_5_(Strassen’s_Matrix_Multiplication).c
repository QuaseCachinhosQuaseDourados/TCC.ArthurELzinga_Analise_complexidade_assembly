/* Problema: Divide and Conquer | Set 5 (Strassen’s Matrix Multiplication)
 * Complexidade de Tempo: O(N3)
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/strassens-matrix-multiplication/
 */

void multiply(int A[][N], int B[][N], int C[][N])
{
    for(int i = 0; i < N; i++)
    {
        for(int j = 0; j < N; j++)
        {
            C[i][j] = 0;
            for(int k = 0; k < N; k++)
            {
                C[i][j] += A[i][k]*B[k][j];
            }
        }
    }
}
