#include <stdio.h>
#include <stdlib.h>

void preenche(int *vetor, int *value);

int main(){
    int valor, *vet;
    printf("Digite o valor a ser preenchido: ");
    scanf("%d", &valor);
    vet = malloc(valor * sizeof(int));
    preenche(vet, &valor);
    
    free(vet);
    return 0;
}

void preenche(int *vetor, int *value){
    int i;
    for(i = 0; i < *value; i++){
		printf("Elemento %d: ", i);
        scanf("%d", &(*(vetor + i)));
    }
    for(i = 0; i < *value; i++){
        printf("%d", *(vetor + i));
    }
}
