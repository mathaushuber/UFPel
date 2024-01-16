#include <stdio.h>

int main() {
    int produto, linha;

    for (int i = 1; i <= 9; i++) {
        for (int j = 0; j <= 9; j++) {
            for (int k = 0; k <= 9; k++) {
                produto = i * j * k;

                printf("%d (%d*%d*%d)\n", produto, i, j, k);

                // Pausa a cada 20 linhas e solicita pressionar uma tecla
                linha++;
                if (linha % 20 == 0) {
                    printf("\nPressione uma tecla para continuar...");
                    getchar();
                }
            }
        }
    }

    return 0;
}
