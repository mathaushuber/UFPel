#include <stdio.h>

#define N 1000000

__device__ double funcao(double x) {
    return x * x;
}

__global__ void calcular_integral(double a, double b, int n, double *resultado) {
    int tid = blockIdx.x * blockDim.x + threadIdx.x;

    if (tid < n) {
        double h = (b - a) / n;
        double x_i = a + tid * h;
        resultado[tid] = (funcao(x_i) + funcao(x_i + h)) * h / 2.0;
    }
}

int main() {
    double a = 0.0;
    double b = 1.0;
    double *d_resultado;
    double resultado_final[N];

    // Aloca memória na GPU
    cudaMalloc((void **)&d_resultado, N * sizeof(double));

    // Chama o kernel com um bloco e threads por bloco
    calcular_integral<<<1, N>>>(a, b, N, d_resultado);

    // Copia os resultados de volta para a CPU
    cudaMemcpy(resultado_final, d_resultado, N * sizeof(double), cudaMemcpyDeviceToHost);

    // Libera a memória na GPU
    cudaFree(d_resultado);

    // Soma os resultados para obter o resultado final da integral
    double resultado_integral = 0.0;
    for (int i = 0; i < N; i++) {
        resultado_integral += resultado_final[i];
    }

    printf("Resultado da integral: %f\n", resultado_integral);

    return 0;
}
