# project name:         Cuda-Vector-Add
# languages used:       CXX CUDA
#   * CXX
#   * CUDA
# package version:      1.0
# c++ standard:         17
#   * 17
# executable target:    compute
# header directory:     include
# list of source files: <SRC_FILES>

cmake_minimum_required(VERSION 3.15...4.1)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/external/dotfiles/CPP")
include(add_cpp_compile_options)
include(add_cuda_compile_options)
include(add_clang_tidy_options)

project(
  Cuda-Vector-Add
  VERSION 1.0
  LANGUAGES CXX CUDA
)

add_executable(compute)

add_cpp_compile_options(compute)
add_cuda_compile_options(compute)
add_clang_tidy_options(compute)
include(CTest)
if(BUILD_TESTING)
endif()

target_include_directories(compute PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_sources(compute PRIVATE
  src/main.cu
  src/interractive/calculateWidth.cpp
  src/vector/add.cu
  src/vector/initialize.cpp
  src/vector/print.cpp
)
