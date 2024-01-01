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

// Função para multiplicar uma linha da matriz por um número
void multiplicarLinha(int matriz[MAX_ROWS][MAX_COLS], int linha, int multiplicador) {
    for (int j = 0; j < MAX_COLS; j++) {
        matriz[linha][j] *= multiplicador;
    }
}

// Função para multiplicar uma coluna da matriz por um número
void multiplicarColuna(int matriz[MAX_ROWS][MAX_COLS], int coluna, int multiplicador) {
    for (int i = 0; i < MAX_ROWS; i++) {
        matriz[i][coluna] *= multiplicador;
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

    // Multiplicando uma linha por um número
    int linha, multiplicador;
    printf("\nDigite o número da linha que deseja multiplicar: ");
    scanf("%d", &linha);
    printf("Digite o multiplicador para a linha: ");
    scanf("%d", &multiplicador);

    multiplicarLinha(matriz, linha - 1, multiplicador);
    printf("\nMatriz após multiplicar a linha:\n");
    imprimirMatriz(matriz);

    // Multiplicando uma coluna por um número
    int coluna;
    printf("\nDigite o número da coluna que deseja multiplicar: ");
    scanf("%d", &coluna);
    printf("Digite o multiplicador para a coluna: ");
    scanf("%d", &multiplicador);

    multiplicarColuna(matriz, coluna - 1, multiplicador);
    printf("\nMatriz após multiplicar a coluna:\n");
    imprimirMatriz(matriz);

    return 0;
}
