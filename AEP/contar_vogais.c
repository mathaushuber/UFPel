#include <stdio.h>
#include <ctype.h>

int contarVogais(char nome[]) {
    int contadorVogais = 0;
    
    for (int i = 0; nome[i] != '\0'; i++) {
        char caractere = tolower(nome[i]);
        if (caractere == 'a' || caractere == 'e' || caractere == 'i' || caractere == 'o' || caractere == 'u') {
            contadorVogais++;
        }
    }
    
    return contadorVogais;
}

int main() {
    char nome[100];
    
    // Solicita ao usuário o nome
    printf("Digite um nome: ");
    fgets(nome, sizeof(nome), stdin);
    
    // Remove o caractere de nova linha adicionado pelo fgets
    nome[strcspn(nome, "\n")] = '\0';

    int totalCaracteres = 0;
    int totalVogais = 0;
    
    // Calcula o número total de caracteres e de vogais
    for (int i = 0; nome[i] != '\0'; i++) {
        if (isalpha(nome[i])) {
            totalCaracteres++;
        }
    }

    totalVogais = contarVogais(nome);
    
    // Calcula a porcentagem de vogais em relação ao total de caracteres
    double porcentagemVogais = (double)totalVogais / totalCaracteres * 100;

    // Imprime os resultados
    printf("Número total de caracteres: %d\n", totalCaracteres);
    printf("Número de vogais: %d\n", totalVogais);
    printf("Porcentagem de vogais: %.2f%%\n", porcentagemVogais);

    return 0;
}
