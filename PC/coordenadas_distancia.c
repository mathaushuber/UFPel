#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct Cidade {
    char nome[50];
    int x, y;
};

double calcularDistancia(struct Cidade cidade1, struct Cidade cidade2) {
    return sqrt(pow(cidade1.x - cidade2.x, 2) + pow(cidade1.y - cidade2.y, 2));
}

int main() {
    int N;

    printf("Digite o número de cidades: ");
    scanf("%d", &N);

    struct Cidade *cidades = (struct Cidade *)malloc(N * sizeof(struct Cidade));

    for (int i = 0; i < N; i++) {
        printf("Cidade %d:\n", i + 1);
        printf("Nome: ");
        scanf("%s", cidades[i].nome);
        printf("Coordenada X: ");
        scanf("%d", &cidades[i].x);
        printf("Coordenada Y: ");
        scanf("%d", &cidades[i].y);
    }

    double **distancias = (double **)malloc(N * sizeof(double *));
    for (int i = 0; i < N; i++) {
        distancias[i] = (double *)malloc(N * sizeof(double));
    }

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (i == j) {
                distancias[i][j] = 0.0;
            } else {
                distancias[i][j] = calcularDistancia(cidades[i], cidades[j]);
            }
        }
    }

    printf("\nMatriz de Distâncias:\n");
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            printf("%.2f\t", distancias[i][j]);
        }
        printf("\n");
    }

    // Liberação de memória alocada dinamicamente
    free(cidades);
    for (int i = 0; i < N; i++) {
        free(distancias[i]);
    }
    free(distancias);

    return 0;
}
