#include <stdio.h>
#include <stdlib.h>

int** alocarMatriz(int m, int n) {
    int** matriz = (int**)malloc(m * sizeof(int*));
    
    if (matriz == NULL) {
        fprintf(stderr, "Erro ao alocar memória para linhas da matriz.\n");
        exit(1);
    }

    for (int i = 0; i < m; i++) {
        matriz[i] = (int*)malloc(n * sizeof(int));
        if (matriz[i] == NULL) {
            fprintf(stderr, "Erro ao alocar memória para colunas da matriz.\n");
            exit(1);
        }
    }

    return matriz;
}

void liberarMatriz(int** matriz, int m) {
    for (int i = 0; i < m; i++) {
        free(matriz[i]);
    }
    free(matriz);
}

int main() {
    int m, n;

    printf("Digite o número de linhas (m): ");
    scanf("%d", &m);
    printf("Digite o número de colunas (n): ");
    scanf("%d", &n);

    int** matriz = alocarMatriz(m, n);

    printf("Digite os elementos da matriz:\n");
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%d", &matriz[i][j]);
        }
    }

    printf("Matriz inserida:\n");
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }

    liberarMatriz(matriz, m);

    return 0;
}
