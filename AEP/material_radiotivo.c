#include <stdio.h>

void calcularTempoDecaimento(double massaInicial) {
    const double limiteMassa = 0.5;
    const double taxaDecaimento = 0.5;
    const int segundosPorMinuto = 60;
    const int minutosPorHora = 60;

    double massaAtual = massaInicial;
    int tempoSegundos = 0;

    while (massaAtual >= limiteMassa) {
        massaAtual *= taxaDecaimento;
        tempoSegundos += 50;
    }

    int horas = tempoSegundos / (segundosPorMinuto * minutosPorHora);
    int minutos = (tempoSegundos % (segundosPorMinuto * minutosPorHora)) / segundosPorMinuto;
    int segundos = tempoSegundos % segundosPorMinuto;

    printf("Massa inicial: %.2f gramas\n", massaInicial);
    printf("Massa final: %.2f gramas\n", massaAtual);
    printf("Tempo necessário: %d horas, %d minutos, %d segundos\n", horas, minutos, segundos);
}

int main() {
    double massaInicial;

    // Solicita ao usuário a massa inicial
    printf("Digite a massa inicial em gramas: ");
    scanf("%lf", &massaInicial);

    // Chama a função para calcular o tempo de decaimento
    calcularTempoDecaimento(massaInicial);

    return 0;
}
