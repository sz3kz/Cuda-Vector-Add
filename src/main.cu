#include "../include/main.h"
#include "../include/vector.h"
#include "../include/interractive.h"

int main(){
  srand(time(NULL));
  int * vector_A, * vector_B, * vector_C;

  vector_A = vectorInitialize(VECTOR_LENGTH, RAND_UPPER_LIMIT);
  vector_B = vectorInitialize(VECTOR_LENGTH, RAND_UPPER_LIMIT);
  vector_C = new int [VECTOR_LENGTH] ();

  vectorPrint("Vector A", vector_A, VECTOR_LENGTH, calculateWidth(RAND_UPPER_LIMIT));
  vectorPrint("Vector B", vector_B, VECTOR_LENGTH, calculateWidth(RAND_UPPER_LIMIT));
  vectorPrint("Vector C", vector_C, VECTOR_LENGTH, calculateWidth(RAND_UPPER_LIMIT));

  int * vector_gpu_A, * vector_gpu_B, * vector_gpu_C;

  cudaMalloc(&vector_gpu_A, sizeof(int) * VECTOR_LENGTH);
  cudaMalloc(&vector_gpu_B, sizeof(int) * VECTOR_LENGTH);
  cudaMalloc(&vector_gpu_C, sizeof(int) * VECTOR_LENGTH);

  cudaMemcpy(vector_gpu_A, vector_A, sizeof(int) * VECTOR_LENGTH, cudaMemcpyHostToDevice);
  cudaMemcpy(vector_gpu_B, vector_B, sizeof(int) * VECTOR_LENGTH, cudaMemcpyHostToDevice);
  cudaMemcpy(vector_gpu_C, vector_C, sizeof(int) * VECTOR_LENGTH, cudaMemcpyHostToDevice);

  vectorAdd<<<(VECTOR_LENGTH + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK,THREADS_PER_BLOCK>>>(
      vector_gpu_C, vector_gpu_A, vector_gpu_B, VECTOR_LENGTH, THREADS_PER_BLOCK);

  cudaMemcpy(vector_C, vector_gpu_C, sizeof(int) * VECTOR_LENGTH, cudaMemcpyDeviceToHost);

  vectorPrint("Vector C", vector_C, VECTOR_LENGTH, calculateWidth(RAND_UPPER_LIMIT));

  delete[] vector_A;
  delete[] vector_B;
  delete[] vector_C;

  cudaFree(vector_gpu_A);
  cudaFree(vector_gpu_B);
  cudaFree(vector_gpu_C);

  return 0;
}
