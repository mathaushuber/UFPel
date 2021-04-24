#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void compara(int *escolhaNum, int *aleatorio);
void loteria();

int main(){
    srand(time(NULL));
    loteria();
    return 0;
}

void loteria(){
    int i, *aleatorio, *escolhaNum;
    aleatorio = malloc(6 * sizeof(int));
    escolhaNum = malloc(6 * sizeof(int));
    for(i = 0; i < 6; i++){
        aleatorio[i] = rand() % 50;
    }
    for(i = 0; i < 6; i++){
        printf("%d ", aleatorio[i]);
    }
    printf("Escolha 6 números\n");
    for(i = 0; i < 6; i++){
        printf("Número %d: ", i+1);
        scanf("%d", &(escolhaNum[i]));
    }
    
    compara(escolhaNum, aleatorio);
    free(aleatorio);
    free(escolhaNum);
}


void compara(int *escolhaNum, int *aleatorio){
    int i, totalNum = 0, *numAcertos;
        for(i=0; i < 6; i++){
            if(escolhaNum[i] == aleatorio[i]){
                totalNum++;
            }
        }
  
    numAcertos = malloc(totalNum * sizeof(int));
        for(i=0; i < totalNum; i++){
            if(escolhaNum[i] == aleatorio[i]){
                numAcertos[i] = aleatorio[i];
            }
        }
    printf("Números da loteria: \n");
    for(i=0; i < 6; i++){
		printf("%d ", aleatorio[i]);
    }
    printf("\nValores escolhidos: \n");
    for(i=0; i < 6; i++){
		printf("%d ", escolhaNum[i]);
    }
    printf("\nEscolhas iguais: \n");
    for(i=0; i < 6; i++){
		printf("%d ", numAcertos[i]);
		if(numAcertos == NULL){
			printf("\nVocê não acertou nenhum número");
		}
    }
    printf("Número de acertos: %d", totalNum);
    
    free(numAcertos);
}
