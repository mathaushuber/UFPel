//Exercício slide 21, aula 1 de algoritmos e estrutura de dados I

/*Faça um programa que armazena nomes.
O programa deve armazenar todos os nomes na
mesma string.
O tamanho da string deve crescer e diminuir conforme
nomes forem colocados ou removidos.

Faça o seguinte menu:
1) Adicionar nome
2) Remover nome
3) Listar
4) Sair */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char insere(char **vet);
char apaga(char **apaga);
int main(){
    int escolha;
    char *vetor;
    vetor = (char*) malloc(50 *sizeof(char));
    do{
        printf("\n\t 1. Insere");
        printf("\n\t 2. Apaga");
        printf("\n\t 3. Lista");
        printf("\n\t 4. Sair");
        printf("\n\t Digite sua escolha: ");
        scanf("%d", &escolha);
        switch(escolha){
            case 1:
            insere(&vetor);
            break;
            case 2:
            apaga(&vetor);
            break;
            case 3:
            printf("%s", vetor);
            break;
            case 4:
            exit(0);
            break;
        }
    }while(escolha != EOF);
    
    return 0;
}

char insere(char **vet){
	char *vet_aux;
	int tam_string;
	vet_aux = (char*) malloc(50 *sizeof(char));
	printf("Entre com o nome: ");
	scanf("%s", vet_aux);
	*vet = strcat(vet_aux, *vet);
    tam_string = strlen(*vet);
    *vet = (char*) realloc(*vet, tam_string * sizeof(char));
    return **vet;
}

char apaga(char **apaga){
	char *vet_aux;
	char *retorno;
	int tam_string, tam_string2, i, j;
	vet_aux = (char*) malloc(50 *sizeof(char));
	retorno = (char*) malloc(200 *sizeof(char));
	printf("\tEntre com o nome: ");
	scanf("%s", vet_aux);
	tam_string = strlen(*apaga);
	tam_string2 = strlen(vet_aux);
	if(strcmp(*apaga, vet_aux) == 0){
		for(i = 0; i < tam_string; i++){
			for(j = 0; j < tam_string2; j++){
				while(*apaga[i] != vet_aux[j]){
					strcpy(retorno, *apaga);
                    free(apaga);
				}
			}
		}
	}
	strcpy(*apaga, retorno);
	return **apaga;
}

					
			
			
