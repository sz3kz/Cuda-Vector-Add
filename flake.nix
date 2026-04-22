{
  description = "Simple Vector Addition in CUDA";

  # Define dependencies (like the unstable version of nix packages)
  inputs = {          
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Supported: Linux Intel / AMD, Linux ARM, MacOS Intel, Apple Silicon MacOS
      supportedArchitectures = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ]; 

      forAllSystems = nixpkgs.lib.genAttrs supportedArchitectures;

      nixpkgsFor = forAllSystems (system: import nixpkgs { 
        inherit system; 
        config.allowUnfree = true; 
      });
      
    in
    {
      devShells = forAllSystems (system:
        let 
          pkgs = nixpkgsFor.${system}; 
        in {
          default = nixpkgsFor.${system}.mkShell {
            buildInputs = with nixpkgsFor.${system}; [
              clang
              gnumake
              cmake

              cudaPackages.cuda_nvcc      # fetch compiler
              cudaPackages.cuda_cudart    # runtime?
              cudaPackages.libcublas      # BLAS?
              cudaPackages.cuda_cccl      # C++ libraries
              cudaPackages.nsight_compute # profiler
            ];
            shellHook = ''
              export CC=clang
              export CXX=clang++
              export CUDA_PATH=${pkgs.cudaPackages.cuda_nvcc}
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ 
                pkgs.cudaPackages.cuda_cudart 
                pkgs.linuxPackages.nvidia_x11 
              ]}:$LD_LIBRARY_PATH
              echo "CUDA Dev Environment Loaded"
            '';
          };
      });

      packages = forAllSystems (system: {
        default = nixpkgsFor.${system}.stdenv.mkDerivation {
          src = ./.;
        };
      });
    };
}
