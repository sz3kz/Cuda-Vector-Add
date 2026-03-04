#include "../include/main.h"
#include "../include/hello-world.h"

int main(){
  helloWorld<<<2,3>>>();
  cudaDeviceSynchronize();
  return 0;
}
