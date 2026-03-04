#include "../../include/vector.h"

void vectorInitialize(int * vector, unsigned int length, unsigned int upper_limit ){
  for (int i = 0; i < length; i++){
    vector[i] = rand() % upper_limit;
  }
}
