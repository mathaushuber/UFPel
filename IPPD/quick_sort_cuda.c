#include <stdio.h>

#define SIZE 1000000
#define THREADS_PER_BLOCK 256

__device__ void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

__device__ int partition(int arr[], int low, int high) {
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

__global__ void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);

        if (high - low > THREADS_PER_BLOCK) {
            quickSort<<<1, 1>>>(arr, low, pi - 1);
            quickSort<<<1, 1>>>(arr, pi + 1, high);
        } else {
            quickSort<<<1, high - low>>>(arr, low, pi - 1);
            quickSort<<<1, high - low>>>(arr, pi + 1, high);
        }
    }
}

int main() {
    int arr[SIZE];
    int *d_arr;

    for (int i = 0; i < SIZE; i++) {
        arr[i] = rand() % 1000;
    }

    // Aloca memória na GPU
    cudaMalloc((void **)&d_arr, SIZE * sizeof(int));

    // Copia os dados para a GPU
    cudaMemcpy(d_arr, arr, SIZE * sizeof(int), cudaMemcpyHostToDevice);

    // Chama o kernel de ordenação
    quickSort<<<1, 1>>>(d_arr, 0, SIZE - 1);

    // Copia os resultados de volta para a CPU
    cudaMemcpy(arr, d_arr, SIZE * sizeof(int), cudaMemcpyDeviceToHost);

    // Libera a memória na GPU
    cudaFree(d_arr);

    for (int i = 0; i < SIZE; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    return 0;
}
