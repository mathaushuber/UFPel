#include <stdio.h>
#include <stdlib.h>

int main(){
    int x = 5;
    float y = 5.5;
    char z = 'M';
    int *pX = &x;
    float *pY = &y;
    char *pZ = &z;

    printf("\n Variáveis antes da modificação: x = %d, y = %f, z = %c", *pX, *pY, *pZ);
    modificaPonteiro(pX, pY, pZ);
    return 0;    
}

void modificaPonteiro(int *pX, float *pY, char *pZ){
    printf("\nModifique você mesmo o valor da variável");
    printf("\nInteiro:");
    scanf("%d", &(*pX));
    printf("Real:");
    scanf("%f", &(*pY));
    printf("Caracter:");
    getchar();
    scanf("%c", &(*pZ));
    printf("\nVariáveis depois da modificação: x = %d, y = %f, z = %c", *pX, *pY, *pZ);
}