#include <stdio.h>
#include <stdlib.h>

#define TILE_WIDTH 16  // Defines the size of each tile (submatrix)

// -----------------------------------------------------------------------------
// GPU Kernel: MatrixMulTiled
// Computes C = A × B using tiling and shared memory optimization.
// Each thread block computes one TILE_WIDTH × TILE_WIDTH submatrix of C.
// -----------------------------------------------------------------------------
__global__ void MatrixMulTiled(float *A, float *B, float *C, int width) {
    // Shared memory for storing tiles of A and B
    __shared__ float As[TILE_WIDTH][TILE_WIDTH];
    __shared__ float Bs[TILE_WIDTH][TILE_WIDTH];

    // Compute global row and column index of the element to compute
    int Row = blockIdx.y * TILE_WIDTH + threadIdx.y;
    int Col = blockIdx.x * TILE_WIDTH + threadIdx.x;

    // Accumulator for the final value of C[Row, Col]
    float value = 0.0f;

    // Loop over all tiles of A and B needed to compute one tile of C
    for (int t = 0; t < (width + TILE_WIDTH - 1) / TILE_WIDTH; ++t) {

        // ---------------------------------------------------------------------
        // Load one tile of A and one tile of B into shared memory.
        // Each thread loads one element from A and one from B.
        // Check for boundaries to avoid illegal memory access.
        // ---------------------------------------------------------------------
        if (Row < width && (t * TILE_WIDTH + threadIdx.x) < width)
            As[threadIdx.y][threadIdx.x] = A[Row * width + t * TILE_WIDTH + threadIdx.x];
        else
            As[threadIdx.y][threadIdx.x] = 0.0f;  // Pad with zero outside valid range

        if (Col < width && (t * TILE_WIDTH + threadIdx.y) < width)
            Bs[threadIdx.y][threadIdx.x] = B[(t * TILE_WIDTH + threadIdx.y) * width + Col];
        else
            Bs[threadIdx.y][threadIdx.x] = 0.0f;  // Pad with zero outside valid range

        // Synchronize all threads in the block before using shared memory
        __syncthreads();

        // ---------------------------------------------------------------------
        // Perform partial computation for the tile of C.
        // Each thread computes one element of C's tile by multiplying
        // corresponding elements of the shared tiles As and Bs.
        // ---------------------------------------------------------------------
        for (int k = 0; k < TILE_WIDTH; ++k)
            value += As[threadIdx.y][k] * Bs[k][threadIdx.x];

        // Synchronize again before loading next tile
        __syncthreads();
    }

    // -------------------------------------------------------------------------
    // Write the computed value to the output matrix (if within bounds)
    // -------------------------------------------------------------------------
    if (Row < width && Col < width)
        C[Row * width + Col] = value;
}

// -----------------------------------------------------------------------------
// Host Code: main()
// Allocates matrices, initializes them, runs the kernel, and verifies output.
// -----------------------------------------------------------------------------
int main() {
    int width = 512;                  // Matrix dimension (width x width)
    size_t size = width * width * sizeof(float);  // Memory size in bytes

    // -------------------------------------------------------------------------
    // Allocate memory on host (CPU)
    // -------------------------------------------------------------------------
    float *h_A = (float *)malloc(size);
    float *h_B = (float *)malloc(size);
    float *h_C = (float *)malloc(size);

    // Initialize input matrices with random values
    for (int i = 0; i < width * width; ++i) {
        h_A[i] = rand() / (float)RAND_MAX;
        h_B[i] = rand() / (float)RAND_MAX;
    }

    // -------------------------------------------------------------------------
    // Allocate memory on device (GPU)
    // -------------------------------------------------------------------------
    float *d_A, *d_B, *d_C;
    cudaMalloc((void **)&d_A, size);
    cudaMalloc((void **)&d_B, size);
    cudaMalloc((void **)&d_C, size);

    // -------------------------------------------------------------------------
    // Copy input matrices from host to device
    // -------------------------------------------------------------------------
    cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);

    // -------------------------------------------------------------------------
    // Define CUDA grid and block dimensions
    // - Each block handles TILE_WIDTH × TILE_WIDTH elements of C
    // - The grid dimensions cover the entire output matrix
    // -------------------------------------------------------------------------
    dim3 dimBlock(TILE_WIDTH, TILE_WIDTH, 1);
    dim3 dimGrid((width + TILE_WIDTH - 1) / TILE_WIDTH,
                 (width + TILE_WIDTH - 1) / TILE_WIDTH, 1);

    // -------------------------------------------------------------------------
    // Launch the kernel on the GPU
    // -------------------------------------------------------------------------
    MatrixMulTiled<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, width);

    // Wait for GPU to finish before accessing results
    cudaDeviceSynchronize();

    // -------------------------------------------------------------------------
    // Copy result matrix C back to host
    // -------------------------------------------------------------------------
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);

    // -------------------------------------------------------------------------
    // Print sample elements from result for verification
    // -------------------------------------------------------------------------
    printf("Sample output:\n");
    printf("C[0] = %f\n", h_C[0]);
    printf("C[last] = %f\n", h_C[width * width - 1]);

    // -------------------------------------------------------------------------
    // Free device and host memory
    // -------------------------------------------------------------------------
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(h_A);
    free(h_B);
    free(h_C);

    return 0;
}
