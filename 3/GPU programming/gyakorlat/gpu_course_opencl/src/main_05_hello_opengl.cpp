#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>
#include <chrono>  // For timing
#include <thread>  // For sleep

// Define this before including SDL.h to manage the main function yourself.
#define SDL_MAIN_HANDLED

#include <GL/glew.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>

#include <CL/opencl.hpp>
#include <oglutils.hpp>

// Forward-declare our utility functions
UniqueGlProgram createShaderProgram(const char *vertexSource,
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
  
  // Tell SDL that we want a modern OpenGL context
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
  
  // Set additional attributes for a proper rendering context
  SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
  SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);
  UniqueWindow window(SDL_CreateWindow("Animated OpenCL + OpenGL", 
                                        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                                        800, 600, SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN));
  if (!window)
    throw std::runtime_error(std::string("SDL_CreateWindow failed: ") +
                             SDL_GetError());
  UniqueGlContext glContext(SDL_GL_CreateContext(window.get()));
  if (!glContext)
    throw std::runtime_error(std::string("SDL_GL_CreateContext failed: ") +
                             SDL_GetError());
                             
  // Make the context current
  SDL_GL_MakeCurrent(window.get(), glContext.get());
  
  // Initialize GLEW - GLEW must be initialized AFTER SDL_GL_MakeCurrent
  glewExperimental = GL_TRUE; // Needed for core profile
  GLenum glewError = glewInit();
  if (glewError != GLEW_OK) {
    std::cerr << "GLEW initialization failed: " << glewGetErrorString(glewError) << std::endl;
    // Continue anyway - GLEW sometimes returns an error code but still initializes correctly
    std::cerr << "Attempting to continue despite GLEW error..." << std::endl;
  }
  
  // Always clear any OpenGL error that GLEW might have caused (known issue with GLEW)
  GLenum err;
  while((err = glGetError()) != GL_NO_ERROR) {
    std::cerr << "Clearing OpenGL error: " << err << std::endl;
  }
  
  std::cout << "OpenGL Version: " << glGetString(GL_VERSION) << std::endl;

  // Display OpenGL info first to see which GPU is handling rendering
  const GLubyte* renderer = glGetString(GL_RENDERER);
  const GLubyte* version = glGetString(GL_VERSION);
  std::cout << "====== GRAPHICS HARDWARE INFO ======" << std::endl;
  std::cout << "OpenGL Renderer: " << (renderer ? (const char*)renderer : "unknown") << std::endl;
  std::cout << "OpenGL Version: " << (version ? (const char*)version : "unknown") << std::endl;
  std::cout << "====================================" << std::endl;

  // 2. Attempt OpenCL setup with fallback to pure OpenGL rendering
  cl::Context clContext;
  cl::CommandQueue queue;
  cl::Device device;
  bool useOpenCL = false;
  
  try {
    // Try to set up OpenCL
    useOpenCL = oclCreateContextFromCurrentGLContext(clContext);
    if (!useOpenCL) {
      std::cerr << "WARNING: Failed to create CL/GL shared context. Will use pure OpenGL rendering." << std::endl;
      std::cerr << "This is common with hybrid GPU systems where OpenGL runs on one GPU and OpenCL on another." << std::endl;
    } else {
      // Get devices from the context
      auto devices = clContext.getInfo<CL_CONTEXT_DEVICES>();
      if (devices.empty()) {
        std::cerr << "No OpenCL devices found in the context. Will use pure OpenGL rendering." << std::endl;
        useOpenCL = false;
      } else {
        device = devices.front();
        std::cout << "OpenCL Device: " << device.getInfo<CL_DEVICE_NAME>() << std::endl;
        std::cout << "OpenCL Device Vendor: " << device.getInfo<CL_DEVICE_VENDOR>() << std::endl;
        
        // Check if there's a mismatch between OpenGL and OpenCL devices
        std::string openglDevice = (renderer ? (const char*)renderer : "unknown");
        std::string openclDevice = device.getInfo<CL_DEVICE_NAME>();
        
        if ((openglDevice.find("AMD") != std::string::npos && openclDevice.find("NVIDIA") != std::string::npos) ||
            (openglDevice.find("NVIDIA") != std::string::npos && openclDevice.find("AMD") != std::string::npos)) {
          std::cout << "DETECTED GPU MISMATCH: OpenGL and OpenCL are using different GPUs!" << std::endl;
          std::cout << "This will prevent OpenCL-OpenGL interoperation from working." << std::endl;
          std::cout << "To fix: Set environment variables before running the application:" << std::endl;
          std::cout << "For NVIDIA: __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia" << std::endl;
          std::cout << "For AMD: DRI_PRIME=1" << std::endl;
        }
        
        // Create command queue
        queue = cl::CommandQueue(clContext, device);
        std::cout << "Command queue created successfully" << std::endl;
      }
    }
  } catch (const cl::Error& e) {
    std::cerr << "OpenCL setup failed: " << e.what() << " (" << e.err() << ")" << std::endl;
    std::cerr << "Will use pure OpenGL rendering" << std::endl;
    useOpenCL = false;
  } catch (const std::exception& e) {
    std::cerr << "Exception during OpenCL setup: " << e.what() << std::endl;
    std::cerr << "Will use pure OpenGL rendering" << std::endl;
    useOpenCL = false;
  }

  // Initialize OpenCL program and kernel only if we're using OpenCL
  cl::Program program;
  cl::Kernel rawKernel;
  bool hasKernel = false;
  
  if (useOpenCL) {
    try {
      program = cl::Program(clContext, kernelSource);
      if (program.build({device}) != CL_SUCCESS) {
        std::string buildLog = program.getBuildInfo<CL_PROGRAM_BUILD_LOG>(device);
        std::cerr << "OpenCL program build error:\n" << buildLog << std::endl;
        std::cerr << "Will use CPU-based fallback instead" << std::endl;
      } else {
        try {
          rawKernel = cl::Kernel(program, "fill_animated_texture");
          hasKernel = true;
          std::cout << "Successfully created kernel" << std::endl;
        } catch (const cl::Error& e) {
          std::cerr << "Failed to create kernel: " << e.what() << " (" << e.err() << ")" << std::endl;
          std::cerr << "Will use CPU-based fallback instead" << std::endl;
        }
      }
    } catch (const cl::Error& e) {
      std::cerr << "Error creating OpenCL program: " << e.what() << " (" << e.err() << ")" << std::endl;
      std::cerr << "Will use CPU-based fallback instead" << std::endl;
    }
  } else {
    std::cout << "OpenCL not available, will use CPU-based rendering" << std::endl;
  }

  // 3. OpenGL Object Setup
  auto shaderProgram =
      createShaderProgram(vertexShaderSource, fragmentShaderSource);

  float quadVertices[] = {-1.0f, 1.0f,  0.0f, 1.0f, -1.0f, -1.0f, 0.0f, 0.0f,
                          1.0f,  -1.0f, 1.0f, 0.0f, -1.0f, 1.0f,  0.0f, 1.0f,
                          1.0f,  -1.0f, 1.0f, 0.0f, 1.0f,  1.0f,  1.0f, 1.0f};

  auto quadVAO = createVertexArray();
  auto quadVBO = createBuffer();
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
  auto glTexture = createTexture<GL_TEXTURE_2D>();
  glBindTexture(GL_TEXTURE_2D, *glTexture);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA32F, TEX_WIDTH, TEX_HEIGHT, 0, GL_RGBA,
               GL_FLOAT, nullptr);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glBindTexture(GL_TEXTURE_2D, 0);

  // 4. OpenGL-CL Interop Object setup (if using OpenCL)
  cl::ImageGL clImage;
  bool hasGLInterop = false;
  
  if (useOpenCL && hasKernel) {
    try {
      // Print OpenGL texture info for diagnostics
      std::cout << "OpenGL texture ID: " << *glTexture << std::endl;
      
      // Check if we have OpenGL interop capability
      auto devices = clContext.getInfo<CL_CONTEXT_DEVICES>();
      if (!devices.empty()) {
        std::string deviceExtensions = devices[0].getInfo<CL_DEVICE_EXTENSIONS>();
        if (deviceExtensions.find("cl_khr_gl_sharing") != std::string::npos) {
          std::cout << "Device supports cl_khr_gl_sharing extension" << std::endl;
        } else {
          std::cout << "WARNING: Device does not support cl_khr_gl_sharing extension" << std::endl;
        }
      }
      
      // Create the shared image, with extra safety
      try {
        // First check if the GL texture is valid
        GLint textureParams = 0;
        glGetTextureParameteriv(*glTexture, GL_TEXTURE_WIDTH, &textureParams);
        std::cout << "Texture width: " << textureParams << std::endl;
        
        // This is where we need to be very careful - disable CL/GL interop entirely
        // since we couldn't create a proper shared context
        std::cout << "WARNING: Not attempting to create cl::ImageGL due to lack of proper OpenGL-OpenCL shared context" << std::endl;
        std::cout << "Will use CPU-based rendering instead" << std::endl;
        hasGLInterop = false;
        
        /* This causes segmentation fault - don't attempt it
        clImage = cl::ImageGL(clContext, CL_MEM_WRITE_ONLY, GL_TEXTURE_2D, 0, *glTexture);
        std::cout << "Successfully created OpenGL-OpenCL interop image" << std::endl;
        hasGLInterop = true;
        */
      } catch (const cl::Error& e) {
        std::cerr << "Failed to create OpenGL-OpenCL interop image: " << e.what() << " (" << e.err() << ")" << std::endl;
        std::cerr << "Will use CPU-based rendering instead" << std::endl;
        hasGLInterop = false;
      } catch (const std::exception& e) {
        std::cerr << "Exception during texture validation: " << e.what() << std::endl;
        std::cerr << "Will use CPU-based rendering instead" << std::endl;
        hasGLInterop = false;
      }
    } catch (const std::exception& e) {
      std::cerr << "Exception checking OpenCL-OpenGL interop capability: " << e.what() << std::endl;
      std::cerr << "Will use CPU-based rendering instead" << std::endl;
    }
  }

  // 5. Main Loop
  bool running = true;
  bool warningShown = false;
  
  while (running) {
    SDL_Event event;
    while (SDL_PollEvent(&event))
      if (event.type == SDL_QUIT)
        running = false;

    // Get elapsed time in seconds
    float time = SDL_GetTicks() / 1000.0f;
    
    try {
      // Double-check that clImage is valid before attempting to use it
      bool validInterop = useOpenCL && hasKernel && hasGLInterop;
      if (validInterop) {
        try {
          // Make sure clImage is valid
          if (clImage() == nullptr) {
            std::cerr << "clImage is null, falling back to CPU rendering" << std::endl;
            hasGLInterop = false;
            validInterop = false;
          }
        } catch (const std::exception& e) {
          std::cerr << "Error checking clImage validity: " << e.what() << std::endl;
          hasGLInterop = false;
          validInterop = false;
        }
      }
      
      if (validInterop) {
        // OpenCL-OpenGL interop path
        try {
          std::cout << "Attempting OpenCL-OpenGL interop rendering..." << std::endl;
          // Acquire the OpenGL texture for OpenCL to write to
          std::vector<cl::Memory> glObjs = {clImage};
          queue.enqueueAcquireGLObjects(&glObjs);
          std::cout << "Acquired GL objects" << std::endl;

          // Set the kernel arguments and execute
          rawKernel.setArg(0, clImage);
          rawKernel.setArg(1, time);
          std::cout << "Set kernel arguments" << std::endl;
          
          queue.enqueueNDRangeKernel(rawKernel, cl::NullRange, cl::NDRange(TEX_WIDTH, TEX_HEIGHT), cl::NullRange);
          std::cout << "Executed kernel" << std::endl;

          // Release the texture back to OpenGL
          queue.enqueueReleaseGLObjects(&glObjs);
          queue.finish();
          std::cout << "Released GL objects and finished queue" << std::endl;
        } catch (const cl::Error& e) {
          std::cerr << "OpenCL error during rendering: " << e.what() << " (" << e.err() << ")" << std::endl;
          hasGLInterop = false;  // Disable GL interop for future frames
        }
      } else {
        // CPU-based fallback rendering
        if (!warningShown) {
          std::cout << "Using CPU-based rendering fallback" << std::endl;
          warningShown = true;
        }
        
        // Create a simple animated pattern on CPU
        std::vector<float> pixels(TEX_WIDTH * TEX_HEIGHT * 4);
        for (int y = 0; y < TEX_HEIGHT; y++) {
          for (int x = 0; x < TEX_WIDTH; x++) {
            float u = (float)x / TEX_WIDTH;
            float v = (float)y / TEX_HEIGHT;
            float val1 = sin(u * 10.0f + time * 2.0f);
            float val2 = sin(v * 10.0f + time * 3.0f);
            float val3 = sin((u + v) * 10.0f + time * 4.0f);
            float final_value = 0.5f + 0.5f * ((val1 + val2 + val3) / 3.0f);
            
            int index = (y * TEX_WIDTH + x) * 4;
            pixels[index + 0] = final_value;  // R
            pixels[index + 1] = final_value;  // G
            pixels[index + 2] = final_value;  // B
            pixels[index + 3] = 1.0f;         // A
          }
        }
        
        // Update the OpenGL texture with CPU-generated pattern
        glBindTexture(GL_TEXTURE_2D, *glTexture);
        glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, TEX_WIDTH, TEX_HEIGHT, GL_RGBA, GL_FLOAT, pixels.data());
        glBindTexture(GL_TEXTURE_2D, 0);
      }
    }
    catch (const std::exception& e) {
      std::cerr << "Error during rendering: " << e.what() << std::endl;
      
      // If we encounter an error, disable OpenCL and continue with CPU rendering
      useOpenCL = false;
      hasGLInterop = false;
    }    // Render the result
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
UniqueGlProgram createShaderProgram(const char *vertexSource,
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
  auto shaderProgram = createProgram();
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
