#include <stdio.h>
#include <mpi.h>

int fibonacci(int n) {
    if (n <= 1)
        return n;
    else
        return fibonacci(n - 1) + fibonacci(n - 2);
}

int main(int argc, char *argv[]) {
    int rank, size;
    int n = 10; 
    int resultado_local, resultado_final;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Cada processo calcula uma parte da sequência
    int local_start = rank * (n / size);
    int local_end = (rank + 1) * (n / size) - 1;

    if (rank == size - 1)
        local_end += n % size;

    // Cálculo local
    resultado_local = 0;
    for (int i = local_start; i <= local_end; i++) {
        resultado_local += fibonacci(i);
    }

    // Redução para obter o resultado final
    MPI_Reduce(&resultado_local, &resultado_final, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        printf("Resultado final: %d\n", resultado_final);
    }

    MPI_Finalize();

    return 0;
}
