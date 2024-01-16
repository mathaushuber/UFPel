#include <stdio.h>
#include <stdlib.h>

#define MAX_ROWS 3
#define MAX_COLS 3

// Função para imprimir a matriz
void imprimirMatriz(int matriz[MAX_ROWS][MAX_COLS]) {
    printf("Matriz:\n");
    for (int i = 0; i < MAX_ROWS; i++) {
        for (int j = 0; j < MAX_COLS; j++) {
            printf("%d\t", matriz[i][j]);
        }
        printf("\n");
    }
}

// Função para substituir números negativos por seus módulos
void substituirNegativosPorModulo(int matriz[MAX_ROWS][MAX_COLS]) {
    for (int i = 0; i < MAX_ROWS; i++) {
        for (int j = 0; j < MAX_COLS; j++) {
            if (matriz[i][j] < 0) {
                matriz[i][j] = abs(matriz[i][j]);
            }
        }
    }
}

int main() {
    int matriz[MAX_ROWS][MAX_COLS];

    // Lendo a matriz do teclado
    printf("Digite os elementos da matriz %dx%d:\n", MAX_ROWS, MAX_COLS);

    for (int i = 0; i < MAX_ROWS; i++) {
        for (int j = 0; j < MAX_COLS; j++) {
            printf("Elemento [%d][%d]: ", i + 1, j + 1);
            scanf("%d", &matriz[i][j]);
        }
    }

    // Imprimindo a matriz original
    imprimirMatriz(matriz);

    // Substituindo números negativos por seus módulos
    substituirNegativosPorModulo(matriz);

    // Imprimindo a matriz após a substituição
    printf("\nMatriz após substituir números negativos por módulos:\n");
    imprimirMatriz(matriz);

    return 0;
}
