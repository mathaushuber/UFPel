#include <stdio.h>
#include <omp.h>

double funcao(double x) {
    return x * x;
}

// Função para calcular a integral definida de 'a' a 'b' com 'n' subintervalos
double calcular_integral(double a, double b, int n) {
    double h = (b - a) / n;
    double integral = 0.0;

    // Cada thread calculará uma parte da integral
    #pragma omp parallel for reduction(+:integral)
    for (int i = 0; i < n; i++) {
        double x_i = a + i * h;
        double area_trapezio = (funcao(x_i) + funcao(x_i + h)) * h / 2.0;
        integral += area_trapezio;
    }

    return integral;
}

int main() {
    double a = 0.0;
    double b = 1.0;
    int n = 1000000;

    double inicio = omp_get_wtime();
    double resultado = calcular_integral(a, b, n);
    double fim = omp_get_wtime();

    printf("Resultado da integral: %f\n", resultado);
    printf("Tempo de execução: %f segundos\n", fim - inicio);

    return 0;
}
