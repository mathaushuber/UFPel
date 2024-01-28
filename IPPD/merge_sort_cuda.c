#include <stdio.h>

#define SIZE 1000000
#define THREADS_PER_BLOCK 256

__device__ void merge(int arr[], int l, int m, int r) {
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

__global__ void mergeSort(int arr[], int n) {
    for (int curr_size = 1; curr_size <= n - 1; curr_size = 2 * curr_size) {
        for (int left_start = 0; left_start < n - 1; left_start += 2 * curr_size) {
            int mid = left_start + curr_size - 1;
            int right_end = min(left_start + 2 * curr_size - 1, n - 1);

            merge(arr, left_start, mid, right_end);
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
    mergeSort<<<1, 1>>>(d_arr, SIZE);

    cudaMemcpy(arr, d_arr, SIZE * sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(d_arr);

    for (int i = 0; i < SIZE; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    return 0;
}
