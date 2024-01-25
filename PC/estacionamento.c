#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_VAGAS 10

struct Veiculo {
    char placa[10];
    char modelo[20];
    int ano;
};

void inicializarEstacionamento(struct Veiculo *estacionamento, int tamanho);
void adicionarVeiculo(struct Veiculo *estacionamento, int *numVeiculos);
void removerVeiculo(struct Veiculo *estacionamento, int *numVeiculos);
void listarVeiculos(struct Veiculo *estacionamento, int numVeiculos);

int main() {
    int opcao;
    int numVeiculos = 0;
    struct Veiculo estacionamento[MAX_VAGAS];

    inicializarEstacionamento(estacionamento, MAX_VAGAS);

    do {
        printf("\n--- Sistema de Gerenciamento de Estacionamento ---\n");
        printf("1. Adicionar Veículo\n");
        printf("2. Remover Veículo\n");
        printf("3. Listar Veículos\n");
        printf("0. Sair\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);

        switch (opcao) {
            case 1:
                adicionarVeiculo(estacionamento, &numVeiculos);
                break;
            case 2:
                removerVeiculo(estacionamento, &numVeiculos);
                break;
            case 3:
                listarVeiculos(estacionamento, numVeiculos);
                break;
            case 0:
                printf("Programa encerrado.\n");
                break;
            default:
                printf("Opção inválida!\n");
        }

    } while (opcao != 0);

    return 0;
}

void inicializarEstacionamento(struct Veiculo *estacionamento, int tamanho) {
    for (int i = 0; i < tamanho; i++) {
        estacionamento[i].placa[0] = '\0';
        estacionamento[i].modelo[0] = '\0';
        estacionamento[i].ano = 0;
    }
}

void adicionarVeiculo(struct Veiculo *estacionamento, int *numVeiculos) {
    if (*numVeiculos < MAX_VAGAS) {
        struct Veiculo novoVeiculo;

        printf("\nDigite as informações do novo veículo:\n");
        printf("Placa: ");
        scanf("%s", novoVeiculo.placa);
        printf("Modelo: ");
        scanf("%s", novoVeiculo.modelo);
        printf("Ano: ");
        scanf("%d", &novoVeiculo.ano);

        estacionamento[*numVeiculos] = novoVeiculo;
        (*numVeiculos)++;
        printf("Veículo adicionado com sucesso.\n");
    } else {
        printf("O estacionamento está cheio.\n");
    }
}

void removerVeiculo(struct Veiculo *estacionamento, int *numVeiculos) {
    char placaRemover[10];

    if (*numVeiculos == 0) {
        printf("O estacionamento está vazio.\n");
        return;
    }

    printf("\nDigite a placa do veículo que deseja remover: ");
    scanf("%s", placaRemover);

    for (int i = 0; i < *numVeiculos; i++) {
        if (strcmp(estacionamento[i].placa, placaRemover) == 0) {
            for (int j = i; j < *numVeiculos - 1; j++) {
                estacionamento[j] = estacionamento[j + 1];
            }
            (*numVeiculos)--;
            printf("Veículo removido com sucesso.\n");
            return;
        }
    }

    printf("Veículo com a placa %s não encontrado.\n", placaRemover);
}

void listarVeiculos(struct Veiculo *estacionamento, int numVeiculos) {
    printf("\nVeículos no Estacionamento:\n");

    for (int i = 0; i < numVeiculos; i++) {
        printf("Placa: %s, Modelo: %s, Ano: %d\n",
               estacionamento[i].placa, estacionamento[i].modelo, estacionamento[i].ano);
    }
}
