#ifndef MY_VECTOR_H
#define MY_VECTOR_H

#include <iostream>
#include <cstdlib>
#include <ctime>

int * vectorInitialize(unsigned int length, unsigned int upper_limit );
void vectorPrint(const char * prompt, int * vector, unsigned int length, unsigned int width);
__global__ void vectorAdd(int * destination, int * vector1, int * vector2, unsigned int length, 
    unsigned int threads_per_block);

#endif
