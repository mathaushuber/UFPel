#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct funcionario {
    char nome[100];
    double salario;
} Funcionario;

typedef struct firma {
    char nome[100];
    unsigned qtdFuncionario;
    Funcionario** vetor;
} Firma;

Firma* criarFirma(const char* nomeFirma) {
    // Aloca dinamicamente memória para a estrutura Firma
    Firma* novaFirma = (Firma*)malloc(sizeof(Firma));

    if (novaFirma == NULL) {
        // Verifica se a alocação de memória foi bem-sucedida
        perror("Erro ao alocar memória para Firma");
        exit(EXIT_FAILURE);
    }

    // Inicializa os membros da estrutura Firma
    strcpy(novaFirma->nome, nomeFirma);
    novaFirma->qtdFuncionario = 0;
    novaFirma->vetor = NULL;

    return novaFirma;
}

int main() {
    Firma* minhaFirma = criarFirma("Minha Empresa");

    printf("Nome da Firma: %s\n", minhaFirma->nome);
    printf("Quantidade de Funcionários: %u\n", minhaFirma->qtdFuncionario);

    // Liberando a memória alocada para a firma
    free(minhaFirma);

    return 0;
}
