#include <stdio.h>
#include <stdlib.h>
struct NO{
    int info;
    int altura;
    struct NO *esq;
    struct NO *dir;
};

typedef struct NO* AVL;

AVL* define();
void destruir(AVL *raiz);
int insere(AVL *raiz, int valor);
int vazia(AVL *raiz);
int altura(AVL *raiz);
int totalNo(AVL *raiz);
int buscaNo(AVL *raiz, int valor);
int buscaAlturaNo(AVL *raiz, int valor);
void exibePreOrdem(AVL *raiz);
void exibeInOrdem(AVL *raiz);
void exibePosOrdem(AVL *raiz);

int main(){
    AVL* raiz;
    int opcao, num, res;

    raiz = define();
    printf("Arvore definida.\n\n");

    do{
        printf("1 - Inserir\n");
        printf("2 - Exibir pre-ordem\n");
        printf("3 - Exibir in-ordem\n");
        printf("4 - Exibir pos-ordem\n");
        printf("5 - Altura da Arvore\n");
        printf("6 - Numero total de nos\n");
        printf("7 - Nivel de um no\n");
        printf("8 - Destruir Arvore e Sair\n");
        printf("Digite uma opcao: ");
        scanf("%d", &opcao);

        switch(opcao){

        case 1: //inserir
            printf("Digite o valor que deseja inserir: ");
            scanf("%d", &num);
            res = insere(raiz, num);
            if(res==1) printf("Valor inserido na arvore com sucesso.\n");
            else printf("Erro ao inserir o valor na arvore.\n");
            break;

        case 2: //exibe Pre-Ordem
            printf("Exibindo a Arvore na sequencia Pre-Ordem\n");
            exibePreOrdem(raiz);
            break;

        case 3: //exibe In-Ordem
            printf("Exibindo a Arvore na sequencia In-Ordem\n");
            exibeInOrdem(raiz);
            break;

        case 4: //exibe Pos-Ordem
            printf("Exibindo a Arvore na sequencia In-Ordem\n");
            exibePosOrdem(raiz);
            break;

        case 5: //Altura da Arvore
            res = altura(raiz);
            if(res==0) printf("Arvore Vazia\n");
            else printf("Altura da Arvore: %d\n", res);
            break;

        case 6: //Numero de Nos na Arvore
            res = totalNo(raiz);
            printf("Numero total de Nos na Arvore: %d\n", res);
            break;

        case 7:
            printf("Digite o Valor do No que deseja buscar: ");
            scanf("%d", &num);
            buscaAlturaNo(raiz, num);
            break;

        case 8: //Destruir a Arvore e Sair
            destruir(raiz);
            printf("Saindo...\n");
            break;

        default: //Caso o usuario digite um numero invalido
            printf("Opcao Invalida. Por favor, digite novamente.\n");
            break;

        }
    }while(opcao!= EOF);

    return 0;
}

AVL* define(){
    AVL* raiz = (AVL*) malloc( sizeof(AVL) );

    if(raiz != NULL){
        *raiz = NULL;
    }

    return raiz;
}

int maior(int x, int y){
    if(x > y) return x;
    else return y;
}

void destruirNo(struct NO* no){
    if(no == NULL){
        return;
    }

    destruirNo(no->esq);
    destruirNo(no->esq);

    free(no);
    no = NULL;
}

int alturaNo(struct NO* no){
    if(no == NULL){
        return -1;
    }

    else{
        return no->altura;
    }
}

int fatorBalanceamentoNo(struct NO* no){
    return alturaNo(no->esq) - alturaNo(no->dir);
}

void rotacaoSimplesEsquerda(AVL *A){
    struct NO *B;
    B = (*A)->dir;

    (*A)->dir = B->esq;
    B->esq = (*A);

    (*A)->altura = maior(alturaNo( (*A)->esq ), alturaNo( (*A)->dir) ) + 1;
    B->altura = maior(alturaNo( B->dir ), (*A)->altura) +1;

    (*A) = B;
}

void rotacaoSimplesDireita(AVL *A){
    struct NO *B;
    B = (*A)->esq;

    (*A)->esq = B->dir;
    B->dir = *A;

    (*A)->altura = maior(alturaNo( (*A)->esq ), alturaNo( (*A)->dir )) + 1;
    B->altura = maior( alturaNo(B->esq), (*A)->altura) + 1;

    (*A) = B;
}

void rotacaoDuplaEsquerdaDireita(AVL *A){
    rotacaoSimplesEsquerda(&(*A)->esq);
    rotacaoSimplesDireita(A);
}

