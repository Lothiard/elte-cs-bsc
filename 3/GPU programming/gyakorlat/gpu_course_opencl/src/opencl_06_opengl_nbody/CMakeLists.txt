# src/opencl-06-opengl-nbody/CMakeLists.txt

find_package(glm REQUIRED)
find_package(imgui CONFIG REQUIRED)
find_package(SDL3_image CONFIG REQUIRED)

# Collect sources for this subproject
set(NBODY_SOURCES
    main.cpp
    MyApp.cpp
)

set(NBODY_HEADERS
    MyApp.h
)

# Collect common sources/headers
file(GLOB NBODY_COMMON_SOURCES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/common/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/common/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/common/*.h"
)

# Define the executable
add_executable(opencl-06-opengl-nbody
    ${NBODY_SOURCES}
    ${NBODY_HEADERS}
    ${NBODY_COMMON_SOURCES}
)

target_include_directories(opencl-06-opengl-nbody
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/common
)

target_link_libraries(opencl-06-opengl-nbody
    PRIVATE
        OpenCLConfig
        OpenGLConfig
        imgui::imgui
		$<IF:$<TARGET_EXISTS:SDL3_image::SDL3_image-shared>,SDL3_image::SDL3_image-shared,SDL3_image::SDL3_image-static>
		glm::glm
)

target_compile_definitions(opencl-06-opengl-nbody
    PRIVATE
        GLM_ENABLE_EXPERIMENTAL
)

# Organize source files into IDE groups (Visual Studio, Xcode, etc.)
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR}/common PREFIX "common" FILES ${NBODY_COMMON_SOURCES})
#source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} PREFIX "src" FILES ${NBODY_SOURCES} ${NBODY_HEADERS})
