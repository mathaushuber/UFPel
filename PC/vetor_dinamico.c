#include <stdio.h>
#include <stdlib.h>

int* criarVetor(int n) {
    return (int*)malloc(n * sizeof(int));
}

void imprimirVetor(const int* vetor, int n) {
    printf("Elementos do vetor: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", vetor[i]);
    }
    printf("\n");
}

void liberarMemoria(int* vetor) {
    free(vetor);
}

int main() {
    int n;

    printf("Digite o valor de n: ");
    scanf("%d", &n);

    int* vetor = criarVetor(n);

    if (vetor == NULL) {
        fprintf(stderr, "Erro ao alocar memória.\n");
        return 1;
    }

    printf("Digite os %d elementos do vetor:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &vetor[i]);
    }

    imprimirVetor(vetor, n);
    liberarMemoria(vetor);

    return 0;
}
