#include <stdio.h>
#include <stdlib.h>

int main() {

    char *vetorBytes = (char *)malloc(1024);

    int **matrizInteiros = (int **)malloc(10 * sizeof(int *));
    for (int i = 0; i < 10; i++) {
        matrizInteiros[i] = (int *)malloc(10 * sizeof(int));
    }

    struct Registro {
        char nomeProduto[30];
        int codigoProduto;
        float preco;
    };

    struct Registro *vetorRegistros = (struct Registro *)malloc(50 * sizeof(struct Registro));

    char **vetorTexto = (char **)malloc(100 * sizeof(char *));
    for (int i = 0; i < 100; i++) {
        vetorTexto[i] = (char *)malloc(80 * sizeof(char));
    }

    vetorBytes[0] = 'A';
    matrizInteiros[0][0] = 42;
    vetorRegistros[0].codigoProduto = 123;
    vetorTexto[0][0] = 'H';

    free(vetorBytes);

    for (int i = 0; i < 10; i++) {
        free(matrizInteiros[i]);
    }
    free(matrizInteiros);

    free(vetorRegistros);

    for (int i = 0; i < 100; i++) {
        free(vetorTexto[i]);
    }
    free(vetorTexto);

    return 0;
}
