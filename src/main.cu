#include "../include/main.h"
#include "../include/vector.h"

int main(){
  srand(time(NULL));
  int * vector_A, * vector_B, * vector_C;

  vector_A = new int [VECTOR_LENGTH];
  vector_B = new int [VECTOR_LENGTH];
  vector_C = new int [VECTOR_LENGTH] {0};

  vectorInitialize(vector_A, VECTOR_LENGTH, RAND_UPPER_LIMIT);
  vectorInitialize(vector_B, VECTOR_LENGTH, RAND_UPPER_LIMIT);

  vectorPrint("Vector A", vector_A, VECTOR_LENGTH);
  vectorPrint("Vector B", vector_B, VECTOR_LENGTH);
  vectorPrint("Vector C", vector_C, VECTOR_LENGTH);

  int * vector_gpu_A, * vector_gpu_B, * vector_gpu_C;

  cudaMalloc(&vector_gpu_A, sizeof(int) * VECTOR_LENGTH);
  cudaMalloc(&vector_gpu_B, sizeof(int) * VECTOR_LENGTH);
  cudaMalloc(&vector_gpu_C, sizeof(int) * VECTOR_LENGTH);

  cudaMemcpy(vector_gpu_A, vector_A, sizeof(int) * VECTOR_LENGTH, cudaMemcpyHostToDevice);
  cudaMemcpy(vector_gpu_B, vector_B, sizeof(int) * VECTOR_LENGTH, cudaMemcpyHostToDevice);
  cudaMemcpy(vector_gpu_C, vector_C, sizeof(int) * VECTOR_LENGTH, cudaMemcpyHostToDevice);

  delete[] vector_A;
  delete[] vector_B;
  delete[] vector_C;

  cudaFree(vector_gpu_A);
  cudaFree(vector_gpu_B);
  cudaFree(vector_gpu_C);

  return 0;
}
