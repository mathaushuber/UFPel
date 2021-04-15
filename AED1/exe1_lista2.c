/*  Mathaus Corrêa Huber - Ciência da Computação - 16201045
    Faça um programa que armazene a informação de várias pessoas. O programa só deve sair quando o usuário disser que não deseja mais 
    entrar com os dados de outra pessoa. Antes de sair o programa deve apresentar, de forma organizada, os dados de todas as pessoas.*/
    
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Pessoa;

struct Pessoa{
    char nome[30];
    int idade;
    int altura;
};

int count; 

void insere(struct Pessoa *p);
void listar(struct Pessoa *p);

int main(){
    int escolha;
    struct Pessoa p[100];
        do{
        printf("Você deseja incluir uma pessoa na agenda? Digite 0\n");
        printf("Para sair: Digite 1\n");
        scanf("%d", &escolha);
            if(escolha == 0){
                insere(p);
            }
        }while(escolha != 1);

    listar(p);
    return 0;
}

void insere(struct Pessoa *p){
	printf("Nome: ");
	scanf("%s", p[count].nome);
	printf("Idade: ");
	scanf("%d", &(p[count].idade));
    printf("Altura: ");
    scanf("%d", &(p[count].altura));
	count += 1;
}

void listar(struct Pessoa *p){
	
	if(count == 0){
		 printf("Agenda vazia! \n\n");
	}
	else{
		int x = 0;
		printf("--------AGENDA--------\n\n");
		while(x<count){
			printf("Nome: %s\n", p[x].nome);
            printf("Idade: %d\n", p[x].idade);
            printf("Altura: %d\n\n", p[x].altura);
			x++;
		}
	}
}
