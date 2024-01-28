#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define SIZE 1000000

void merge(int arr[], int l, int m, int r) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;
    int L[n1], R[n2];

    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int arr[], int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
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

    MPI_Scatter(arr, SIZE / local_size, MPI_INT, local_arr, SIZE / local_size, MPI_INT, 0, MPI_COMM_WORLD);

    mergeSort(local_arr, 0, SIZE / local_size - 1);

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
