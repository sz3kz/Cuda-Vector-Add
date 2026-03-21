#include "../../include/vector.h"

__global__ void vector::add(int * destination, int * vector1, int * vector2, unsigned int length){
  // threadIdx.x+blockIdx.x*blockDim.x - the global index of the current thread
  // if the computed index is >= vector's length, the index is invalid, cut the loop
  // blockDim.x*gridDim.x - computed number of all threads, this should be added
  //  to compute the next index of the thread (in order to not collide with other
  //  threads)
  for (int i = threadIdx.x + blockIdx.x * blockDim.x; // get the thread's index
      i < length;                                     // invalidate bad indexes
      i += blockDim.x * gridDim.x){                  // move by amount of threads
    destination[i] = vector1[i] + vector2[i];
    //printf("(%d|%d) vector[%d] = %d\n",blockIdx.x,threadIdx.x, i, destination[i]);
  }
}
