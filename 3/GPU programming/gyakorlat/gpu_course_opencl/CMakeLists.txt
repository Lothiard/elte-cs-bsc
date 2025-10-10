# Set the minimum required version of CMake.
# Modern CMake features are used, so a recent version is recommended.
cmake_minimum_required(VERSION 3.16)

if(NOT CMAKE_TOOLCHAIN_FILE AND DEFINED ENV{VCPKG_ROOT})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
      CACHE STRING "Vcpkg toolchain file")
    message(STATUS "Using vcpkg toolchain from $ENV{VCPKG_ROOT}")
else()
    message(STATUS "ENV{VCPKG_ROOT} is not defined. Skipping using ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
endif()

include(cmake/bootstrap_vcpkg.cmake)

#==============================================================================
# USER-FACING OPTIONS
#==============================================================================
option(BUILD_WITH_OPENGL "Enable OpenGL rendering and visualization" OFF)

#==============================================================================
# CONDITIONALLY ENABLE VCPKG FEATURES
#==============================================================================
if(BUILD_WITH_OPENGL)
    # Tell vcpkg to install the 'opengl' feature from vcpkg.json
    set(VCPKG_MANIFEST_FEATURES "opengl" CACHE STRING "VCPKG features to install")
else()
    # Tell vcpkg to install no optional features (only core dependencies)
    set(VCPKG_MANIFEST_FEATURES "" CACHE STRING "VCPKG features to install")
endif()

# Define the project name, version, and language.
project(gpu_course_opencl VERSION 1.0 LANGUAGES CXX)

#==============================================================================
# COMPILE OPTIONS
#==============================================================================

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

#==============================================================================
# DEPENDENCIES
#==============================================================================
find_package(OpenCL CONFIG REQUIRED)

#==============================================================================
# Interfaces, Common libraries, etc.
#==============================================================================
include(cmake/OpenCLConfig.cmake)

if(BUILD_WITH_OPENGL)
    message(STATUS "OpenGL support is ENABLED.")
    include(cmake/OpenGLConfig.cmake)
    find_package(OpenGL REQUIRED)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(X11 REQUIRED x11)
else()
    message(STATUS "OpenGL support is DISABLED.")
endif()

#==============================================================================
# opencl-01-helloworld
#==============================================================================
add_executable(opencl-01-helloworld src/main_01_helloworld.cpp)
target_link_libraries(opencl-01-helloworld PRIVATE OpenCLConfig)

#==============================================================================
# opencl-02-vectoradd
#==============================================================================
add_executable(opencl-02-vectoradd
  src/main_02_vectoradd.cpp
  kernels/krn_vectoradd.cl
)
target_link_libraries(opencl-02-vectoradd PRIVATE OpenCLConfig)

#==============================================================================
# opencl-03-reduce-global
#==============================================================================
add_executable(opencl-03-reduce-global
  src/main_03_reduce_global.cpp
  kernels/krn_reduce_global.cl
)
target_link_libraries(opencl-03-reduce-global PRIVATE OpenCLConfig)

#==============================================================================
# opencl-04-reduce-local
#==============================================================================
add_executable(opencl-04-reduce-local
  src/main_04_reduce_local.cpp
  kernels/krn_reduce_local.cl
  kernels/krn_reduce_global.cl
)
target_link_libraries(opencl-04-reduce-local PRIVATE OpenCLConfig)

#==============================================================================
# opencl-opengl interoperation projects
#==============================================================================
if(BUILD_WITH_OPENGL)

    #============================================================================
    # opencl-05-hello-opengl
    #============================================================================
    add_executable(opencl-05-hello-opengl src/main_05_hello_opengl.cpp)
    target_include_directories(opencl-05-hello-opengl PRIVATE ${X11_INCLUDE_DIRS})
    target_link_libraries(opencl-05-hello-opengl PRIVATE OpenCLConfig OpenGLConfig OpenGL::GL ${X11_LIBRARIES})

    #============================================================================
    # opencl_06_opengl_nbody
    #============================================================================
    add_subdirectory(src/opencl_06_opengl_nbody)

    # Ensure opencl-06-opengl-nbody links OpenGL and X11 and finds headers
    set_target_properties(opencl-06-opengl-nbody PROPERTIES
    INCLUDE_DIRECTORIES "${X11_INCLUDE_DIRS}"
  )
    target_link_libraries(opencl-06-opengl-nbody PRIVATE OpenCLConfig OpenGL::GL ${X11_LIBRARIES})
    target_include_directories(opencl-06-opengl-nbody PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src/opencl_06_opengl_nbody/common)

endif()

#==============================================================================
# opencl-07-scan
#==============================================================================
add_executable(opencl-07-scan
  src/main_07_scan.cpp
  kernels/krn_scan.cl
)
target_link_libraries(opencl-07-scan PRIVATE OpenCLConfig)
