/*  Mathaus Corrêa Huber -- Ciência da Computação -- 16201045
---------------------------------------------------------------------------------------------------------------------------
	Faça um programa que armazena nomes. O programa deve armazenar todos os nomes na mesma string. O tamanho da string deve 
	crescer e diminuir conforme nomes forem colocados ou removidos. Não pode ter desperdício de memória.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void adicionar(char *string);
void remover(char *string);
void listar(char *string);

int main(){
	
	int escolha=0;
	char *string;
	string = malloc(1);
	if(string != NULL){

		do{

			printf("Menu:\n");
			printf("1. Adicionar\n");
			printf("2. Apagar\n");
			printf("3. Listar\n");
			printf("4. Sair\n");
			scanf("%d", &escolha);
			switch(escolha){
				case 1:
				adicionar(string);
				break;
				case 2:
				remover(string);
				break;
				case 3:
				listar(string);
				break;
				case 4:
                exit(0);
				break;
                default:
                printf("Opção inválida");
                break;
			}
		}while(escolha != EOF);
	}
	else
		printf("Nao foi possível alocar a lista.\n");
	free(string);
	return 0;
}

void adicionar(char *string){
	char name[20];
	printf("Digite um nome:");
	scanf("%s",name);
	string = realloc(string,strlen(name));
	strcat(string,name);
}

void remover(char *string){
	char name[20];
	int flag=1;
	printf("Digite um nome:");
	scanf("%s",name);
	for(int i=0; string[i]!='\0';i++){
		if(string[i] == name [0]){
			for(int j=0; j<strlen(name); j++){
				if(string[i+j] != name [j])
					flag=0;
			}
		string[i] = string[i+strlen(name)];	
		}
	}
}

void listar(char *string){
	for(int i=0; string[i]!='\0';i++){
		printf("%c", string[i]);
	}
	printf("\n\n");
}