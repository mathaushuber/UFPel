#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int somador=1;

typedef struct cadastro{
	char nome[20];
	int idade;
	int registro;
	struct cadastro *prox;
}cadastro;

void listar(cadastro *ini);
void apagaRegistro(cadastro *ini);
void insere(cadastro *p);
cadastro *cria(void);
cadastro *apagaLista(cadastro *ini);
void apagaNome(cadastro * ini);

int main(){
	int escolha;
	cadastro *ini;
	cadastro *apaga_registro;
	ini=cria();

	do{
        printf("---------Menu---------");
        printf("\n\t .1 Inserir");
        printf("\n\t .2 Apagar pelo nome");
        printf("\n\t .3 Apagar pelo registro");
        printf("\n\t .4 Apagar lista");
        printf("\n\t .5 Imprimir lista");
        printf("\n\t .6 Sair");
        printf("\n\t Digite sua escolha: ");
        scanf("%d", &escolha);
        switch(escolha){
            case 1:
                insere(ini);
                break;
            case 2:
				apagaNome(ini);
                break;
            case 3:
				apagaRegistro(ini);
                break;
            case 4:
				if((apaga_registro = apagaLista(ini))){
                free(apaga_registro);}
			    break;
            case 5:
				listar(ini);
			    break;
			case 6:
                exit(0);
                break;
			default:
                printf("Opção inválida");
                break;			}
		}while(escolha != EOF);
	free(ini);
	return 0;
}
cadastro *cria(void)
{
	cadastro *start;
	start = (cadastro *) malloc(sizeof(cadastro));
	start->prox = NULL;
	return start;
}
void insere(cadastro * p)
{
	cadastro *nova;
	nova = (cadastro *) malloc(sizeof(cadastro));
	nova->registro=somador;
    printf("Nome do paciente: ");
    getchar();
    fgets(nova->nome,20,stdin);
	printf("Idade do paciente: ");
	scanf("%d", &nova->idade);
	nova->prox = p->prox;
	p->prox = nova;
	somador++;
}

void apagaNome(cadastro * ini){
cadastro *atual, *ant, *morto;
	atual = ini->prox;
	ant = ini->prox;
	char comp[20];
	printf("Qual nome você deseja excluir? ");
	getchar();
	fgets(comp, 20, stdin);
	while(atual!=NULL){
		if(atual == ini->prox && strcmp(atual->nome, comp) == 0){
			ini->prox=atual->prox;
			morto=atual;
			atual=atual->prox;
			}
		else if(strcmp(atual->nome,comp)==0){
				ant->prox= atual->prox;
				morto=atual;
				atual=atual->prox;
	}
		else{
			ant=atual;
			atual=atual->prox;
			}
			free(morto);
	}
}	

void apagaRegistro(cadastro *ini){
	cadastro *atual, *ant, *morto;
	atual = ini->prox;
	ant = ini->prox;
    int x;
    printf("Qual registro deseja apagar? ");
	scanf("%d", &x);
	while(atual!=NULL){
		if(atual== ini->prox && atual->registro==x){
			ini->prox=atual->prox;
			morto=atual;
			atual=atual->prox;
			}
		else if(atual->registro == x){
				ant->prox= atual->prox;
				morto=atual;
				atual=atual->prox;
	}
		else{
			ant=atual;
			atual=atual->prox;
			}
			free(morto);
	}
}	
void listar(cadastro *ini){
		cadastro *aux;
		aux=ini->prox;
		if(aux==NULL)
			printf("LISTA VAZIA!!\n");
		while(aux!=NULL){
				printf("\nNome: %s", aux->nome);
				printf("Idade: %d\n", aux->idade);
				printf("Número de registro:  %d", aux->registro);
				printf("\n--------------------------------\n");
				aux=aux->prox;
			}
	}
	
cadastro *apagaLista(cadastro *ini){
    if(ini->prox == NULL){
        printf("LISTA VAZIA!");
    }
    cadastro *remove;
    while (ini->prox != NULL)
    {
        remove = ini->prox;
        ini->prox = remove->prox;
    }
    return remove;   
}
