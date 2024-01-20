#include <stdio.h>
#include <stdlib.h>

typedef struct {
    char nome[50];
    double investimento;
} Participante;

typedef struct {
    Participante participante;
    int nivel;
    double ganho;
} Nivel;

void calcularGanhos(Participante *participantes, int numParticipantes, double fator, int niveis, Nivel *historico);

int main() {
    int numParticipantes, niveis;
    double investimentoInicial, fator;

    printf("Bem-vindo ao Jogo da Pirâmide!\n");

    printf("Digite o investimento inicial por participante: $");
    scanf("%lf", &investimentoInicial);

    printf("Digite o fator de multiplicação por nível: ");
    scanf("%lf", &fator);

    printf("Digite o número de participantes: ");
    scanf("%d", &numParticipantes);

    Participante *participantes = (Participante *)malloc(numParticipantes * sizeof(Participante));

    printf("\nRegistre os participantes:\n");
    for (int i = 0; i < numParticipantes; i++) {
        printf("Nome do participante %d: ", i + 1);
        scanf("%s", participantes[i].nome);
        participantes[i].investimento = investimentoInicial;
    }

    printf("\nDigite o número de níveis: ");
    scanf("%d", &niveis);

    Nivel *historico = (Nivel *)malloc(numParticipantes * niveis * sizeof(Nivel));

    calcularGanhos(participantes, numParticipantes, fator, niveis, historico);

    printf("\nResumo do jogo:\n");
    for (int i = 0; i < numParticipantes; i++) {
        printf("\nParticipante: %s\n", participantes[i].nome);
        for (int j = 0; j < niveis; j++) {
            printf("  Nível %d: $%.2f\n", historico[i * niveis + j].nivel, historico[i * niveis + j].ganho);
        }
    }

    free(participantes);
    free(historico);

    return 0;
}

void calcularGanhos(Participante *participantes, int numParticipantes, double fator, int niveis, Nivel *historico) {
    for (int i = 0; i < numParticipantes; i++) {
        for (int j = 0; j < niveis; j++) {
            historico[i * niveis + j].participante = participantes[i];
            historico[i * niveis + j].nivel = j + 1;
            historico[i * niveis + j].ganho = participantes[i].investimento * fator;
            participantes[i].investimento = historico[i * niveis + j].ganho;
        }
    }
}
