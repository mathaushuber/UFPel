#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ENTRADAS 100

struct Contato {
    char nome[30];
    char endereco[100];
    char fone[15];
    long int CEP;
};

void adicionarContato(struct Contato agenda[], int *numContatos);
void consultarContato(struct Contato agenda[], int numContatos);
void imprimirPorLetra(struct Contato agenda[], int numContatos, char letra);

int main() {
    struct Contato agenda[MAX_ENTRADAS];
    int numContatos = 0;
    int opcao;
    char letra;

    do {
        printf("\nMenu:\n");
        printf("1. Entrar um nome na agenda\n");
        printf("2. Imprimir na tela os dados de uma pessoa cadastrada\n");
        printf("3. Imprimir na impressora a lista dos nomes que começam pela letra indicada\n");
        printf("4. Sair\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);

        switch (opcao) {
            case 1:
                adicionarContato(agenda, &numContatos);
                break;
            case 2:
                consultarContato(agenda, numContatos);
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

void adicionarContato(struct Contato agenda[], int *numContatos) {
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
        printf("Contato adicionado com sucesso.\n");
    } else {
        printf("A agenda está cheia. Não é possível adicionar mais contatos.\n");
    }
}

void consultarContato(struct Contato agenda[], int numContatos) {
    if (numContatos > 0) {
        char nomeBusca[30];
        printf("Digite o nome para consulta: ");
        scanf(" %[^\n]s", nomeBusca);

        for (int i = 0; i < numContatos; i++) {
            if (strcmp(agenda[i].nome, nomeBusca) == 0) {
                printf("Nome: %s\n", agenda[i].nome);
                printf("Endereço: %s\n", agenda[i].endereco);
                printf("Telefone: %s\n", agenda[i].fone);
                printf("CEP: %ld\n", agenda[i].CEP);
                return;
            }
        }

        printf("Contato não encontrado.\n");
    } else {
        printf("A agenda está vazia. Não há contatos para consultar.\n");
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
