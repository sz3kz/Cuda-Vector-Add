#include "../../include/vector.h"

int * vector::initialize(unsigned int length, unsigned int upper_limit ){
  int * vector = new int [length];
  for (int i = 0; i < length; i++){
    vector[i] = rand() % upper_limit;
  }
  return vector;
}
