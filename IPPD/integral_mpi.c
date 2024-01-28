#include <stdio.h>
#include <mpi.h>

// Função para a qual queremos calcular a integral
double funcao(double x) {
    return x * x;
}

// Função para calcular a integral definida de 'a' a 'b' com 'n' subintervalos
double calcular_integral(double a, double b, int n, int rank, int size) {
    double h = (b - a) / n;
    double integral_local = 0.0;

    // Cada processo calcula uma parte da integral
    for (int i = rank; i < n; i += size) {
        double x_i = a + i * h;
        double area_trapezio = (funcao(x_i) + funcao(x_i + h)) * h / 2.0;
        integral_local += area_trapezio;
    }

    return integral_local;
}

int main(int argc, char *argv[]) {
    double a = 0.0;
    double b = 1.0;
    int n = 1000000; 
    int rank, size;
    double resultado_local, resultado_global;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Cada processo calcula a sua parte da integral
    double inicio = MPI_Wtime();
    resultado_local = calcular_integral(a, b, n, rank, size);

    // Cada processo envia seu resultado local para o processo 0
    MPI_Reduce(&resultado_local, &resultado_global, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    double fim = MPI_Wtime();

    if (rank == 0) {
        printf("Resultado da integral: %f\n", resultado_global);
        printf("Tempo de execução: %f segundos\n", fim - inicio);
    }

    MPI_Finalize();

    return 0;
}
