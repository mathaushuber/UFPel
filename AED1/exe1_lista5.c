/*	Mathaus Corrêa Huber -- 16201045 -- Ciência da Computação
 * 	A fila foi implementada com o conceito “First-in, First-out”, ou “Primeiro a entrar, Primeiro a sair”. Usando este conceito
 *  a função "insereFila", insere pessoas sempre no fim da fila, e a função "apagaNome", apaga pessoas sempre do início da fila
 * 	dessa forma o primeiro a entrar na fila vai ser sempre o primeiro a sair. 
 * */
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct NO{
	char pessoa[20];
	struct NO *prox;
}NO;

typedef struct FILA{
	NO *ini;
	NO *fim;
}FILA;

void insereFila(FILA *f);
void apagaFila(FILA *f);
void imprimeFila(FILA *f);
void iniciaFila(FILA *f);
void apagaNome(FILA *f);

int main(){
	int escolha;
	FILA *f1 = (FILA*)malloc(sizeof(FILA));
	iniciaFila(f1);
	if(f1 == NULL){
		printf("Erro de alocação");
		exit(-1);
		}
	 do{
            printf("---------Menu---------");
            printf("\n\t1. Insere pessoa");
            printf("\n\t2. Deleta pessoa");
            printf("\n\t3. Imprime fila");
            printf("\n\t4. Limpa fila");
            printf("\n\t5. Sair");
            printf("\n\tDigite sua escolha: ");
            scanf("%d", &escolha);
            switch(escolha){
            case 1:
                insereFila(f1);
                break;
            case 2:
                apagaNome(f1);
                break;
            case 3:
                imprimeFila(f1);
                break;
            case 4:
                apagaFila(f1);
                break;
            case 5:
                exit(0);
                break;
            default:
                printf("Opção inválida");
                break;
            }
    }while(escolha != EOF);
    free(f1);
	return 0;
}

void iniciaFila(FILA *f){
	f->ini = NULL;
	f->fim = NULL;
}

void insereFila(FILA *f){
	NO *ptr = (NO*) malloc(sizeof(NO));
	char dado[20];
	printf("Nome da pessoa: ");
	scanf("%s^[\n]", dado);
	if(ptr == NULL){
		printf("Erro de alocação\n");
		return;
	}else{
		strcpy(ptr->pessoa, dado);
		ptr->prox = NULL;
		if(f->ini == NULL){
			f->ini = ptr;
		}else{
			f->fim->prox = ptr;
			}
		
		f->fim = ptr;
	}
	
}

void apagaFila(FILA *f){
	NO *remove;
		if(f->ini == NULL){
			printf("Fila vazia!\n");
			}
	while(f->ini != NULL){
		remove = f->ini;
		f->ini = f->ini->prox;
		free(remove);
		}
	printf("Fila removida!\n");
}

void imprimeFila(FILA *f){
	NO *ptr = f->ini;
	if(ptr!= NULL){
		while(ptr != NULL){
			printf("%s\n", ptr->pessoa);
			ptr = ptr->prox; 
			}
	}else{
		printf("Fila vazia!\n");
		return;
		}
}

void apagaNome(FILA *f){
	NO *ptr = f->ini;
	char dado[20];
	if(ptr != NULL){
		f->ini = ptr->prox;
		ptr->prox = NULL;
		strcpy(dado, ptr->pessoa);
		free(ptr);
		if(f->ini == NULL){
			f->fim = NULL;
			}
		printf("Pessoa removida do início!\n");
	}else{
		printf("Fila vazia!\n");
	}
}
