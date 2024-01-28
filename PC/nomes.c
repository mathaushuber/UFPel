#include <stdio.h>
#include <string.h>

#define MAX_NOMES 5
#define TAM_NOME 30

void exibirMatriz(char matriz[MAX_NOMES][TAM_NOME]) {
    printf("\nMatriz de Nomes:\n");
    for (int i = 0; i < MAX_NOMES; i++) {
        printf("%d: %s\n", i + 1, matriz[i]);
    }
}

void gravarNome(char matriz[MAX_NOMES][TAM_NOME]) {
    char novoNome[TAM_NOME];
    int linha;

    printf("Digite o nome: ");
    scanf("%s", novoNome);

    printf("Digite a linha para gravar (1 a %d): ", MAX_NOMES);
    scanf("%d", &linha);

    if (linha >= 1 && linha <= MAX_NOMES) {
        strncpy(matriz[linha - 1], novoNome, TAM_NOME);
        printf("Nome gravado com sucesso!\n");
    } else {
        printf("Linha inválida!\n");
    }
}

void apagarNome(char matriz[MAX_NOMES][TAM_NOME]) {
    int linha;

    printf("Digite a linha para apagar (1 a %d): ", MAX_NOMES);
    scanf("%d", &linha);

    if (linha >= 1 && linha <= MAX_NOMES) {
        matriz[linha - 1][0] = '\0';
        printf("Nome apagado com sucesso!\n");
    } else {
        printf("Linha inválida!\n");
    }
}

void substituirNome(char matriz[MAX_NOMES][TAM_NOME]) {
    char novoNome[TAM_NOME];
    char nomeProcurado[TAM_NOME];

    printf("Digite o nome a ser substituído: ");
    scanf("%s", nomeProcurado);

    for (int i = 0; i < MAX_NOMES; i++) {
        if (strcmp(matriz[i], nomeProcurado) == 0) {
            printf("Digite o novo nome: ");
            scanf("%s", novoNome);
            strncpy(matriz[i], novoNome, TAM_NOME);
            printf("Nome substituído com sucesso!\n");
            return;
        }
    }

    printf("Nome não encontrado!\n");
}

int main() {
    char matrizNomes[MAX_NOMES][TAM_NOME];

    for (int i = 0; i < MAX_NOMES; i++) {
        matrizNomes[i][0] = '\0';  // Inicializar a matriz com strings vazias
    }

    int opcao;

    do {
        printf("\nOpções:\n");
        printf("1. Gravar um nome em uma linha da matriz\n");
        printf("2. Apagar o nome contido em determinada linha da matriz\n");
        printf("3. Substituir um nome em determinada linha da matriz\n");
        printf("4. Exibir a matriz de nomes\n");
        printf("5. Sair\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);

        switch (opcao) {
            case 1:
                gravarNome(matrizNomes);
                break;
            case 2:
                apagarNome(matrizNomes);
                break;
            case 3:
                substituirNome(matrizNomes);
                break;
            case 4:
                exibirMatriz(matrizNomes);
                break;
            case 5:
                printf("Programa encerrado.\n");
                break;
            default:
                printf("Opção inválida!\n");
        }
    } while (opcao != 5);

    return 0;
}
