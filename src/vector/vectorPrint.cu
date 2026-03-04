#include "../../include/vector.h"

void vectorPrint(const char * prompt, int * vector, unsigned int length){
  printf("%s: ", prompt);
  for (int i = 0; i < length; ++i)
    printf("%d ", vector[i]);
  printf("\n");
}
