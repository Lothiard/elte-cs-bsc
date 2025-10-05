#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

// Define this before including SDL.h to manage the main function yourself.
#define SDL_MAIN_HANDLED

#include <CL/opencl.hpp>
#include <GL/glew.h>
#include <SDL2/SDL.h>

#include <oglutils.hpp>

// Forward-declare our utility functions
SharedShader createShaderProgram(const char *vertexSource,
                                 const char *fragmentSource);

// GLSL Shader Sources
const char *vertexShaderSource = R"GLSL(
#version 330 core
layout (location = 0) in vec2 aPos;
layout (location = 1) in vec2 aTexCoords;
out vec2 TexCoords;
void main() {
    gl_Position = vec4(aPos, 0.0, 1.0);
    TexCoords = aTexCoords;
}
)GLSL";

const char *fragmentShaderSource = R"GLSL(
#version 330 core
in vec2 TexCoords;
out vec4 FragColor;
uniform sampler2D screenTexture;
void main() {
    FragColor = texture(screenTexture, TexCoords);
}
)GLSL";

// Animated OpenCL kernel
const char *kernelSource = R"CLC(
__kernel void fill_animated_texture(
    __write_only image2d_t output_texture,
    const float time
) {
    int x = get_global_id(0);
    int y = get_global_id(1);
    int2 coord = (int2)(x, y);

    float width = (float)get_image_width(output_texture);
    float height = (float)get_image_height(output_texture);

    // Normalize coordinates to the range [0.0, 1.0] for resolution-independent patterns
    float u = (float)x / width;
    float v = (float)y / height;

    // Create a time-varying "plasma" effect using multiple sine waves
    float val1 = sin(u * 10.0f + time * 2.0f);
    float val2 = sin(v * 10.0f + time * 3.0f);
    float val3 = sin((u + v) * 10.0f + time * 4.0f);

    // Combine and normalize the waves to get a final grayscale value
    float final_value = 0.5f + 0.5f * ((val1 + val2 + val3) / 3.0f);

    // Write the color to the texture
    write_imagef(output_texture, coord, (float4)(final_value, final_value, final_value, 1.0f));
}
)CLC";

// Main application logic is encapsulated in this function.
void runApp() {

  // 1. Initialization
  SdlManager sdlManager(SDL_INIT_VIDEO);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
  UniqueWindow window(SDL_CreateWindow(
      "Animated OpenCL + OpenGL", SDL_WINDOWPOS_CENTERED,
      SDL_WINDOWPOS_CENTERED, 800, 600, SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN));
  if (!window)
    throw std::runtime_error(std::string("SDL_CreateWindow failed: ") +
                             SDL_GetError());
  UniqueGlContext glContext(SDL_GL_CreateContext(window.get()));
  if (!glContext)
    throw std::runtime_error(std::string("SDL_GL_CreateContext failed: ") +
                             SDL_GetError());
  if (glewInit() != GLEW_OK)
    throw std::runtime_error("GLEW init failed");
  std::cout << "OpenGL Version: " << glGetString(GL_VERSION) << std::endl;

  // 2. OpenCL Context Setup
  cl::Context clContext;
  if (!oclCreateContextFromCurrentGLContext(clContext)) {
    throw std::runtime_error("Failed to create CL/GL shared context.");
  }

  auto devices = clContext.getInfo<CL_CONTEXT_DEVICES>();
  auto device = devices.front();
  std::cout << "OpenCL Device: " << device.getInfo<CL_DEVICE_NAME>()
            << std::endl;

  cl::CommandQueue queue(clContext, device);

  cl::Program program(clContext, kernelSource);
  if (program.build({device}) != CL_SUCCESS) {
    throw std::runtime_error(
        "OpenCL program build error:\n" +
        program.getBuildInfo<CL_PROGRAM_BUILD_LOG>(device));
  }

  cl::KernelFunctor<cl::ImageGL, float> kernel(program,
                                               "fill_animated_texture");

  // 3. OpenGL Object Setup
  auto shaderProgram =
      createShaderProgram(vertexShaderSource, fragmentShaderSource);

  float quadVertices[] = {-1.0f, 1.0f,  0.0f, 1.0f, -1.0f, -1.0f, 0.0f, 0.0f,
                          1.0f,  -1.0f, 1.0f, 0.0f, -1.0f, 1.0f,  0.0f, 1.0f,
                          1.0f,  -1.0f, 1.0f, 0.0f, 1.0f,  1.0f,  1.0f, 1.0f};

  auto quadVAO = makeVAO();
  auto quadVBO = makeVBO();
  glBindVertexArray(*quadVAO);
  glBindBuffer(GL_ARRAY_BUFFER, *quadVBO);
  glBufferData(GL_ARRAY_BUFFER, sizeof(quadVertices), &quadVertices,
               GL_STATIC_DRAW);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), (void *)0);
  glEnableVertexAttribArray(0);
  glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float),
                        (void *)(2 * sizeof(float)));
  glEnableVertexAttribArray(1);

  const int TEX_WIDTH = 1024, TEX_HEIGHT = 1024;
  auto glTexture = makeTexture();
  glBindTexture(GL_TEXTURE_2D, *glTexture);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA32F, TEX_WIDTH, TEX_HEIGHT, 0, GL_RGBA,
               GL_FLOAT, nullptr);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glBindTexture(GL_TEXTURE_2D, 0);

  // 4. OpenGL-CL Interop Object setup
  // Warning: keep "glTexture" alive as long as you need your cl::ImageGL
  // referencing it
  cl::ImageGL clImage(clContext, CL_MEM_WRITE_ONLY, GL_TEXTURE_2D, 0,
                      *glTexture);
  // cl::BufferGL for VBO-s

  // 5. Main Loop
  bool running = true;
  while (running) {
    SDL_Event event;
    while (SDL_PollEvent(&event))
      if (event.type == SDL_QUIT)
        running = false;

    // Get elapsed time in seconds.
    float time = SDL_GetTicks() / 1000.0f;

    // Acquire the OpenGL texture for OpenCL to write to.
    std::vector<cl::Memory> glObjs = {clImage};
    queue.enqueueAcquireGLObjects(&glObjs);

    // Set the kernel arguments for this frame and execute the kernel.
    kernel(cl::EnqueueArgs(queue, cl::NDRange(TEX_WIDTH, TEX_HEIGHT)), clImage,
           time);

    // Release the texture back to OpenGL.
    queue.enqueueReleaseGLObjects(&glObjs);
    queue.finish();

    // Render the result
    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    glUseProgram(*shaderProgram);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, *glTexture);
    glBindVertexArray(*quadVAO);
    glDrawArrays(GL_TRIANGLES, 0, 6);

    SDL_GL_SwapWindow(window.get());
  }
}

