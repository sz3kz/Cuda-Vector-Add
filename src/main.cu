#include "../include/main.h"
#include "../include/vector.h"

int main(){
  srand(time(NULL));
  int * vector_A, * vector_B, * vector_C;

  vector_A = new int [VECTOR_LENGTH];
  vector_B = new int [VECTOR_LENGTH];
  vector_C = new int [VECTOR_LENGTH];

  vectorInitialize(vector_A, VECTOR_LENGTH, RAND_UPPER_LIMIT);
  vectorInitialize(vector_B, VECTOR_LENGTH, RAND_UPPER_LIMIT);
  vectorInitialize(vector_C, VECTOR_LENGTH, RAND_UPPER_LIMIT);

  for (int i = 0; i < VECTOR_LENGTH ; ++i)
    printf("%2d | %2d | %2d \n", vector_A[i], vector_B[i], vector_C[i]);

  return 0;
}
