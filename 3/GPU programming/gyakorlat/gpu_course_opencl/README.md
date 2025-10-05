# gpu-course-opencl
OpenCL material for GPU course

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

### Option C
In order to generate build scripts for OpenGL-based (CL-GL interoperation) projects, used the `BUILD_WITH_OPENGL=ON` option. E.g.:
```bash
cmake .. -DBUILD_WITH_OPENGL=ON
```
or
```bash
cmake .. -DBUILD_WITH_OPENGL=ON -DCMAKE_TOOLCHAIN_FILE="C:/vcpkg/scripts/buildsystems/vcpkg.cmake" -G "Visual Studio 17 2022"
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

#### Linux dependencies of OpenGL based projects

Glew and SDL2 (installed through vcpkg) depend on the following packages:

```bash
sudo apt-get update
sudo apt-get install -y libxmu-dev libxi-dev libgl-dev
sudo apt-get install -y libltdl-dev
```

## Optional
- VCPKG (in this case, use the CMAKE_TOOLCHAIN_FILE switch)