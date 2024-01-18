#include <stdio.h>
#include <string.h>

#define MAX_ENTRADAS 100

struct Contato {
    char nome[30];
    char endereco[100];
    char fone[10];
    long int CEP;
};

void cadastrarContato(struct Contato agenda[], int *numContatos);
void imprimirContato(struct Contato agenda[], int numContatos);
void imprimirPorLetra(struct Contato agenda[], int numContatos, char letra);

int main() {
    struct Contato agenda[MAX_ENTRADAS];
    int numContatos = 0;
    int opcao;
    char letra;

    do {
        printf("\nMenu:\n");
        printf("1. Entrar um novo nome na agenda\n");
        printf("2. Imprimir na tela os dados de uma pessoa cadastrada\n");
        printf("3. Imprimir a lista de nomes cadastrados que comecem pela letra indicada\n");
        printf("4. Fim\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);

        switch (opcao) {
            case 1:
                cadastrarContato(agenda, &numContatos);
                break;
            case 2:
                imprimirContato(agenda, numContatos);
                break;
            case 3:
                printf("Digite a letra: ");
                scanf(" %c", &letra);
                imprimirPorLetra(agenda, numContatos, letra);
                break;
            case 4:
                printf("Encerrando o programa.\n");
                break;
            default:
                printf("Opção inválida. Tente novamente.\n");
        }
    } while (opcao != 4);

    return 0;
}

void cadastrarContato(struct Contato agenda[], int *numContatos) {
    if (*numContatos < MAX_ENTRADAS) {
        printf("Digite o nome: ");
        scanf(" %[^\n]s", agenda[*numContatos].nome);

        printf("Digite o endereço: ");
        scanf(" %[^\n]s", agenda[*numContatos].endereco);

        printf("Digite o telefone: ");
        scanf("%s", agenda[*numContatos].fone);

        printf("Digite o CEP: ");
        scanf("%ld", &agenda[*numContatos].CEP);

        (*numContatos)++;
        printf("Contato cadastrado com sucesso.\n");
    } else {
        printf("A agenda está cheia. Não é possível adicionar mais contatos.\n");
    }
}

void imprimirContato(struct Contato agenda[], int numContatos) {
    if (numContatos > 0) {
        int indice;
        printf("Digite o índice do contato a ser impresso (de 1 a %d): ", numContatos);
        scanf("%d", &indice);

        if (indice >= 1 && indice <= numContatos) {
            printf("Nome: %s\n", agenda[indice - 1].nome);
            printf("Endereço: %s\n", agenda[indice - 1].endereco);
            printf("Telefone: %s\n", agenda[indice - 1].fone);
            printf("CEP: %ld\n", agenda[indice - 1].CEP);
        } else {
            printf("Índice inválido.\n");
        }
    } else {
        printf("A agenda está vazia. Não há contatos para imprimir.\n");
    }
}

void imprimirPorLetra(struct Contato agenda[], int numContatos, char letra) {
    printf("Contatos com nomes começando com '%c':\n", letra);
    for (int i = 0; i < numContatos; i++) {
        if (agenda[i].nome[0] == letra || agenda[i].nome[0] == letra + ('a' - 'A')) {
            printf("%s\n", agenda[i].nome);
        }
    }
}
