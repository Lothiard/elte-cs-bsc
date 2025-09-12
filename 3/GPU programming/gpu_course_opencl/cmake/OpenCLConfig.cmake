# Define an interface target for OpenCL with C++ bindings
add_library(OpenCLConfig INTERFACE)

# Link against OpenCL libs and headers
target_link_libraries(OpenCLConfig INTERFACE
    OpenCL::OpenCL
    OpenCL::HeadersCpp
)

# Set compile definitions for all users of this interface
target_compile_definitions(OpenCLConfig INTERFACE
    CL_HPP_MINIMUM_OPENCL_VERSION=120
    CL_HPP_TARGET_OPENCL_VERSION=300
    CL_HPP_ENABLE_EXCEPTIONS
)

# Add project-local include directory (relative to the top-level source dir)
target_include_directories(OpenCLConfig INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)