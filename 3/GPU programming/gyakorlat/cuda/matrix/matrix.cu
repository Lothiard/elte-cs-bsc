#include <stdio.h>
#include <stdlib.h>

// CUDA kernel for matrix multiplication
__global__ void MatrixMulKernel(float *A, float *B, float *C, int width) {
    int Row = blockIdx.y * blockDim.y + threadIdx.y;
    int Col = blockIdx.x * blockDim.x + threadIdx.x;

    if (Row < width && Col < width) {
        float value = 0;
        for (int k = 0; k < width; ++k)
            value += A[Row * width + k] * B[k * width + Col];
        C[Row * width + Col] = value;
    }
}

int main() {
    int width = 512;  // matrix dimension (width x width)
    size_t size = width * width * sizeof(float);

    // Allocate host memory
    float *h_A = (float *)malloc(size);
    float *h_B = (float *)malloc(size);
    float *h_C = (float *)malloc(size);

    // Initialize matrices A and B
    for (int i = 0; i < width * width; ++i) {
        h_A[i] = rand() / (float)RAND_MAX;
        h_B[i] = rand() / (float)RAND_MAX;
    }

    // Allocate device memory
    float *d_A, *d_B, *d_C;
    cudaMalloc((void **)&d_A, size);
    cudaMalloc((void **)&d_B, size);
    cudaMalloc((void **)&d_C, size);

    // Copy matrices A and B to device
    cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

    // Define block and grid dimensions
    int BLOCK_SIZE = 16;
    dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE);
    dim3 dimGrid((width + BLOCK_SIZE - 1) / BLOCK_SIZE,
                 (width + BLOCK_SIZE - 1) / BLOCK_SIZE);

    // Launch kernel
    MatrixMulKernel<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, width);

    // Copy result back to host
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

    // (Optional) Verify result by printing a few values
    printf("C[0] = %f\n", h_C[0]);
    printf("C[last] = %f\n", h_C[width * width - 1]);

    // Free device memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    // Free host memory
    free(h_A);
    free(h_B);
    free(h_C);

    return 0;
}
