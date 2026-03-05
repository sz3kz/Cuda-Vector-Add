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

  delete[] vector_A;
  delete[] vector_B;
  delete[] vector_C;

  return 0;
}
