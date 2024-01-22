#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

typedef struct {
    int numero;
    char animal[20];
} Bilhete;

Bilhete gerarBilhete();
void imprimirBilhete(Bilhete bilhete);
int verificarGanhador(Bilhete bilheteSorteado, Bilhete bilheteApostado);

int main() {
    srand(time(NULL));

    printf("Bem-vindo ao Jogo do Bicho!\n");

    Bilhete bilheteSorteado = gerarBilhete();

    printf("O resultado sorteado foi:\n");
    imprimirBilhete(bilheteSorteado);

    Bilhete bilheteApostado;
    printf("\nDigite seu bilhete:\n");
    printf("Número (0000 a 9999): ");
    scanf("%d", &bilheteApostado.numero);
    printf("Animal (ex: Tigre): ");
    scanf("%s", bilheteApostado.animal);

    printf("\nSeu bilhete foi:\n");
    imprimirBilhete(bilheteApostado);

    if (verificarGanhador(bilheteSorteado, bilheteApostado)) {
        printf("\nParabéns! Você ganhou no Jogo do Bicho!\n");
    } else {
        printf("\nInfelizmente, você não ganhou. Tente novamente!\n");
    }

    return 0;
}

Bilhete gerarBilhete() {
    Bilhete bilhete;
    bilhete.numero = rand() % 10000;
    sprintf(bilhete.animal, "Animal%d", rand() % 10);
    return bilhete;
}

void imprimirBilhete(Bilhete bilhete) {
    printf("Número: %04d\tAnimal: %s\n", bilhete.numero, bilhete.animal);
}

int verificarGanhador(Bilhete bilheteSorteado, Bilhete bilheteApostado) {
    return (bilheteSorteado.numero == bilheteApostado.numero &&
            strcmp(bilheteSorteado.animal, bilheteApostado.animal) == 0);
}
