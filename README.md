# Cuda Vector Add
A simple Vector Addition program written utilizing the CUDA parallel computing platform.

## Requirements
* a C++ compiler
* CUDA developer environment
* GNU make
* Cmake

## How 2 Use
```bash
# Clone the repository
git clone git@github.com:sz3kz/Cuda-Vector-Add.git
cd Cuda-Vector-Add/

# Activate CMake configuration custom git submodule
make dotfiles-activate

# Build the project
mkdir build
cd build/
cmake ..
make
```
Execute with:
```bash
# Execute (user assumed to be in build/ directory)
./compute
```

## Kernel Profiling
Profiling of the kernel based on block and thread count used was done using the [Nsight Compute CLI Profiler](https://developer.nvidia.com/nsight-compute). Since I was unable to make the profiler run on my host system (NixOS), I resorted to running the profiler with the binary on google's NVIDIA GPUs through [Google Colab](https://colab.research.google.com/).

During profiling, the vector was of length:
```cpp
constexpr int VECTOR_LENGTH = 32*10000;
```

The profiler was run like so:
```bash
ncu --section SpeedOfLight --section MemoryWorkloadAnalysis ./compute
```

(We care mostly about `Duration` and `Memory Throughput [bytes/s]`)

<details>
  <summary>1 block x 1 thread</summary>
    
  ```bash
  add(int *, int *, int *, unsigned int) (1, 1, 1)x(1, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle   31,447,664
    Memory Throughput                 %         0.15
    DRAM Throughput                   %         0.06
    Duration                         ms        53.76
    L1/TEX Cache Throughput           %         6.11
    L2 Cache Throughput               %         0.05
    SM Active Cycles              cycle   786,061.28
    Compute (SM) Throughput           %         0.15
    ----------------------- ----------- ------------

    OPT   This kernel grid is too small to fill the available resources on this device, resulting in only 0.0 full      
          waves across all SMs. Look at Launch Statistics for more details.                                             

    Section: Memory Workload Analysis
    ----------------- ----------- ------------
    Metric Name       Metric Unit Metric Value
    ----------------- ----------- ------------
    Memory Throughput     Mbyte/s       193.09
    Mem Busy                    %         0.08
    Max Bandwidth               %         0.15
    L1/TEX Hit Rate             %        90.62
    L2 Hit Rate                 %        79.00
    Mem Pipes Busy              %         0.15
    ----------------- ----------- ------------
  ```

</details>

<details>
  <summary>1 block x 1024 threads</summary>
    
  ```bash
  add(int *, int *, int *, unsigned int) (1, 1, 1)x(1024, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         4.87
    SM Frequency                    Mhz       584.80
    Elapsed Cycles                cycle      128,061
    Memory Throughput                 %         6.73
    DRAM Throughput                   %         6.73
    Duration                         us       218.98
    L1/TEX Cache Throughput           %        64.62
    L2 Cache Throughput               %         2.07
    SM Active Cycles              cycle     3,095.05
    Compute (SM) Throughput           %         1.20
    ----------------------- ----------- ------------

    OPT   This kernel grid is too small to fill the available resources on this device, resulting in only 0.0 full      
          waves across all SMs. Look at Launch Statistics for more details.                                             

    Section: Memory Workload Analysis
    ----------------- ----------- ------------
    Metric Name       Metric Unit Metric Value
    ----------------- ----------- ------------
    Memory Throughput     Gbyte/s        21.00
    Mem Busy                    %         2.07
    Max Bandwidth               %         6.73
    L1/TEX Hit Rate             %            0
    L2 Hit Rate                 %        35.36
    Mem Pipes Busy              %         1.20
    ----------------- ----------- ------------
  ```

</details>

<details>
  <summary>160 blocks x 1024 threads</summary>
    
  ```bash
  add(int *, int *, int *, unsigned int) (160, 1, 1)x(1024, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         4.43
    SM Frequency                    Mhz       582.16
    Elapsed Cycles                cycle        9,994
    Memory Throughput                 %        72.19
    DRAM Throughput                   %        72.19
    Duration                         us        17.15
    L1/TEX Cache Throughput           %        29.83
    L2 Cache Throughput               %        26.02
    SM Active Cycles              cycle     6,816.57
    Compute (SM) Throughput           %        20.06
    ----------------------- ----------- ------------

    OPT   Memory is more heavily utilized than Compute: Look at the Memory Workload Analysis section to identify the    
          DRAM bottleneck. Check memory replay (coalescing) metrics to make sure you're efficiently utilizing the       
          bytes transferred. Also consider whether it is possible to do more work per memory access (kernel fusion) or  
          whether there are values you can (re)compute.                                                                 

    Section: Memory Workload Analysis
    ----------------- ----------- ------------
    Metric Name       Metric Unit Metric Value
    ----------------- ----------- ------------
    Memory Throughput     Gbyte/s       204.80
    Mem Busy                    %        26.02
    Max Bandwidth               %        72.19
    L1/TEX Hit Rate             %            0
    L2 Hit Rate                 %        34.09
    Mem Pipes Busy              %        20.06
    ----------------- ----------- ------------
  ```

</details>

Conclusion: When the total amount of threads increased (either via direct threads per block increase or indirect total block amount increase):
* kernel's `Duration` goes down - resulting in faster execution
* `Memory Throughput [byte/s]` goes up - signifying a better utilization of the GPU by the kernel

This experiment has shown that having more threads is advantageous in a kernel program, as it allows for better performance of the program overall.
The reason this is [Operation Latency Hiding](https://modal.com/gpu-glossary/perf/latency-hiding).
