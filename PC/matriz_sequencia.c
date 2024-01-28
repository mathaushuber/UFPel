#include <stdio.h>
#include <stdlib.h>

int **alocarMatriz(int linhas, int colunas) {
    int **matriz = (int **)malloc(linhas * sizeof(int *));
    for (int i = 0; i < linhas; i++) {
        matriz[i] = (int *)malloc(colunas * sizeof(int));
    }
    return matriz;
}

void desalocarMatriz(int **matriz, int linhas) {
    for (int i = 0; i < linhas; i++) {
        free(matriz[i]);
    }
    free(matriz);
}

void preencherMatriz(int **matriz, int linhas, int colunas) {
    printf("Digite os elementos da matriz:\n");
    for (int i = 0; i < linhas; i++) {
        for (int j = 0; j < colunas; j++) {
            scanf("%d", &matriz[i][j]);
        }
    }
}

void imprimirMatriz(int **matriz, int linhas, int colunas) {
    printf("\nMatriz:\n");
    for (int i = 0; i < linhas; i++) {
        for (int j = 0; j < colunas; j++) {
            printf("%d\t", matriz[i][j]);
        }
        printf("\n");
    }
}

void encontrarMaiores(int **matriz, int linhas, int colunas) {
    int maiores[3] = {0};  // Inicializar com os três menores valores possíveis
    int linhasMaiores[3];
    int colunasMaiores[3];

    for (int i = 0; i < linhas; i++) {
        for (int j = 0; j < colunas; j++) {
            for (int k = 0; k < 3; k++) {
                if (matriz[i][j] > maiores[k]) {
                    for (int l = 2; l > k; l--) {
                        maiores[l] = maiores[l - 1];
                        linhasMaiores[l] = linhasMaiores[l - 1];
                        colunasMaiores[l] = colunasMaiores[l - 1];
                    }
                    maiores[k] = matriz[i][j];
                    linhasMaiores[k] = i;
                    colunasMaiores[k] = j;
                    break;
                }
            }
        }
    }

    printf("\nTrês maiores números e suas posições:\n");
    for (int i = 0; i < 3; i++) {
        printf("Número: %d, Linha: %d, Coluna: %d\n", maiores[i], linhasMaiores[i], colunasMaiores[i]);
    }
}

int main() {
    int N, M;

    printf("Digite o número de linhas (N): ");
    scanf("%d", &N);
    printf("Digite o número de colunas (M): ");
    scanf("%d", &M);

    int **matriz = alocarMatriz(N, M);

    preencherMatriz(matriz, N, M);

    imprimirMatriz(matriz, N, M);

    encontrarMaiores(matriz, N, M);

    desalocarMatriz(matriz, N);

    return 0;
}
