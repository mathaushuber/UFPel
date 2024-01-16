#include <stdio.h>

unsigned long long fibIterativo(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    unsigned long long a = 0, b = 1, temp;

    for (int i = 2; i <= n; i++) {
        temp = a + b;
        a = b;
        b = temp;
    }

    return b;
}

int main() {
    int n;

    printf("Digite o valor de n para calcular Fibonacci: ");
    scanf("%d", &n);

    unsigned long long resultado = fibIterativo(n);

    printf("O termo Fibonacci de %d é: %llu\n", n, resultado);

    return 0;
}
