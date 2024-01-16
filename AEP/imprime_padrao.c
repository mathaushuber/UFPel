#include <stdio.h>

void imprimirPadrao(int n) {
    // Verifica se o número é ímpar
    if (n % 2 != 1) {
        printf("Por favor, digite um número ímpar.\n");
        return;
    }

    // Loop para imprimir o padrão
    for (int i = 1; i <= n; i++) {
        // Espaços iniciais
        for (int j = 1; j < i; j++) {
            printf("   ");
        }

        // Números
        for (int j = i; j <= n; j++) {
            printf("%2d ", j);
        }

        // Nova linha após cada linha de números
        printf("\n");
    }
}

int main() {
    int numeroMaximo;

    // Solicita ao usuário um número máximo ímpar
    do {
        printf("Digite um número máximo ímpar: ");
        scanf("%d", &numeroMaximo);

        // Limpa o buffer de entrada
        while (getchar() != '\n');
    } while (numeroMaximo % 2 != 1);

    // Chama a função para imprimir o padrão
    imprimirPadrao(numeroMaximo);

    return 0;
}
