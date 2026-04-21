#include "../../include/vector.h"

int * vector::initialize(unsigned int length, unsigned int upper_limit ){
  int * vector = new int [length];
  for (unsigned int i = 0; i < length; i++){
    vector[i] = static_cast<int>(static_cast<unsigned int>(rand()) % upper_limit);
  }
  return vector;
}
