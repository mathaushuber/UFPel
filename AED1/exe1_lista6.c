#include <stdio.h>
#include <stdlib.h>

struct item{
	int cod;
};

typedef struct item Item;

struct no{
	Item item;
	struct no *left;
	struct no *right;
};

typedef struct no No;

No *inicializa(){
	return NULL;
}

No *insere(No *raiz, Item x);
void imprime(No *raiz);
void liberaNo(No *raiz);
Item itemCreate(int cod);

Item itemCreate(int cod){
	Item item;
	item.cod = cod;
	return item;
}

No *insere(No *raiz, Item x){
	if(raiz == NULL){
		No *aux = (No*)malloc(sizeof(No));
		aux->item = x;
		aux->left = NULL;
		aux->right = NULL;
		return aux;
	}
	else{
		if(x.cod > raiz->item.cod){
			raiz->right = insere(raiz->right, x);
		}
		else if(x.cod < raiz->item.cod){
			raiz->left = insere(raiz->left, x);
		}
	}
	return raiz;
}

void imprime(No *raiz){
	if(raiz != NULL){
		printf("%d\n", raiz->item.cod);
		imprime(raiz->left);
		imprime(raiz->right);
	}
}

void liberaNo(No *raiz){
	if(raiz != NULL){
		liberaNo(raiz->left);
		liberaNo(raiz->right);
		free(raiz);
	}
}
int main(){
	No *raiz = inicializa();
	raiz = insere(raiz, itemCreate(10));
	int x, escolha;
	 do{
            printf("---------Menu---------");
            printf("\n\t1. Insere");
            printf("\n\t2. Remove");
            printf("\n\t3. Imprime");
            printf("\n\t4. Sair");
            printf("\n\tDigite sua escolha: ");
            scanf("%d", &escolha);
            switch(escolha){
            case 1:
				printf("Dado: ");
				scanf("%d", &x);
                insere(raiz, itemCreate(x));
                break;
            case 2:
                break;
            case 3:
                imprime(raiz);
                break;
            case 4:
                exit(0);
                break;
            default:
                printf("Opção inválida");
                break;
            }
    }while(escolha != EOF);
	
	liberaNo(raiz);
	return 0;
}
