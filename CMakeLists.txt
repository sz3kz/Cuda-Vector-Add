cmake_minimum_required(VERSION 3.15...4.1)

project(Cuda-Vector-Add
  VERSION 1.0
  DESCRIPTION "Vector addition program utilizing CUDA parallel computing platform."
  LANGUAGES CXX CUDA)

file(GLOB SOURCES
    include/*.h
    src/main.cu
    src/*/*.cu
)

add_executable(cuda-vector-add ${SOURCES})
