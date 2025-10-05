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

#if(NOT CMAKE_TOOLCHAIN_FILE) # Optional: Only run if a toolchain isn't already specified externally
include(cmake/bootstrap_vcpkg.cmake)
#message(STATUS "Using cmake/bootstrap_vcpkg.cmake bootstrap script for locally installing vcpkg.")
#else()
#message(STATUS "CMAKE_TOOLCHAIN_FILE is already set to: ${CMAKE_TOOLCHAIN_FILE}. Skipping vcpkg bootstrap script.")
#endif()

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

# CXX_STANDARD_REQUIRED ensures that if the compiler doesn't support C++17,
# CMake will produce an error.
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # Discourage compiler-specific extensions

#==============================================================================
# DEPENDENCIES
#==============================================================================
# Find required external libraries.

find_package(OpenCL CONFIG REQUIRED)

#==============================================================================
# Interfaces, Common libraries, etc.
#==============================================================================

# Add the interface definition for OpenCL projects
include(cmake/OpenCLConfig.cmake)

if(BUILD_WITH_OPENGL)
    message(STATUS "OpenGL support is ENABLED.")

    # Add the interface definition for OpenGL projects
    include(cmake/OpenGLConfig.cmake)
else()
    message(STATUS "OpenGL support is DISABLED.")
    # No find_package calls = VCPKG doesn't install the feature.
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
  src/main_02_vectoradd.cpp # this is a compilation unit
  kernels/krn_vectoradd.cl  # this is a mere text file, not to be compiled
)
target_link_libraries(opencl-02-vectoradd PRIVATE OpenCLConfig)

#==============================================================================
# opencl-03-reduce-global
#==============================================================================

add_executable(opencl-03-reduce-global
  src/main_03_reduce_global.cpp # this is a compilation unit
  kernels/krn_reduce_global.cl  # this is a mere text file, not to be compiled
)
target_link_libraries(opencl-03-reduce-global PRIVATE OpenCLConfig)

#==============================================================================
# opencl-04-reduce-local
#==============================================================================

add_executable(opencl-04-reduce-local
  src/main_04_reduce_local.cpp
  kernels/krn_reduce_local.cl
)
target_link_libraries(opencl-04-reduce-local PRIVATE OpenCLConfig)

#==============================================================================
# opencl-opengl interoperation projects
#==============================================================================
if(BUILD_WITH_OPENGL)

    #============================================================================
    # opencl-05-hello-opengl
    #============================================================================

    # Find OpenGL and X11 libraries
    find_package(OpenGL REQUIRED)
    find_package(X11 REQUIRED)

    # If GLEW is used, find it too
    find_package(GLEW REQUIRED)

    add_executable(opencl-05-hello-opengl src/main_05_hello_opengl.cpp)

    target_link_libraries(opencl-05-hello-opengl PRIVATE
        OpenCLConfig
        OpenGLConfig
        OpenGL::GL
        GLEW::GLEW
        ${X11_LIBRARIES}
    )

endif()
