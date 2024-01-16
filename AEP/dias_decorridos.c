#include <stdio.h>

// Função para verificar se um ano é bissexto
int ehBissexto(int ano) {
    return (ano % 4 == 0 && ano % 100 != 0) || (ano % 400 == 0);
}

// Função para calcular o número de dias decorridos entre duas datas
int calcularDiasDecorridos(int dia1, int mes1, int ano1, int dia2, int mes2, int ano2) {
    const int diasPorMes[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    // Verifica se o ano1 é bissexto e ajusta a quantidade de dias em fevereiro
    if (ehBissexto(ano1)) {
        diasPorMes[2] = 29;
    }

    int diasTotal1 = dia1;
    for (int i = 1; i < mes1; i++) {
        diasTotal1 += diasPorMes[i];
    }
    for (int i = 1950; i < ano1; i++) {
        diasTotal1 += ehBissexto(i) ? 366 : 365;
    }

    // Verifica se o ano2 é bissexto e ajusta a quantidade de dias em fevereiro
    if (ehBissexto(ano2)) {
        diasPorMes[2] = 29;
    }

    int diasTotal2 = dia2;
    for (int i = 1; i < mes2; i++) {
        diasTotal2 += diasPorMes[i];
    }
    for (int i = 1950; i < ano2; i++) {
        diasTotal2 += ehBissexto(i) ? 366 : 365;
    }

    return diasTotal2 - diasTotal1;
}

int main() {
    int dia1, mes1, ano1, dia2, mes2, ano2;

    // Solicita ao usuário as datas
    printf("Digite a data mais antiga (dia mes ano): ");
    scanf("%d %d %d", &dia1, &mes1, &ano1);

    printf("Digite a data mais recente (dia mes ano): ");
    scanf("%d %d %d", &dia2, &mes2, &ano2);

    // Calcula o número de dias decorridos e exibe o resultado
    int diasDecorridos = calcularDiasDecorridos(dia1, mes1, ano1, dia2, mes2, ano2);
    printf("O número de dias decorridos entre as datas é: %d dias\n", diasDecorridos);

    return 0;
}
