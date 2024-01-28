#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define SIZE 1000000
#define THRESHOLD 10000

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);

    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);

        if (high - low > THRESHOLD) {
            #pragma omp parallel sections
            {
                #pragma omp section
                {
                    quickSort(arr, low, pi - 1);
                }
                #pragma omp section
                {
                    quickSort(arr, pi + 1, high);
                }
            }
        } else {
            quickSort(arr, low, pi - 1);
            quickSort(arr, pi + 1, high);
        }
    }
}

void parallelMerge(int arr[], int local_arr[], int local_size, int rank, int size) {
    int *temp_arr = NULL;
    int temp_size = local_size * 2;
    int temp_rank, temp_size_sum;

    while (temp_size <= SIZE) {
        temp_arr = (int *)realloc(temp_arr, temp_size * sizeof(int));
        if (rank % (temp_size / local_size) == 0) {
            MPI_Recv(temp_arr, temp_size, MPI_INT, rank + (temp_size / local_size), 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            merge(arr, 0, temp_size / 2 - 1, temp_size - 1);
            for (int i = 0; i < temp_size; i++)
                arr[i] = temp_arr[i];
        } else {
            temp_rank = rank - (temp_size / local_size);
            temp_size_sum = temp_size / 2;
            MPI_Send(local_arr, local_size, MPI_INT, temp_rank, 0, MPI_COMM_WORLD);
            MPI_Recv(local_arr, local_size, MPI_INT, temp_rank, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            merge(arr, 0, temp_size_sum - 1, temp_size - 1);
            for (int i = temp_size_sum; i < temp_size; i++)
                arr[i - temp_size_sum] = temp_arr[i];
        }
        temp_size *= 2;
    }

    free(temp_arr);
}

int main(int argc, char *argv[]) {
    int arr[SIZE];
    int local_size, local_rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &local_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &local_rank);

    int *local_arr = (int *)malloc((SIZE / local_size) * sizeof(int));

    if (local_rank == 0) {
        for (int i = 0; i < SIZE; i++) {
            arr[i] = rand() % 1000;
        }
    }

    // Distribui partes do array para todos os processos
    MPI_Scatter(arr, SIZE / local_size, MPI_INT, local_arr, SIZE / local_size, MPI_INT, 0, MPI_COMM_WORLD);

    // Cada processo ordena sua parte local
    quickSort(local_arr, 0, SIZE / local_size - 1);

    // Combina os resultados parciais em paralelo
    parallelMerge(arr, local_arr, SIZE / local_size, local_rank, local_size);

    if (local_rank == 0) {
        for (int i = 0; i < SIZE; i++) {
            printf("%d ", arr[i]);
        }
        printf("\n");
    }

    MPI_Finalize();

    free(local_arr);

    return 0;
}
