#include <stdio.h>
#include <string.h>

void removerCaractere(char str[], int posicao) {
    int comprimento = strlen(str);

    // Verifica se a posição é válida
    if (posicao < 0 || posicao >= comprimento) {
        printf("Posição inválida.\n");
        return;
    }

    // Desloca os caracteres após a posição para a esquerda
    for (int i = posicao; i < comprimento - 1; i++) {
        str[i] = str[i + 1];
    }

    // Define o último caractere como nulo
    str[comprimento - 1] = '\0';
}

int main() {
    char Str[100];
    int posicao;

    // Lê a string e a posição do usuário
    printf("Digite uma string: ");
    fgets(Str, sizeof(Str), stdin);
    Str[strcspn(Str, "\n")] = '\0';  // Remove o caractere de nova linha adicionado pelo fgets

    printf("Digite a posição do caractere a ser removido (começando de 0): ");
    scanf("%d", &posicao);

    // Chama a função para remover o caractere
    removerCaractere(Str, posicao);

    // Imprime a string resultante
    printf("String após remover o caractere: %s\n", Str);

    return 0;
}
