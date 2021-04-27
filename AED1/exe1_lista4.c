#include <stdio.h>
#include <stdlib.h>

typedef struct no{
    int dado;
    struct no *prox;
}no;

typedef struct Pilha{
    no *topo;
}Pilha;

void iniciaPilha(Pilha *p);
void empilhar(Pilha *p);
int removeTopo(Pilha *p);
void imprimePilha(Pilha *p);
void limpaPilha(Pilha *p);

int main(){
    int escolha;
    Pilha *p1 = (Pilha*)malloc(sizeof(Pilha));
    if(p1 == NULL){
        printf("Erro de alocação da pilha");
        exit(0);
    }else{
        iniciaPilha(p1);
    }
    do{
            printf("---------Menu---------");
            printf("\n\t1. Inserir na pilha");
            printf("\n\t2. Deletar do topo");
            printf("\n\t3. Listar pilha");
            printf("\n\t4. Limpar pilha");
            printf("\n\t5. Sair");
            printf("\n\tDigite sua escolha: ");
            scanf("%d", &escolha);
            switch(escolha){
            case 1:
                empilhar(p1);
                break;
            case 2:
                removeTopo(p1);
                break;
            case 3:
                imprimePilha(p1);
                break;
            case 4:
                limpaPilha(p1);
                break;
            case 5:
                exit(0);
                break;
            default:
                printf("Opção inválida");
                break;
            }
    }while(escolha != EOF);
    free(p1);
    return 0;
}

void iniciaPilha(Pilha *p){
    p->topo = NULL;
}

void empilhar(Pilha *p){
    int dado;
    printf("Valor a ser adicionado: ");
    scanf("%d", &dado);
    no *ptr = (no*) malloc(sizeof(no));
        ptr->dado = dado;
        ptr->prox = p->topo;
        p->topo = ptr;
}

int removeTopo(Pilha *p){
    no *ptr = p->topo;
    int dado;
    if(ptr == NULL){
        printf("Pilha vazia");
        return 0;
    }else{
        p->topo = ptr->prox;
        ptr->prox = NULL;
        dado = ptr->dado;
        free(ptr);
        return dado;
    }
}

void limpaPilha (Pilha *p){
   no *ptr = p->topo;
   no *proxtpilha;
    if(ptr == NULL){
        printf("Pilha vazia");
    }
     while(ptr != NULL){
     proxtpilha = ptr->prox;
     free(ptr);
     ptr = proxtpilha;
  }
}

void imprimePilha(Pilha *p){
    no *ptr = p->topo;
    if(ptr == NULL){
        //PILHA VAZIA
        return;
    }else{
        while(ptr != NULL){
            printf("%d", ptr->dado);
            ptr = ptr->prox;
            printf("\n");
        }
    }
}
