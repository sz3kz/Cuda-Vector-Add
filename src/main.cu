#include "../include/main.h"
#include "../include/hello-world.h"

int main(){
  int * vector_A, * vector_B, * vector_C;
  vector_A = new int [VECTOR_LENGTH];
  vector_B = new int [VECTOR_LENGTH];
  vector_C = new int [VECTOR_LENGTH];
  helloWorld<<<2,3>>>();
  cudaDeviceSynchronize();
  return 0;
}
