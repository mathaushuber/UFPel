#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void ler_aposta(int *aposta, int n);
void sorteia_valores(int *sorteio, int n);
int* compara_aposta(int *aposta, int *sorteio, int *qtdacertos, int na, int ns);

int main() {
    int n_aposta, n_sorteio;

    printf("Digite a quantidade de números que você gostaria de apostar (entre 1 e 20): ");
    scanf("%d", &n_aposta);

    int* aposta = (int*)malloc(n_aposta * sizeof(int));
    if (aposta == NULL) {
        fprintf(stderr, "Erro ao alocar memória para a aposta.\n");
        return -1;
    }

    ler_aposta(aposta, n_aposta);

    printf("Agora, o computador irá sortear 20 números aleatórios.\n");

    n_sorteio = 20;
    int* sorteio = (int*)malloc(n_sorteio * sizeof(int));
    if (sorteio == NULL) {
        fprintf(stderr, "Erro ao alocar memória para o sorteio.\n");
        free(aposta);
        return -1;
    }

    sorteia_valores(sorteio, n_sorteio);

    int qtd_acertos = 0;
    int* acertos = compara_aposta(aposta, sorteio, &qtd_acertos, n_aposta, n_sorteio);

    printf("\nResultados:\n");
    printf("Números sorteados: ");
    for (int i = 0; i < n_sorteio; i++) {
        printf("%d ", sorteio[i]);
    }

    printf("\nNúmeros apostados: ");
    for (int i = 0; i < n_aposta; i++) {
        printf("%d ", aposta[i]);
    }

    printf("\nNúmeros acertados: ");
    for (int i = 0; i < qtd_acertos; i++) {
        printf("%d ", acertos[i]);
    }

    printf("\nQuantidade de acertos: %d\n", qtd_acertos);

    // Liberando a memória alocada dinamicamente
    free(aposta);
    free(sorteio);
    free(acertos);

    return 0;
}

void ler_aposta(int *aposta, int n) {
    printf("Digite os %d números escolhidos (entre 0 e 100):\n", n);
    for (int i = 0; i < n; i++) {
        do {
            scanf("%d", &aposta[i]);
        } while (aposta[i] < 0 || aposta[i] > 100);
    }
}

void sorteia_valores(int *sorteio, int n) {
    srand(time(NULL));

    for (int i = 0; i < n; i++) {
        sorteio[i] = rand() % 101;
    }
}

int* compara_aposta(int *aposta, int *sorteio, int *qtdacertos, int na, int ns) {
    int* acertos = (int*)malloc(ns * sizeof(int));
    if (acertos == NULL) {
        fprintf(stderr, "Erro ao alocar memória para os acertos.\n");
        exit(EXIT_FAILURE);
    }

    *qtdacertos = 0;

    for (int i = 0; i < na; i++) {
        for (int j = 0; j < ns; j++) {
            if (aposta[i] == sorteio[j]) {
                acertos[*qtdacertos] = aposta[i];
                (*qtdacertos)++;
                break;
            }
        }
    }

    return acertos;
}
