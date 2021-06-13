#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void insertionSort(int *vet, int tam);
void selectionSort(int *vet, int tam);
int *randomVector(int *vet, int tam);

int main(){
	int *vetor, escolha, tam = 0;
	printf("\t Qual o tamanho do vetor de ordenação? ");
	scanf("%d", &tam);
	vetor = (int*) malloc(tam * sizeof(int));
	do{
		printf("\n\t1.Insertion Sort");
		printf("\n\t2.Seletion Sort");
		printf("\n\t3.Sair");
		printf("\n\t--Digite sua escolha: ");
		scanf("%d", &escolha);
		switch(escolha){
			case 1:
			vetor = randomVector(vetor, tam);
			insertionSort(vetor, tam);
			break;
			case 2:
			vetor = randomVector(vetor, tam);
			selectionSort(vetor, tam);
			break;
			case 3:
			free(vetor);
			exit(0);
			break;
			}
		}while(escolha != EOF);
	return 0;
}

int *randomVector(int *vet, int tam){
	int i;
	srand(time(NULL));
	for(i = 0; i < tam; i++){
        vet[i] = rand() % 100;
    }
    return vet;
}

void insertionSort(int *vet, int tam){
	int i, j, aux;
	//imprimindo antes da ordenação
	printf("----Vetor antes da ordenação----\n");
	for (i = 0; i < tam; i++){
		printf("%d ", vet[i]);
	}
	
	for (i = 0; i < tam; i++){
		aux = vet[i];
		for(j = i - 1; j >= 0 && vet[j] > aux; j--){
			vet[j+1] = vet[j];
		}	
		vet[j+1] = aux;
	}
	
	//imprimindo depois da ordenação
	printf("\n----Vetor depois da ordenação----\n");
	for (i = 0; i < tam; i++){
		printf("%d ", vet[i]);
	}
}
	
void selectionSort(int *vet, int tam){
	int aux, menor, i, j;
	//imprimindo antes da ordenação
	printf("----Vetor antes da ordenação----\n");
	for (i = 0; i < tam; i++){
		printf("%d ", vet[i]);
	}
	
	for (i = 0; i < tam-1; i++){
		menor = i;
		for (j = i+1; j<tam; j++){
			if(vet[menor] > vet[j]){
				menor = j;
			}
		}
		if(i != menor){
			aux = vet[i];
			vet[i] = vet[menor];
			vet[menor] = aux;
		}
	}
	
	//imprimindo depois da ordenação
	printf("\n----Vetor depois da ordenação----\n");
	for (i = 0; i < tam; i++){
		printf("%d ", vet[i]);
	}
}

