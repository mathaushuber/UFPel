#include <stdio.h>
#include <stdlib.h>

int* valores_entre(int *v, int n, int min, int max, int *qtd) {
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (v[i] > min && v[i] < max) {
            count++;
        }
    }

    int* resultado = NULL;
    if (count > 0) {
        resultado = (int*)malloc(count * sizeof(int));
        if (resultado == NULL) {
            fprintf(stderr, "Erro ao alocar memória.\n");
            exit(EXIT_FAILURE);
        }

        int index = 0;
        for (int i = 0; i < n; i++) {
            if (v[i] > min && v[i] < max) {
                resultado[index++] = v[i];
            }
        }
    }

    *qtd = count;
    return resultado;
}

int main() {
    int n;

    printf("Digite a quantidade de elementos do vetor: ");
    scanf("%d", &n);

    int* vetor = (int*)malloc(n * sizeof(int));
    if (vetor == NULL) {
        fprintf(stderr, "Erro ao alocar memória.\n");
        exit(EXIT_FAILURE);
    }

    printf("Digite os %d elementos do vetor:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &vetor[i]);
    }

    printf("Vetor original: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", vetor[i]);
    }
    printf("\n");

    int min, max;
    printf("Digite o valor mínimo: ");
    scanf("%d", &min);
    printf("Digite o valor máximo: ");
    scanf("%d", &max);

    int qtd_resultado;
    int* resultado = valores_entre(vetor, n, min, max, &qtd_resultado);

    if (qtd_resultado > 0) {
        printf("Valores encontrados: ");
        for (int i = 0; i < qtd_resultado; i++) {
            printf("%d ", resultado[i]);
        }
        printf("\n");
        free(resultado);
    } else {
        printf("Nenhum valor encontrado no intervalo especificado.\n");
    }

    free(vetor);

    return 0;
}
