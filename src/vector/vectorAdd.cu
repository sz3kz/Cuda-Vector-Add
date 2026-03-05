#include "../../include/vector.h"

__global__ void vectorAdd(int * destination, int * vector1, int * vector2, 
    unsigned int threads_per_block){
  int current_index = threadIdx.x + blockIdx.x * threads_per_block;
  destination[current_index] = vector1[current_index] + vector2[current_index];
}
