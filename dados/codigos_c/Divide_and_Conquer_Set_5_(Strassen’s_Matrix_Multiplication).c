/* Problema: Divide and Conquer | Set 5 (Strassen’s Matrix Multiplication)
 * Complexidade de Tempo: O(N3)
 * Complexidade de Espaco: None
 * Fonte: https://www.geeksforgeeks.org/strassens-matrix-multiplication/
 */

voidmultiply(intA[][N], intB[][N], intC[][N])
{
    for(inti = 0; i < N; i++)
    {
        for(intj = 0; j < N; j++)
        {
            C[i][j] = 0;
            for(intk = 0; k < N; k++)
            {
                C[i][j] += A[i][k]*B[k][j];
            }
        }
    }
}
