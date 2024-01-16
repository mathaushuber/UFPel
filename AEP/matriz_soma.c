#include <stdio.h>

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

// Função para somar os elementos das linhas L1 e L2, colocando o resultado na linha L2
void somarLinhas(int matriz[MAX_ROWS][MAX_COLS], int L1, int L2) {
    for (int j = 0; j < MAX_COLS; j++) {
        matriz[L2][j] += matriz[L1][j];
    }
}

// Função para multiplicar os elementos das linhas L1 e L2, colocando o resultado na linha L2
void multiplicarLinhas(int matriz[MAX_ROWS][MAX_COLS], int L1, int L2) {
    for (int j = 0; j < MAX_COLS; j++) {
        matriz[L2][j] *= matriz[L1][j];
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

    // Somando elementos das linhas L1 e L2, colocando o resultado em L2
    int L1, L2;
    printf("\nDigite o número da linha L1 que deseja somar: ");
    scanf("%d", &L1);
    printf("Digite o número da linha L2 onde deseja armazenar o resultado: ");
    scanf("%d", &L2);

    somarLinhas(matriz, L1 - 1, L2 - 1);
    printf("\nMatriz após somar as linhas:\n");
    imprimirMatriz(matriz);

    // Multiplicando elementos das linhas L1 e L2, colocando o resultado em L2
    printf("\nDigite o número da linha L1 que deseja multiplicar: ");
    scanf("%d", &L1);
    printf("Digite o número da linha L2 onde deseja armazenar o resultado: ");
    scanf("%d", &L2);

    multiplicarLinhas(matriz, L1 - 1, L2 - 1);
    printf("\nMatriz após multiplicar as linhas:\n");
    imprimirMatriz(matriz);

    return 0;
}
