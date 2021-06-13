#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int *randomVector(int *vet, int tam);
void merge(int *v, int inicio, int meio, int fim);
void mergeSort(int *v, int inicio, int fim);
void quickSort(int *v, int inicio, int fim);
int partVector(int *v, int inicio, int fim);

int main(){
	int *vetor, tam, inicioVetor, fimVetor, escolha;
	printf("\t Qual o tamanho do vetor de ordenação? ");
	scanf("%d", &tam);
	vetor = (int*) malloc(tam * sizeof(int));
	inicioVetor = 0;
	fimVetor = tam - 1;
	do{
		printf("\n\t1.Merge Sort");
		printf("\n\t2.Quick Sort");
		printf("\n\t3.Sair");
		printf("\n\t--Digite sua escolha: ");
		scanf("%d", &escolha);
		switch(escolha){
			case 1:
			vetor = randomVector(vetor, tam);
			printf("\n----Merge Sort----");
			printf("\n----Vetor antes da ordenação----\n");
			for(int j = 0; j<tam; j++){
			printf("%d ", vetor[j]);}
			mergeSort(vetor, inicioVetor, fimVetor);
			printf("\n----Vetor depois da ordenação----\n");
			for(int i = 0; i<tam; i++){
			printf("%d ", vetor[i]);}
			printf("\n");
			break;
			case 2:
			vetor = randomVector(vetor, tam);
			printf("\n----Quick Sort----");
			printf("\n----Vetor antes da ordenação----\n");
			for(int j = 0; j<tam; j++){
			printf("%d ", vetor[j]);}
			quickSort(vetor, inicioVetor, fimVetor);
			printf("\n----Vetor depois da ordenação----\n");
			for(int i = 0; i<tam; i++){
			printf("%d ", vetor[i]);}
			printf("\n");
			break;
			case 3:
			free(vetor);
			exit(0);
			break;
			}
		}while(escolha != EOF);
}

int *randomVector(int *vet, int tam){
	int i;
	srand(time(NULL));
	for(i = 0; i < tam; i++){
        vet[i] = rand() % 100;
    }
    return vet;
}

void merge(int *v, int inicio, int meio, int fim){
    int *aux, tam, f = 0, f2 = 0, i, k , j, v1 = inicio, v2 = meio + 1;
	tam = (fim-inicio) + 1;
	aux = (int*)malloc(tam * sizeof(int));
    for(i = 0; i < tam; i++){
        if(!f && !f2){
            if(v[v1]<v[v2]){
                aux[i] = v[v1++];
            }
            else{
                aux[i] = v[v2++];
            }
            if(v1>meio){
                f = 1;
            }
            if(v2>fim){
                f2 = 1;
            }
        }
        else{
            if(!f){
                aux[i] = v[v1++];
            }
            else{
                aux[i] = v[v2++];
            }
        }
    }
    for(j = 0, k = inicio; j < tam; j++, k++){
        v[k] = aux[j];
    }
    free(aux);
}


void mergeSort(int *v, int inicio, int fim){
    int meio;
    if(inicio<fim){
        meio = (int)((inicio+fim)/2);

        mergeSort(v, inicio, meio);
        mergeSort(v, meio+1, fim);
        merge(v, inicio, meio, fim);
    }
}

void quickSort(int *v, int inicio, int fim){
    int pivo;
    if(fim > inicio){
        pivo = partVector(v, inicio, fim);
        quickSort(v, inicio, pivo-1);
        quickSort(v, pivo+1, fim); 
    }
}

int partVector(int *v, int inicio, int fim){
    int esq, dir, pivo, *aux, tam;
    tam = (fim-inicio) + 1;
	aux = (int*)malloc(tam * sizeof(int));
    esq = inicio; 
    dir = fim;   
    pivo = v[inicio]; 
    while(esq < dir){
        while(v[esq] <= pivo) esq++;

        while(v[dir] > pivo) dir--; 

        if(esq < dir){ 
            *aux = (v[esq]);
            v[esq] = v[dir];
            v[dir] = *aux;
        }
    }

    v[inicio] = v[dir];
    v[dir] = pivo;
    free(aux);
    return dir; 
}
