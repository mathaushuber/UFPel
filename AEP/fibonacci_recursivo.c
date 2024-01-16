#include <stdio.h>

unsigned long long fibRecursivo(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;

    return fibRecursivo(n - 1) + fibRecursivo(n - 2);
}

int main() {
    int n;

    printf("Digite o valor de n para calcular Fibonacci: ");
    scanf("%d", &n);

    unsigned long long resultado = fibRecursivo(n);

    printf("O termo Fibonacci de %d é: %llu\n", n, resultado);

    return 0;
}
