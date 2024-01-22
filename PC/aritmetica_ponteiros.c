#include <stdio.h>

void preencheInteiros(int* vet, int tam, int n) {
    int* ptr = vet;
    while (ptr < vet + tam) {
        *ptr = n;  // Atribui o valor 'n' ao elemento atual
        ptr++;     // Move para o próximo elemento do vetor
    }
}

void preencheReais(double* vet, int tam, double n) {
    // Utiliza aritmética de ponteiros para percorrer o vetor
    double* ptr = vet;
    while (ptr < vet + tam) {
        *ptr = n;  // Atribui o valor 'n' ao elemento atual
        ptr++;     // Move para o próximo elemento do vetor
    }
}

int main() {
    int vetorInt[5];
    preencheInteiros(vetorInt, 5, 42);

    printf("Vetor de inteiros: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", vetorInt[i]);
    }
    printf("\n");

    double vetorReal[3];
    preencheReais(vetorReal, 3, 3.14);

    printf("Vetor de reais: ");
    for (int i = 0; i < 3; i++) {
        printf("%.2f ", vetorReal[i]);
    }
    printf("\n");

    return 0;
}
