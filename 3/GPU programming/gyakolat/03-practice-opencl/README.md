# gpu-course-opencl
OpenCL material for GPU course

## Cloning the repository
```bash
git clone https://szofttech.inf.elte.hu/gpgpu/practice-opencl.git
```

## Generating build scripts and building

### Option A: Minimal steps for generating build scripts
```bash
mkdir build
cd build
cmake ..
```

### Option B: Steps using pre-deployed VCPKG (default usage at the CG Lab)
```bash
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE="C:/vcpkg/scripts/buildsystems/vcpkg.cmake" -G "Visual Studio 17 2022"
```

### Building
You may start the build from your favorite IDE, or use your favorite method, e.g. under Linux you may use `make`.

## Prerequisites

### Windows
- facilities for compiling C++ projects (e.g., Visual Studio Installer -> Desktop Development Environment for C++)
- CMAKE
- GIT for Windows
 
### Linux
- build-tools
- CMAKE
- git
 
## Optional
- VCPKG (in this case, use the CMAKE_TOOLCHAIN_FILE switch)