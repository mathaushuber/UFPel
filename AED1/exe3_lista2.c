/*  Mathaus Corrêa Huber - Ciência da Computação - 16201045
    Faça uma agenda capaz de incluir, apagar, buscar e listar quantas pessoas o usuário desejar, porém, 
    toda a informação incluída na agenda deve ficar num único lugar chamado: “void *pBuffer” */
    
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Agenda Pessoa;

struct Agenda{
	char nome[10];
	int idade;
	int telefone;
};

void *pBuffer;

void dimensiona(int **p, int **q, int **r, int **s, int **t);
void insere();
void busca();
void apaga();
void imprime();

int main()
{
	int *p, *q, *r, *s, *t;
    pBuffer=malloc(sizeof(int)*5+sizeof(Pessoa));
	dimensiona(&p,&q,&r,&s,&t);
	*p=0;
	*q=0;
	*r=0;

        do{
            printf("---------Menu---------");
            printf("\n\t1. Inserir");
            printf("\n\t2. Apagar");
            printf("\n\t3. Buscar");
            printf("\n\t4. Listar");
            printf("\n\t5. Sair");
            printf("\n\tDigite sua escolha: ");
            scanf("%d", s);
            switch(*s){
            case 1:
                insere();
                dimensiona(&p,&q,&r,&s,&t);
                pBuffer=pBuffer;
                break;
            case 2:
                apaga();
                *q=(*r+1)*sizeof(Pessoa)+5*sizeof(int);
                pBuffer=realloc(pBuffer,*q);
                break;
            case 3:
                busca();
                pBuffer=pBuffer;
                break;
            case 4:
                imprime();
                printf("Total de pessoas: %d\n", *r);
                pBuffer=pBuffer;
                break;
            case 5:
                exit(0);
                break;
            default:
                printf("Opção inválida");
                break;
            }
        }while(*s != EOF);

    free(pBuffer);
    return 0;
}

void dimensiona(int **p, int **q, int **r, int **s, int **t)
{
	*p=pBuffer+0; //variável auxiliar
	*q=pBuffer+sizeof(int); //tamanho do buffer
	*r=pBuffer+2*sizeof(int); //quantidade de pessoas na agenda
	*s=pBuffer+3*sizeof(int);//variável de índice para laços de repetição
	*t=pBuffer+4*sizeof(int);//começo dos dados na agenda
}

void insere()
{
    int *q=pBuffer+sizeof(int), *r=pBuffer+2*sizeof(int);
    Pessoa *pessoa=pBuffer+sizeof(int)*5;
    pessoa=pessoa+*r;

	printf("Digite o nome: ");
	getchar();
    fgets(pessoa->nome, 30, stdin);
	printf("Digite a idade: ");
	scanf("%d", &(pessoa->idade));
	printf("Digite a telefone: ");
	scanf("%d", &(pessoa->telefone));

    *r=*r+1;
    *q=(*r+1)*sizeof(Pessoa)+5*sizeof(int);
    pBuffer=realloc(pBuffer,*q);
}

void apaga()
{
	int *i=pBuffer+3*sizeof(int), *r=pBuffer+2*sizeof(int);
	Pessoa *pessoa=pBuffer+5;
	Pessoa *alguem=pessoa+*r;
	printf("Digite o nome: ");
	getchar();
	fgets(alguem->nome, 30, stdin);
	for (*i=0; *i<=*r; (*i)++)
	{
		pessoa=pBuffer+5*sizeof(int);
		if (*i == *r)
			printf("Não há ninguém com este nome.\n");
		else
        {
			pessoa=pessoa+*i;
			if (strcmp(alguem->nome,pessoa->nome) == 0)
			{
				pessoa->telefone=999;
				printf("Excluído com sucesso!\n");
				*r=*r-1;
				return;
			}
        }
	}
}

void busca()
{
	int *i=pBuffer+3*sizeof(int), *r=pBuffer+2*sizeof(int);
	Pessoa *pessoa=pBuffer+5;
	Pessoa *alguem=pessoa+*r;
	printf("Digite o nome: ");
	getchar();
	fgets(alguem->nome, 30, stdin);
	for (*i=0; *i<=*r; (*i)++)
	{
		pessoa=pBuffer+5*sizeof(int);
		if (*i == *r)
			printf("Não há ninguém com este nome.\n");
		else
        {
            pessoa=pessoa+*i;
			if (strcmp(alguem->nome,pessoa->nome) == 0)
			{
                printf("%s", pessoa->nome);
                printf("Idade: %d\n Telefone: %d\n", pessoa->idade, pessoa->telefone);
				return;
			}
        }
	}
}

void imprime()
{
	int *i=pBuffer+3*sizeof(int), *r=pBuffer+2*sizeof(int);
	Pessoa *pessoa;
	for (*i=0; *i<=*r; (*i)++)
	{
		pessoa=pBuffer+5*sizeof(int);
		if (*i == *r)
			break;
		else
		{
			pessoa=pessoa+*i;
			printf("Nome: %s", pessoa->nome);
			printf("Idade: %d\n", pessoa->idade);
            printf("Telefone: %d\n\n",  pessoa->telefone);
		}
	}
}