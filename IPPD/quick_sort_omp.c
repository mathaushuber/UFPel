#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

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

        #pragma omp task shared(arr) if(high - low > THRESHOLD)
        {
            quickSort(arr, low, pi - 1);
        }
        #pragma omp task shared(arr) if(high - low > THRESHOLD)
        {
            quickSort(arr, pi + 1, high);
        }
    }
}

int main() {
    int arr[SIZE];
    
    for (int i = 0; i < SIZE; i++) {
        arr[i] = rand() % 1000;
    }

    double inicio = omp_get_wtime();

    // Chama a função de ordenação paralela
    #pragma omp parallel
    {
        #pragma omp single nowait
        {
            quickSort(arr, 0, SIZE - 1);
        }
    }

    double fim = omp_get_wtime();

    for (int i = 1; i < SIZE; i++) {
        if (arr[i - 1] > arr[i]) {
            printf("Erro de ordenação!\n");
            break;
        }
    }

    printf("Tempo de execução: %f segundos\n", fim - inicio);

    return 0;
}
