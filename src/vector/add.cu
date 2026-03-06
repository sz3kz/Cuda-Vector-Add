#include "../../include/vector.h"

__global__ void vector::add(int * destination, int * vector1, int * vector2, unsigned int length,
    unsigned int threads_per_block){
  int current_index = threadIdx.x + blockIdx.x * threads_per_block;
  if (current_index < length)
    destination[current_index] = vector1[current_index] + vector2[current_index];
}
