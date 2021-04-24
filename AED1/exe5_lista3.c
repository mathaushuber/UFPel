#include <stdio.h>
#include <stdlib.h>

int* insere(int *memoria, int tam);
void consulta(int *memoria, int tam);

int main(){
   int tam, *memory, escolha, i;
   printf("Digite o tamanho da memória a ser alocada: ");
   scanf("%d", &tam);
   memory = (int *)malloc(tam * sizeof(int));
   for(i = 0; i<tam;i++){
       memory[i] = 0;
   }
   do{
       printf("\n1. Insere valor");
       printf("\n2. Consulta valor");
       printf("\n3. Sair");
       printf("\n   Digite sua escolha: ");
       scanf("%d", &escolha);
       switch (escolha)
       {
       case 1:
       memory = insere(memory, tam);
       break;
       case 2:
       consulta(memory, tam);
       }
   }while(escolha != 3);

   free(memory);
   return 0;    
}

int* insere(int *memoria, int tam){
    int i, position, value;
       printf("Em qual posição você deseja inserir? ");
       scanf("%d", &position);
       if(position > tam){
           printf("\nVocê tentou inserir em uma posição da memória não autorizada. O programa abortou!");
           exit(1);
       }
       printf("Qual valor você deseja inserir? ");
       scanf("%d", &value);
        for(i = 0; i<tam; i++){
            if(i == position){
                memoria[i] = value;
            }
        }
        return memoria;
}

void consulta(int *memoria, int tam){
    int consultaPosition, i;
    printf("Posição a ser consultada: ");
    scanf("%d", &consultaPosition);
       for(i = 0; i<tam; i++){
            if(i == consultaPosition){
                printf("Posição: %d, valor: %d, Endereço %p", consultaPosition, memoria[i], &memoria[i]);
            }
        }
}
