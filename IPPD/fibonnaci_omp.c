#include <stdio.h>
#include <omp.h>

int fibonacci(int n) {
    if (n <= 1)
        return n;
    else
        return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int n = 10;
    int resultado_sequencial, resultado_paralelo;

    // Cálculo sequencial
    double inicio_sequencial = omp_get_wtime();
    resultado_sequencial = fibonacci(n);
    double fim_sequencial = omp_get_wtime();
    printf("Resultado sequencial: %d\n", resultado_sequencial);
    printf("Tempo sequencial: %f segundos\n", fim_sequencial - inicio_sequencial);

    // Cálculo paralelo com OpenMP
    double inicio_paralelo = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single nowait
        resultado_paralelo = fibonacci(n);
    }
    double fim_paralelo = omp_get_wtime();
    printf("Resultado paralelo: %d\n", resultado_paralelo);
    printf("Tempo paralelo: %f segundos\n", fim_paralelo - inicio_paralelo);

    return 0;
}
