# Cuda Vector Add
A simple Vector Addition program written utilizing the CUDA parallel computing platform.

## Requirements
* a C++ compiler
* CUDA developer environment
* GNU make
* Cmake

## How to use
```bash
git clone git@github.com:sz3kz/Cuda-Vector-Add.git
cd Cuda-Vector-Add
nix-shell # for NixOS, other linux distros should have the necessary software be available for the repository
mkdir build && cd build/
cmake ..
make
./cuda-vector-add
```
