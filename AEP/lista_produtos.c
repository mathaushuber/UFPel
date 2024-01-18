#include <stdio.h>
#include <string.h>

typedef struct {
    char nome[80];
    float preco;
} PROD;

void atualizarPreco(PROD *produto, float percentual) {
    produto->preco *= (1 + percentual / 100);
}

void lerDados(PROD *produto) {
    printf("Digite o nome do produto: ");
    scanf(" %[^\n]s", produto->nome);

    printf("Digite o preço do produto: ");
    scanf("%f", &produto->preco);
}

void imprimirProduto(PROD produto) {
    printf("Nome: %s\n", produto.nome);
    printf("Preço: %.2f\n", produto.preco);
    printf("\n");
}

int compararProdutos(const void *a, const void *b) {
    return strcmp(((PROD *)a)->nome, ((PROD *)b)->nome);
}

int main() {
    PROD produtos[20];

    // Ler dados dos produtos
    for (int i = 0; i < 20; i++) {
        printf("\nProduto %d:\n", i + 1);
        lerDados(&produtos[i]);
    }

    // Ordenar produtos por nome
    qsort(produtos, 20, sizeof(PROD), compararProdutos);

    // Inflacionar produtos com preço menor que 100 em 5%
    for (int i = 0; i < 20; i++) {
        if (produtos[i].preco < 100) {
            atualizarPreco(&produtos[i], 5);
        }
    }

    // Imprimir lista de produtos
    printf("\nLista de produtos:\n");
    for (int i = 0; i < 20; i++) {
        imprimirProduto(produtos[i]);
    }

    return 0;
}
