#include <stdio.h>
#include <stdlib.h>

#define TAM_INICIAL 10
#define TAM_INCREMENTO 10

void imprimirVetor(int *vetor, int tamanho) {
    printf("\nVetor: ");
    for (int i = 0; i < tamanho; i++) {
        printf("%d ", vetor[i]);
    }
    printf("\n");
}

int main() {
    int *vetor = (int *)malloc(TAM_INICIAL * sizeof(int));
    int tamanhoAtual = TAM_INICIAL;
    int quantidadeElementos = 0;
    int numero;

    if (vetor == NULL) {
        printf("Erro de alocação de memória.\n");
        return 1;
    }

    printf("Digite os números (digite 0 para encerrar):\n");

    while (1) {
        scanf("%d", &numero);

        if (numero == 0) {
            break;
        }

        if (quantidadeElementos == tamanhoAtual) {
            // Se o vetor está cheio, aloque um novo vetor com mais espaço
            tamanhoAtual += TAM_INCREMENTO;
            vetor = (int *)realloc(vetor, tamanhoAtual * sizeof(int));

            if (vetor == NULL) {
                printf("Erro de realocação de memória.\n");
                return 1;
            }
        }

        vetor[quantidadeElementos] = numero;
        quantidadeElementos++;
    }

    imprimirVetor(vetor, quantidadeElementos);

    free(vetor);

    return 0;
}