// The main entry point.
int main() {
  try {
    runApp();
  } catch (const cl::Error &e) {
    std::cerr << "OpenCL ERROR: " << e.what() << std::endl;
#ifdef _WIN32
    system("pause");
#endif
    return EXIT_FAILURE;
  } catch (const std::exception &e) {
    std::cerr << "FATAL ERROR: " << e.what() << std::endl;
#ifdef _WIN32
    system("pause");
#endif
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

// Helper function to check for shader compilation errors
void checkCompileErrors(GLuint shader, const std::string &type) {
  GLint success;
  GLchar infoLog[1024];
  if (type != "PROGRAM") {
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
      glGetShaderInfoLog(shader, 1024, NULL, infoLog);
      std::stringstream ss;
      ss << "ERROR::SHADER_COMPILATION_ERROR of type: " << type << "\n"
         << infoLog
         << "\n -- --------------------------------------------------- -- "
         << std::endl;
      throw std::runtime_error(ss.str());
    }
  } else {
    glGetProgramiv(shader, GL_LINK_STATUS, &success);
    if (!success) {
      glGetProgramInfoLog(shader, 1024, NULL, infoLog);
      std::stringstream ss;
      ss << "ERROR::PROGRAM_LINKING_ERROR of type: " << type << "\n"
         << infoLog
         << "\n -- --------------------------------------------------- -- "
         << std::endl;
      throw std::runtime_error(ss.str());
    }
  }
}

// Function to create and link a shader program from vertex and fragment shader
// sources
SharedShader createShaderProgram(const char *vertexSource,
                                 const char *fragmentSource) {
  // 1. Compile shaders

  // Vertex Shader
  GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
  glShaderSource(vertexShader, 1, &vertexSource, NULL);
  glCompileShader(vertexShader);
  checkCompileErrors(vertexShader, "VERTEX");

  // Fragment Shader
  GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
  glShaderSource(fragmentShader, 1, &fragmentSource, NULL);
  glCompileShader(fragmentShader);
  checkCompileErrors(fragmentShader, "FRAGMENT");

  // 2. Link shaders into a shader program
  auto shaderProgram = makeShaderProgram();
  glAttachShader(*shaderProgram, vertexShader);
  glAttachShader(*shaderProgram, fragmentShader);
  glLinkProgram(*shaderProgram);
  checkCompileErrors(*shaderProgram, "PROGRAM");

  // 3. Delete the shaders as they're linked into our program now and no longer
  // necessary
  glDeleteShader(vertexShader);
  glDeleteShader(fragmentShader);

  return shaderProgram;
}
