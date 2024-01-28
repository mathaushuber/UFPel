#include <stdio.h>

#define N 10

__global__ void fibonacci_kernel(int *result) {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;

    if (tid < N) {
        if (tid <= 1)
            result[tid] = tid;
        else
            result[tid] = result[tid - 1] + result[tid - 2];
    }
}

int main() {
    int result[N];
    int *d_result;

    // Aloca memória na GPU
    cudaMalloc((void **)&d_result, N * sizeof(int));

    // Chama o kernel com um bloco e threads por bloco
    fibonacci_kernel<<<1, N>>>(d_result);

    // Copia os resultados de volta para a CPU
    cudaMemcpy(result, d_result, N * sizeof(int), cudaMemcpyDeviceToHost);

    // Libera a memória na GPU
    cudaFree(d_result);

    // Imprime os resultados
    printf("Sequência de Fibonacci:\n");
    for (int i = 0; i < N; i++) {
        printf("%d ", result[i]);
    }
    printf("\n");

    return 0;
}
