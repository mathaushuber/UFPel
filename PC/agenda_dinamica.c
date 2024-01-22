#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NOME 50
#define MAX_TELEFONE 15
#define MAX_EMAIL 50

typedef struct {
    char nome[MAX_NOME];
    char telefone[MAX_TELEFONE];
    char email[MAX_EMAIL];
} Contato;

typedef struct {
    Contato *contatos;
    int capacidade;
    int tamanho;
} Agenda;

Agenda* criarAgenda(int capacidade) {
    Agenda *agenda = (Agenda*)malloc(sizeof(Agenda));
    if (agenda == NULL) {
        fprintf(stderr, "Erro ao alocar memória para a agenda.\n");
        exit(EXIT_FAILURE);
    }

    agenda->contatos = (Contato*)malloc(capacidade * sizeof(Contato));
    if (agenda->contatos == NULL) {
        fprintf(stderr, "Erro ao alocar memória para os contatos.\n");
        exit(EXIT_FAILURE);
    }

    agenda->capacidade = capacidade;
    agenda->tamanho = 0;

    return agenda;
}

void destruirAgenda(Agenda *agenda) {
    free(agenda->contatos);
    free(agenda);
}

void adicionarContato(Agenda *agenda, const char *nome, const char *telefone, const char *email) {
    if (agenda->tamanho >= agenda->capacidade) {
        fprintf(stderr, "A agenda está cheia. Não é possível adicionar mais contatos.\n");
        return;
    }

    Contato novoContato;
    strncpy(novoContato.nome, nome, MAX_NOME - 1);
    strncpy(novoContato.telefone, telefone, MAX_TELEFONE - 1);
    strncpy(novoContato.email, email, MAX_EMAIL - 1);

    agenda->contatos[agenda->tamanho++] = novoContato;
}

void removerContato(Agenda *agenda, const char *nome) {
    int i, encontrado = 0;

    for (i = 0; i < agenda->tamanho; i++) {
        if (strcmp(agenda->contatos[i].nome, nome) == 0) {
            encontrado = 1;
            break;
        }
    }

    if (encontrado) {
        for (int j = i; j < agenda->tamanho - 1; j++) {
            agenda->contatos[j] = agenda->contatos[j + 1];
        }
        agenda->tamanho--;
        printf("Contato removido com sucesso.\n");
    } else {
        printf("Contato não encontrado.\n");
    }
}

void listarContatos(const Agenda *agenda) {
    if (agenda->tamanho == 0) {
        printf("A agenda está vazia.\n");
        return;
    }

    printf("Lista de Contatos:\n");
    for (int i = 0; i < agenda->tamanho; i++) {
        printf("Nome: %s\nTelefone: %s\nEmail: %s\n\n", agenda->contatos[i].nome,
               agenda->contatos[i].telefone, agenda->contatos[i].email);
    }
}

int main() {
    Agenda *minhaAgenda = criarAgenda(100);

    adicionarContato(minhaAgenda, "Joao", "123456789", "joao@gmail.com");
    adicionarContato(minhaAgenda, "Maria", "987654321", "maria@hotmail.com");
    adicionarContato(minhaAgenda, "Carlos", "111222333", "carlos@yahoo.com");

    listarContatos(minhaAgenda);

    removerContato(minhaAgenda, "Maria");

    listarContatos(minhaAgenda);

    destruirAgenda(minhaAgenda);

    return 0;
}
