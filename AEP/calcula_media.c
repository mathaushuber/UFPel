#include <stdio.h>

// Função para calcular o conceito com base na média de aproveitamento
char calcularConceito(float mediaAproveitamento) {
    char conceito;

    if (mediaAproveitamento >= 9.0) {
        conceito = 'A';
    } else if (mediaAproveitamento >= 7.5) {
        conceito = 'B';
    } else if (mediaAproveitamento >= 6.0) {
        conceito = 'C';
    } else if (mediaAproveitamento >= 4.0) {
        conceito = 'D';
    } else {
        conceito = 'E';
    }

    return conceito;
}

int main() {
    float N1, N2, N3, mediaExercicios, mediaAproveitamento;

    // Solicita ao usuário as notas e a média dos exercícios
    printf("Digite a nota N1: ");
    scanf("%f", &N1);

    printf("Digite a nota N2: ");
    scanf("%f", &N2);

    printf("Digite a nota N3: ");
    scanf("%f", &N3);

    printf("Digite a média dos exercícios: ");
    scanf("%f", &mediaExercicios);

    // Calcula a média de aproveitamento
    mediaAproveitamento = (N1 + N2 * 2 + N3 * 3 + mediaExercicios) / 7;

    // Calcula e imprime o conceito
    char conceito = calcularConceito(mediaAproveitamento);
    printf("Média de Aproveitamento: %.2f\n", mediaAproveitamento);
    printf("Conceito: %c\n", conceito);

    return 0;
}
