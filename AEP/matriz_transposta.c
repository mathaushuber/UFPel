#include <stdio.h>

#define MAX_ROWS 3
#define MAX_COLS 3

int main() {
    int matriz[MAX_ROWS][MAX_COLS];
    int transposta[MAX_COLS][MAX_ROWS];
    int i, j;

    // Lendo a matriz do teclado
    printf("Digite os elementos da matriz %dx%d:\n", MAX_ROWS, MAX_COLS);

    for (i = 0; i < MAX_ROWS; i++) {
        for (j = 0; j < MAX_COLS; j++) {
            printf("Elemento [%d][%d]: ", i + 1, j + 1);
            scanf("%d", &matriz[i][j]);
        }
    }

    // Calculando a transposta
    for (i = 0; i < MAX_ROWS; i++) {
        for (j = 0; j < MAX_COLS; j++) {
            transposta[j][i] = matriz[i][j];
        }
    }

    // Imprimindo a matriz original
    printf("\nMatriz original:\n");
    for (i = 0; i < MAX_ROWS; i++) {
        for (j = 0; j < MAX_COLS; j++) {
            printf("%d\t", matriz[i][j]);
        }
        printf("\n");
    }

    // Imprimindo a transposta
    printf("\nMatriz transposta:\n");
    for (i = 0; i < MAX_COLS; i++) {
        for (j = 0; j < MAX_ROWS; j++) {
            printf("%d\t", transposta[i][j]);
        }
        printf("\n");
    }

    return 0;
}
