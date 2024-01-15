#include <stdio.h>

// Definindo a struct para representar uma pessoa
struct Pessoa {
    char nome[50];
    int idade;
    float peso;
    float altura;
};

int main() {
    // Criando um vetor de 3 pessoas
    struct Pessoa pessoas[3];

    // Lendo os dados das pessoas
    printf("Digite os dados das pessoas:\n");

    for (int i = 0; i < 3; i++) {
        printf("Digite o nome da pessoa %d: ", i + 1);
        scanf("%s", pessoas[i].nome);

        printf("Digite a idade da pessoa %d: ", i + 1);
        scanf("%d", &pessoas[i].idade);

        printf("Digite o peso da pessoa %d: ", i + 1);
        scanf("%f", &pessoas[i].peso);

        printf("Digite a altura da pessoa %d: ", i + 1);
        scanf("%f", &pessoas[i].altura);
    }

    // Imprimindo os dados das pessoas
    printf("\nDados das pessoas:\n");

    for (int i = 0; i < 3; i++) {
        printf("Nome: %s\n", pessoas[i].nome);
        printf("Idade: %d anos\n", pessoas[i].idade);
        printf("Peso: %.2f kg\n", pessoas[i].peso);
        printf("Altura: %.2f metros\n", pessoas[i].altura);
        printf("\n");
    }

    return 0;
}
