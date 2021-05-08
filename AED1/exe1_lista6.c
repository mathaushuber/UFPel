#include <stdio.h>
#include <stdlib.h>

typedef struct item{
	int cod;
}Item;


typedef struct no {
	Item item;
	struct no *left;
	struct no *right;
}No;

No *insereElemento(No *raiz, Item x);
void imprimeArvore(No *raiz);
void liberaArvore(No *raiz);
Item criaItem(int cod);
No *removeElemento(No *raiz, int cod);
No *menorElemento(No *raiz);
No *inicializa();

int main(){
	No *raiz = inicializa();
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
                raiz = insereElemento(raiz, criaItem(x));
                break;
            case 2:
				printf("Dado a ser removido: ");
				scanf("%d", &x);
				raiz = removeElemento(raiz, x);
                break;
            case 3:
                imprimeArvore(raiz);
                break;
            case 4:
			    liberaArvore(raiz);	
                exit(0);
                break;
            default:
                printf("Opção inválida");
                break;
            }
    }while(escolha != EOF);
	
	liberaArvore(raiz);
	return 0;
}

No *inicializa(){
	return NULL;
}

Item criaItem(int cod){
	Item item;
	item.cod = cod;
	return item;
}

No *insereElemento(No *raiz, Item x){
	if(raiz == NULL){
		No *aux = (No*)malloc(sizeof(No));
		aux->item = x;
		aux->left = NULL;
		aux->right = NULL;
		return aux;
	}
	else{
		if(x.cod > raiz->item.cod){
			raiz->right = insereElemento(raiz->right, x);
		}
		else if(x.cod < raiz->item.cod){
			raiz->left = insereElemento(raiz->left, x);
		}
	}
	return raiz;
}

void imprimeArvore(No *raiz){
	if(raiz != NULL){
		printf("%d\n", raiz->item.cod);
		imprimeArvore(raiz->left);
		imprimeArvore(raiz->right);
	}
}

void liberaArvore(No *raiz){
	if(raiz != NULL){
		liberaArvore(raiz->left);
		liberaArvore(raiz->right);
		free(raiz);
	}
}

No *menorElemento(No *raiz){
	if(raiz != NULL){
		No *aux = raiz;
		while(aux->left != NULL){
			aux = aux->left;
		}
		return aux;
	}
	return NULL;
}


No *removeElemento(No *raiz, int cod){
	if(raiz != NULL){
		if(cod > raiz->item.cod){
			raiz->right = removeElemento(raiz->right, cod);
		}
		else if(cod < raiz->item.cod){
			raiz->left = removeElemento(raiz->left, cod);
		}
		else{
			if(raiz->left == NULL && raiz->right == NULL){
				free(raiz);
				return NULL;
			}else if(raiz->left == NULL && raiz->right != NULL){
				No *aux = raiz->right;
				free(raiz);
				return aux;
			}
			else if(raiz->left != NULL && raiz->right == NULL){
				No *aux = raiz->left;
				free(raiz);
				return aux;
			}else{
				No *aux = menorElemento(raiz->right);
				Item itemAux = aux->item;
				raiz = removeElemento(raiz, itemAux.cod);
				raiz->item = itemAux;
			}
		}
		return raiz;
	}	
		printf("\tElemento não encontrado\n");
		return NULL;
} 
