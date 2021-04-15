/*  Mathaus Corrêa Huber - Ciência da Computação - 16201045
    Implementar em C um programa que utilize uma matriz com vetor de ponteiros e que ofereça as seguintes opções para o usuário:
    a)Criar e redimencionar uma matriz m x n, onde n e m são fornecidos pelo usuário;
    b)Realizar a leitura dos elementos da matriz;
    c)Fornecer a soma dos elementos da matriz;
    d)Retornar em um vetor (utilizando ponteiros)os elementos de uma determinada coluna da matriz;
    e)Imprimir a matriz
    f)Sair do programas.*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ** criaMatriz(int m, int n);
void leiaMatriz(int **mat, int m, int n);
int somaMatriz(int **mat, int m, int n);
int* colunaMatriz(int ** mat, int m, int n, int ncoluna);
void liberaMatriz(int **mat, int ncoluna);
void imprimeMatriz(int **mat, int m, int n);
void imprimeVetor (int *vet, int n);

int main(){
    int m, n, **mat, ncoluna, *vetor;
    printf("Número de linhas: ");
    scanf("%d", &m);
    printf("Número de colunas: ");
    scanf("%d", &n);
    
    mat = criaMatriz(m, n);
    leiaMatriz(mat, m, n);
    imprimeMatriz(mat, m, n);
    somaMatriz(mat, m, n);
    printf("Entre com o índice da coluna: ");
    scanf("%d", &ncoluna);
    colunaMatriz(mat, m, n, ncoluna);
    vetor = (colunaMatriz, m, n, ncoluna);
    imprimeVetor(&vetor, n);
    liberaMatriz(mat, ncoluna);
    return 0;
}

int ** criaMatriz(int m, int n){
    int **mat, i, ncoluna;
    mat = malloc(m * sizeof(int*));
    for(i = 0; i < n; i++){
        mat[i] = malloc(n * sizeof(int));
    }
   return mat; 
}

void leiaMatriz(int **mat, int m, int n){
    int i, j;
    for(i = 0; i < m; i++){
        for(j = 0; j < n; j++){
            printf("Digite o elemento %d %d: ", i, j);
            scanf("%d", &mat[i][j]);
        }
    }
}

void imprimeMatriz(int **mat, int m, int n){
    int i, j;
    printf("\n---------MATRIZ ORIGINAL---------\n");
    for(i = 0; i < m; i++){
        for(j = 0; j < n; j++){
            printf("%d", mat[i][j]);
        }
        printf("\n");
    }
}

int somaMatriz(int **mat, int m, int n){
    int i, j, soma = 0;
    for(i = 0; i < m; i++){
        for(j = 0; j < n; j++){
            soma+= mat[i][j];
        }
    }
    printf("Soma dos elementos da matriz: %d\n", soma);
}

void liberaMatriz(int **matriz, int ncoluna){
    for (int i = 0; i < ncoluna; i++){
        free(matriz[i]);
       free(matriz);
    }
}

int* colunaMatriz(int ** mat, int m, int n, int ncoluna){
    int *vetor = malloc(n * sizeof(int));
    int i, j;
    for(i = 0; i < m; i++){
        for(j = 0; j < n; j++){
                *vetor = mat[i][ncoluna];
        }
    }
    return vetor;
}

void imprimeVetor (int *vet, int n){
    int i;
    printf("Imprimindo o vetor\n");
    for (int i = 0; i < n; i++){
        printf("%d", vet[i]);
    }
    printf("\n");
}