#include <stdio.h>
#include <stdlib.h>

typedef struct {
    char nome[50];
    char dataNascimento[11];
    char cpf[12];
} Pessoa;

void preencherDados(Pessoa *pessoa) {
    printf("Digite o nome: ");
    scanf("%s", pessoa->nome);

    printf("Digite a data de nascimento (DD/MM/AAAA): ");
    scanf("%s", pessoa->dataNascimento);

    printf("Digite o CPF (XXX.XXX.XXX-XX): ");
    scanf("%s", pessoa->cpf);
}

void imprimirDados(const Pessoa *pessoa) {
    printf("Nome: %s\n", pessoa->nome);
    printf("Data de Nascimento: %s\n", pessoa->dataNascimento);
    printf("CPF: %s\n", pessoa->cpf);
}

int main() {
    Pessoa *ponteiroPessoa = (Pessoa *)malloc(sizeof(Pessoa));

    if (ponteiroPessoa == NULL) {
        fprintf(stderr, "Erro ao alocar memória.\n");
        return 1;
    }

    preencherDados(ponteiroPessoa);
    imprimirDados(ponteiroPessoa);

    free(ponteiroPessoa);

    return 0;
}
