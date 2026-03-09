#include "../../include/vector.h"

__global__ void vector::add(int * destination, int * vector1, int * vector2, unsigned int length){
  int current_index = threadIdx.x + blockIdx.x * blockDim.x;
  if (current_index < length)
    destination[current_index] = vector1[current_index] + vector2[current_index];
}
