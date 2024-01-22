#include <stdio.h>
#include <stdlib.h>

int* uniao(int *v1, int n1, int *v2, int n2) {
    int* v3 = (int*)malloc((n1 + n2) * sizeof(int));
    if (v3 == NULL) {
        exit(EXIT_FAILURE);
    }

    int i, j;

    for (i = 0; i < n1; i++) {
        v3[i] = v1[i];
    }

    for (j = 0; j < n2; j++) {
        v3[i + j] = v2[j];
    }

    return v3;
}

int main() {
    int n1, n2;

    printf("Digite a quantidade de elementos do primeiro vetor: ");
    scanf("%d", &n1);

    int* v1 = (int*)malloc(n1 * sizeof(int));
    if (v1 == NULL) {
        exit(EXIT_FAILURE);
    }

    printf("Digite os %d elementos do primeiro vetor:\n", n1);
    for (int i = 0; i < n1; i++) {
        scanf("%d", &v1[i]);
    }

    printf("Digite a quantidade de elementos do segundo vetor: ");
    scanf("%d", &n2);

    int* v2 = (int*)malloc(n2 * sizeof(int));
    if (v2 == NULL) {
        free(v1);
        exit(EXIT_FAILURE);
    }

    printf("Digite os %d elementos do segundo vetor:\n", n2);
    for (int i = 0; i < n2; i++) {
        scanf("%d", &v2[i]);
    }

    int* v3 = uniao(v1, n1, v2, n2);

    printf("Vetor resultante:\n");
    for (int i = 0; i < n1 + n2; i++) {
        printf("%d ", v3[i]);
    }
    printf("\n");

    free(v1);
    free(v2);
    free(v3);

    return 0;
}
