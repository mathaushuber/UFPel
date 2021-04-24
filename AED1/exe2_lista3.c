#include <stdio.h>
#include <stdlib.h>

int main(){
    int i, j;
    float mat[3][3];
        for(i = 0; i < 3; i++){
            for(j = 0; j < 3; j++){
                printf("Elemento %d%d: ", i,j);
                scanf("%f", &(mat[i][j]));
            }
        }

        for(i = 0; i < 3; i++){
            for(j = 0; j < 3; j++){
                printf("%p ", mat[i][j]);
            }
            printf("\n");
        }

}