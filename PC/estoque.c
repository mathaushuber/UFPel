#include <stdio.h>
#include <string.h>

struct Produto {
    int codigo;
    char nome[50];
    int quantidade;
    float preco;
};

struct Produto encontrarMaiorPreco(struct Produto produtos[], int n) {
    struct Produto maiorPreco = produtos[0];

    for (int i = 1; i < n; i++) {
        if (produtos[i].preco > maiorPreco.preco) {
            maiorPreco = produtos[i];
        }
    }

    return maiorPreco;
}

struct Produto encontrarMaiorQuantidade(struct Produto produtos[], int n) {
    struct Produto maiorQuantidade = produtos[0];

    for (int i = 1; i < n; i++) {
        if (produtos[i].quantidade > maiorQuantidade.quantidade) {
            maiorQuantidade = produtos[i];
        }
    }

    return maiorQuantidade;
}

int main() {
    int N;

    printf("Digite a quantidade de produtos: ");
    scanf("%d", &N);

    struct Produto produtos[N];

    for (int i = 0; i < N; i++) {
        printf("Produto %d:\n", i + 1);
        printf("Código: ");
        scanf("%d", &produtos[i].codigo);
        printf("Nome: ");
        getchar(); // Limpar o buffer do teclado
        fgets(produtos[i].nome, sizeof(produtos[i].nome), stdin);
        produtos[i].nome[strcspn(produtos[i].nome, "\n")] = '\0';  // Remover o caractere de nova linha do nome
        printf("Quantidade: ");
        scanf("%d", &produtos[i].quantidade);
        printf("Preço: ");
        scanf("%f", &produtos[i].preco);
    }

    struct Produto produtoMaiorPreco = encontrarMaiorPreco(produtos, N);
    printf("\nProduto com o maior preço de venda:\n");
    printf("Código: %d\n", produtoMaiorPreco.codigo);
    printf("Nome: %s\n", produtoMaiorPreco.nome);
    printf("Quantidade: %d\n", produtoMaiorPreco.quantidade);
    printf("Preço: %.2f\n", produtoMaiorPreco.preco);

    struct Produto produtoMaiorQuantidade = encontrarMaiorQuantidade(produtos, N);
    printf("\nProduto com a maior quantidade disponível no estoque:\n");
    printf("Código: %d\n", produtoMaiorQuantidade.codigo);
    printf("Nome: %s\n", produtoMaiorQuantidade.nome);
    printf("Quantidade: %d\n", produtoMaiorQuantidade.quantidade);
    printf("Preço: %.2f\n", produtoMaiorQuantidade.preco);

    return 0;
}
