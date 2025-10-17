cmake_minimum_required(VERSION 3.18)
project(TestCUDA LANGUAGES CUDA)

# Set the CUDA standard (optional)
set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

add_executable(test test.cu)

