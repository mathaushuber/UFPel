#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

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

        // Chama a função recursivamente para ordenar as duas metades
        #pragma omp parallel sections
        {
            #pragma omp section
            {
                mergeSort(arr, l, m);
            }
            #pragma omp section
            {
                mergeSort(arr, m + 1, r);
            }
        }

        merge(arr, l, m, r);
    }
}

int main() {
    int arr[SIZE];

    for (int i = 0; i < SIZE; i++) {
        arr[i] = rand() % 1000;
    }

    double inicio = omp_get_wtime();

    mergeSort(arr, 0, SIZE - 1);

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
