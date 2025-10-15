# Find dependencies
find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
find_package(SDL2 REQUIRED)

# Create an interface library to propagate include dirs and libraries
add_library(OpenGLConfig INTERFACE)

# Include directories
target_include_directories(OpenGLConfig INTERFACE
    ${OPENGL_INCLUDE_DIR}
    ${GLEW_INCLUDE_DIRS}
    ${SDL2_INCLUDE_DIRS}
)

# Libraries
target_link_libraries(OpenGLConfig INTERFACE
    ${OPENGL_gl_LIBRARY}
    ${GLEW_LIBRARIES}
    ${SDL2_LIBRARIES}
)