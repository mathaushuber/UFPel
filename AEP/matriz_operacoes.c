#include <stdio.h>

int main() {
    int matriz[3][3];
    int i, j;

    // Lendo os elementos da matriz
    printf("Digite os elementos da matriz 3x3:\n");

    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printf("Elemento [%d][%d]: ", i + 1, j + 1);
            scanf("%d", &matriz[i][j]);
        }
    }

    // Multiplicando cada elemento por 5
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            matriz[i][j] *= 5;
        }
    }

    // Imprimindo o resultado
    printf("\nMatriz multiplicada por 5:\n");

    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) {
            printf("%d\t", matriz[i][j]);
        }
        printf("\n");
    }

    return 0;
}