void rotacaoDuplaDireitaEsquerda(AVL *A){
    rotacaoSimplesDireita( &(*A)->dir );
    rotacaoSimplesEsquerda(A);
}

void destruir(AVL *raiz){
    if(raiz == NULL) {
        return;
    }

    destruirNo(*raiz);
    free(raiz);
}

int vazia(AVL *raiz){
    if (raiz == NULL) return 1;
    if (*raiz == NULL) return 1;

    return 0;
}

int altura(AVL *raiz){
    if (raiz == NULL) return 0;
    if (*raiz == NULL) return 0;

    int alturaEsq = altura( &((*raiz)->esq) );
    int alturaDir = altura( &((*raiz)->dir) );

    if (alturaEsq > alturaDir){
        return alturaEsq + 1;
    }

    else{
        return alturaDir + 1;
    }
}

int totalNo(AVL *raiz){
    if (raiz == NULL) return 0;
    if (*raiz == NULL) return 0;

    int alturaEsq = totalNo(& ((*raiz)->esq) );
    int alturaDir = totalNo(& ((*raiz)->dir) );

    return (alturaEsq + alturaDir + 1);
}

int buscaNo(AVL *raiz, int valor){
    if (raiz == NULL) return 0;

    struct NO* atual = *raiz;

    while (atual != NULL){
        if (atual->info == valor){
            printf("Encontrou!\n");
            printf("No -> Valor: %d\n", (*raiz)->info);
            return 1;
        }

        else if (atual->info < valor){
            atual = atual->dir;
        }

        else {
            atual = atual->esq;
        }
    }

    printf("Nao Encontrou.\n");
    return 0;
}

int buscaAlturaNo(AVL *raiz, int valor){
    if (raiz == NULL) return 0;

    struct NO* atual = *raiz;

    while (atual != NULL){
        if (atual->info == valor){
            printf("Encontrou!\n");
            printf("No -> Valor: %d | Altura: %d\n", (*raiz)->info, alturaNo(*raiz));
            return 1;
        }

        else if (atual->info < valor){
            atual = atual->dir;
        }

        else {
            atual = atual->esq;
        }
    }

    printf("Nao Encontrou.\n");
    return 0;
}

void exibePreOrdem(AVL *raiz){
    if (raiz == NULL) return;

    if (*raiz != NULL){
        printf("No -> Valor: %d\n", (*raiz)->info);

        exibePreOrdem( &((*raiz)->esq) );
        exibePreOrdem( &((*raiz)->dir) );
    }
}

void exibeInOrdem(AVL *raiz){
    if (raiz == NULL) return;

    if (*raiz != NULL){
        exibeInOrdem( &((*raiz)->esq) );

        printf("No -> Valor: %d\n", (*raiz)->info);

        exibeInOrdem( &((*raiz)->dir) );
    }
}

void exibePosOrdem(AVL *raiz){
    if (raiz == NULL) return;

    if (*raiz != NULL){
        exibePosOrdem( &((*raiz)->esq) );
        exibePosOrdem( &((*raiz)->esq) );

        printf("No -> Valor: %d\n", (*raiz)->info);
    }
}

int insere(AVL *raiz, int valor){
    int res;

    //Arvore Vazia ou No Folha
    if (*raiz == NULL){
        struct NO *novo;
        novo = (struct NO*)malloc( sizeof(struct NO) );

        if (novo == NULL) return 0; //Ocorreu erro

        novo->info = valor;
        novo->altura = 0;
        novo->esq = NULL;
        novo->dir = NULL;

        *raiz = novo;

        return 1; //Inseriu com Sucesso
    }

    struct NO *atual = *raiz;

    if (valor < atual->info){
        if( (res = insere(&(atual->esq), valor) ) == 1){
            if (fatorBalanceamentoNo(atual) >= 2){
                if (valor < (*raiz)->esq->info){
                    rotacaoSimplesDireita(raiz);
                }
                else {
                    rotacaoDuplaEsquerdaDireita(raiz);
                }
            }
        }
    } else {
        if (valor > atual->info){
            if ( (res = insere(&(atual->dir), valor)) == 1 ){
                if (fatorBalanceamentoNo(atual) >= 2){
                    if (valor > (*raiz)->dir->info){
                        rotacaoSimplesEsquerda(raiz);
                    }else {
                        rotacaoDuplaDireitaEsquerda(raiz);
                    }
                }
            }
        } else {
            printf ("O valor informado ja existe na Arvore.\n");
            return 0;
        }
    }

    atual->altura = maior( alturaNo(atual->esq), alturaNo(atual->dir) ) + 1;

    return res;
}
