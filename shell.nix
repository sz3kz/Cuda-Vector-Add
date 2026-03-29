{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

(pkgs.buildFHSEnv {
  name = "My-Cuda-Environment";

  targetPkgs = pkgs: with pkgs; [ 
    # C++
    clang
    gnumake
    cmake
    valgrind

    # CUDA Packages
    cudaPackages.cuda_nvcc
    cudaPackages.cuda_cudart
    cudaPackages.libcublas
    cudaPackages.cuda_cccl # C++ Core Compute Libraries
    cudaPackages.nsight_compute
  ];

  runScript = "bash";
  profile = ''
    export CUDA_PATH=${pkgs.cudatoolkit}
    # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib
    export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
    export EXTRA_CCFLAGS="-I/usr/include"
  '';
}).env
