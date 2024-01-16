#include <stdio.h>

int main() {
    char tipoCarro;
    double percurso, consumoEstimado;

    // Solicita ao usuário o tipo de carro
    printf("Informe o tipo de carro (A, B ou C): ");
    scanf(" %c", &tipoCarro);

    // Solicita ao usuário o percurso rodado em km
    printf("Informe o percurso rodado em km: ");
    scanf("%lf", &percurso);

    // Calcula o consumo estimado conforme o tipo de carro
    switch (tipoCarro) {
        case 'A':
        case 'a':
            consumoEstimado = percurso / 8;
            break;
        case 'B':
        case 'b':
            consumoEstimado = percurso / 9;
            break;
        case 'C':
        case 'c':
            consumoEstimado = percurso / 12;
            break;
        default:
            printf("Tipo de carro inválido.\n");
            return 1; // Retorna código de erro
    }

    // Imprime o resultado
    printf("O consumo estimado é: %.2f litros\n", consumoEstimado);

    return 0;
}
