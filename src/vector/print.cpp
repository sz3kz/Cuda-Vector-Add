#include "../../include/vector.h"

void vector::print(const char * prompt, int * vector, unsigned int length, unsigned int width){
  printf("%s: ", prompt);
  for (int i = 0; i < length; ++i)
    printf("%*d ", width, vector[i]);
  printf("\n");
}
