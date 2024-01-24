#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Livro {
    char titulo[100];
    char autor[50];
    int ano;
    int disponivel;
};

struct Livro *alocarMemoria(int n);
void adicionarLivro(struct Livro *biblioteca, int *numLivros);
void listarLivros(struct Livro *biblioteca, int numLivros);
void removerLivro(struct Livro *biblioteca, int *numLivros);
void pesquisarPorAutor(struct Livro *biblioteca, int numLivros);

int main() {
    int opcao;
    int numLivros = 0;
    struct Livro *biblioteca = NULL;

    do {
        printf("\n--- Sistema de Gerenciamento de Biblioteca ---\n");
        printf("1. Adicionar Livro\n");
        printf("2. Listar Livros\n");
        printf("3. Remover Livro\n");
        printf("4. Pesquisar por Autor\n");
        printf("0. Sair\n");
        printf("Escolha uma opção: ");
        scanf("%d", &opcao);

        switch (opcao) {
            case 1:
                biblioteca = alocarMemoria(numLivros + 1);
                adicionarLivro(biblioteca, &numLivros);
                break;
            case 2:
                listarLivros(biblioteca, numLivros);
                break;
            case 3:
                removerLivro(biblioteca, &numLivros);
                break;
            case 4:
                pesquisarPorAutor(biblioteca, numLivros);
                break;
            case 0:
                printf("Programa encerrado.\n");
                break;
            default:
                printf("Opção inválida!\n");
        }

    } while (opcao != 0);

    free(biblioteca);

    return 0;
}

struct Livro *alocarMemoria(int n) {
    return (struct Livro *)realloc(NULL, n * sizeof(struct Livro));
}

void adicionarLivro(struct Livro *biblioteca, int *numLivros) {
    struct Livro novoLivro;

    printf("\nDigite as informações do novo livro:\n");
    printf("Título: ");
    scanf("%s", novoLivro.titulo);
    printf("Autor: ");
    scanf("%s", novoLivro.autor);
    printf("Ano de Publicação: ");
    scanf("%d", &novoLivro.ano);

    novoLivro.disponivel = 1;

    biblioteca[*numLivros] = novoLivro;
    (*numLivros)++;
}

void listarLivros(struct Livro *biblioteca, int numLivros) {
    printf("\nLista de Livros na Biblioteca:\n");

    for (int i = 0; i < numLivros; i++) {
        printf("%d. Título: %s, Autor: %s, Ano: %d, Disponível: %s\n", i + 1,
               biblioteca[i].titulo, biblioteca[i].autor, biblioteca[i].ano,
               biblioteca[i].disponivel ? "Sim" : "Não");
    }
}

void removerLivro(struct Livro *biblioteca, int *numLivros) {
    int indice;

    if (*numLivros == 0) {
        printf("A biblioteca está vazia.\n");
        return;
    }

    printf("\nDigite o número do livro que deseja remover: ");
    scanf("%d", &indice);

    if (indice > 0 && indice <= *numLivros) {

        for (int i = indice - 1; i < *numLivros - 1; i++) {
            biblioteca[i] = biblioteca[i + 1];
        }
        (*numLivros)--;
        printf("Livro removido com sucesso.\n");

        biblioteca = (struct Livro *)realloc(biblioteca, *numLivros * sizeof(struct Livro));
    } else {
        printf("Número de livro inválido.\n");
    }
}

void pesquisarPorAutor(struct Livro *biblioteca, int numLivros) {
    char autorBusca[50];

    if (numLivros == 0) {
        printf("A biblioteca está vazia.\n");
        return;
    }

    printf("\nDigite o nome do autor para pesquisar: ");
    scanf("%s", autorBusca);

    printf("\nLivros do autor %s:\n", autorBusca);

    for (int i = 0; i < numLivros; i++) {
        if (strcmp(biblioteca[i].autor, autorBusca) == 0) {
            printf("Título: %s, Ano: %d, Disponível: %s\n",
                   biblioteca[i].titulo, biblioteca[i].ano,
                   biblioteca[i].disponivel ? "Sim" : "Não");
        }
    }
}
