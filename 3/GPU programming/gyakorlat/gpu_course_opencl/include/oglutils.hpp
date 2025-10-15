#pragma once

// Standard Library
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>
#include <iostream> // For debug logs in deleters

// Graphics & Compute Libraries
#include <GL/glew.h>
#ifdef __APPLE__
#include <OpenGL/OpenGL.h>
#elif defined(_WIN32)
#include <Windows.h>
#include <GL/gl.h>
#else // assume Linux/GLX
#include <GL/glx.h>
#include <GL/gl.h>
#endif
#include <SDL2/SDL.h>
#include <CL/opencl.hpp>

// --- Custom Exception Types ---
class SdlException : public std::runtime_error {
public:
  SdlException(const std::string& message) : std::runtime_error(message + " SDL Error: " + SDL_GetError()) {}
};

// --- SDL RAII Wrappers ---

// Manages the SDL_Init/SDL_Quit lifecycle.
class SdlManager {
public:
  SdlManager(Uint32 flags) {
    // SDL2 returns 0 on success, non-zero on failure
    if (SDL_Init(flags) != 0) {
      std::string errorMsg = "SDL_Init failed. SDL Error: ";
      errorMsg += SDL_GetError();
      std::cerr << "Debug - " << errorMsg << std::endl;  // Add this debug line
      throw SdlException(errorMsg);
    }
    std::cout << "SDL initialized." << std::endl;
  }

  ~SdlManager() {
    SDL_Quit();
    std::cout << "SDL quit." << std::endl;
  }

  // Disable copy/move to enforce singleton-like behavior for the SDL library session.
  SdlManager(const SdlManager&) = delete;
  SdlManager& operator=(const SdlManager&) = delete;
  SdlManager(SdlManager&&) = delete;
  SdlManager& operator=(SdlManager&&) = delete;
};

// Custom deleters for SDL objects
struct SdlWindowDeleter {
  void operator()(SDL_Window* window) const {
    if (window) {
      SDL_DestroyWindow(window);
      std::cout << "SDL_Window destroyed." << std::endl;
    }
  }
};

struct SdlGlContextDeleter {
  void operator()(SDL_GLContext context) const {
    if (context) {
      SDL_GL_DeleteContext(context);
      std::cout << "SDL_GLContext destroyed." << std::endl;
    }
  }
};

// --- OpenGL RAII Wrappers ---

// Custom Deleters for various OpenGL object types
struct GlBufferDeleter {
  void operator()(GLuint* id) const {
    if (id && *id) glDeleteBuffers(1, id);
    delete id;
  }
};

struct GlVertexArrayDeleter {
  void operator()(GLuint* id) const {
    if (id && *id) glDeleteVertexArrays(1, id);
    delete id;
  }
};

struct GlTextureDeleter {
  void operator()(GLuint* id) const {
    if (id && *id) glDeleteTextures(1, id);
    delete id;
  }
};

struct GlProgramDeleter {
  void operator()(GLuint* id) const {
    if (id && *id) glDeleteProgram(*id);
    delete id;
  }
};

// --- RAII Type Aliases ---

// Use unique_ptr for clear, exclusive ownership of resources.
using UniqueWindow = std::unique_ptr<SDL_Window, SdlWindowDeleter>;
using UniqueGlContext = std::unique_ptr<void, SdlGlContextDeleter>;
using UniqueGlBuffer = std::unique_ptr<GLuint, GlBufferDeleter>;
using UniqueGlVertexArray = std::unique_ptr<GLuint, GlVertexArrayDeleter>;
using UniqueGlTexture = std::unique_ptr<GLuint, GlTextureDeleter>;
using UniqueGlProgram = std::unique_ptr<GLuint, GlProgramDeleter>;

// --- RAII Helper Functions ---

// Creates RAII-managed OpenGL objects, throwing on failure.
inline UniqueGlBuffer createBuffer() {
  GLuint id = 0;
  glGenBuffers(1, &id);
  if (id == 0) throw std::runtime_error("Failed to create OpenGL buffer.");
  return UniqueGlBuffer(new GLuint(id));
}

inline UniqueGlVertexArray createVertexArray() {
  GLuint id = 0;
  glGenVertexArrays(1, &id);
  if (id == 0) throw std::runtime_error("Failed to create OpenGL vertex array.");
  return UniqueGlVertexArray(new GLuint(id));
}

template <GLenum target = GL_TEXTURE_2D>
inline UniqueGlTexture createTexture() {
  GLuint id = 0;
  glCreateTextures(target, 1, &id);
  if (id == 0) throw std::runtime_error("Failed to create OpenGL texture.");
  return UniqueGlTexture(new GLuint(id));
}

inline UniqueGlProgram createProgram() {
  GLuint id = glCreateProgram();
  return UniqueGlProgram(new GLuint(id));
}

// --- OpenCL / OpenGL Interop ---

// Creates a shared OpenCL context from the current OpenGL context.
// This version uses platform-specific functions directly.
inline bool oclCreateContextFromCurrentGLContext(cl::Context& context)
{
  try {
    // Force initialization in case GLEW didn't fully initialize
    glGetString(GL_VERSION);
    
    std::vector<cl::Platform> platforms;
    cl::Platform::get(&platforms);
    
    std::cout << "Found " << platforms.size() << " OpenCL platform(s)" << std::endl;
    
    // First attempt: try to create a context with NVIDIA platform
    for (size_t i = 0; i < platforms.size(); i++) {
      auto& platform = platforms[i];
      std::string platformName = platform.getInfo<CL_PLATFORM_NAME>();
      std::cout << "Platform " << i << ": " << platformName << std::endl;
      
      // Check if this platform supports OpenGL sharing
      std::string extensions = platform.getInfo<CL_PLATFORM_EXTENSIONS>();
      bool hasGLSharing = extensions.find("cl_khr_gl_sharing") != std::string::npos;
      
      if (!hasGLSharing) {
        std::cout << "  Platform doesn't support OpenGL sharing, skipping" << std::endl;
        continue;
      }
      
      std::cout << "  Platform supports OpenGL sharing" << std::endl;
      
      try {
        // List available GPU devices
        std::vector<cl::Device> devices;
        platform.getDevices(CL_DEVICE_TYPE_GPU, &devices);
        
        std::cout << "  Found " << devices.size() << " GPU devices" << std::endl;
        
        for (size_t j = 0; j < devices.size(); j++) {
          std::cout << "  Device " << j << ": " << devices[j].getInfo<CL_DEVICE_NAME>() << std::endl;
        }
        
        // If we have devices, try to create context with the first one directly
        if (!devices.empty()) {
          try {
            cl_context_properties props[] = {
              CL_CONTEXT_PLATFORM, (cl_context_properties)(platform)(),
              #if defined(_WIN32)
              CL_GL_CONTEXT_KHR,   (cl_context_properties)wglGetCurrentContext(),
              CL_WGL_HDC_KHR,      (cl_context_properties)wglGetCurrentDC(),
              #elif defined(__linux__)
              CL_GL_CONTEXT_KHR,   (cl_context_properties)glXGetCurrentContext(),
              CL_GLX_DISPLAY_KHR,  (cl_context_properties)glXGetCurrentDisplay(),
              #elif defined(__APPLE__)
              CL_CONTEXT_PROPERTY_USE_CGL_SHAREGROUP_APPLE, (cl_context_properties)CGLGetShareGroup(CGLGetCurrentContext()),
              #endif
              0
            };
            
            // Create context with specific device
            context = cl::Context(devices, props);
            std::cout << "Successfully created OpenCL context with " << platformName 
                      << " and device " << devices[0].getInfo<CL_DEVICE_NAME>() << std::endl;
            return true;
          }
          catch (const cl::Error& e) {
            std::cout << "  Failed to create context with specific device: " << e.what() 
                      << " (" << e.err() << ")" << std::endl;
          }
        }
      }
      catch (const cl::Error& e) {
        std::cout << "  Error getting devices: " << e.what() << " (" << e.err() << ")" << std::endl;
      }
      
      // Try generic context creation with this platform
      try {
        cl_context_properties props[] = {
          CL_CONTEXT_PLATFORM, (cl_context_properties)(platform)(),
          #if defined(_WIN32)
          CL_GL_CONTEXT_KHR,   (cl_context_properties)wglGetCurrentContext(),
          CL_WGL_HDC_KHR,      (cl_context_properties)wglGetCurrentDC(),
          #elif defined(__linux__)
          CL_GL_CONTEXT_KHR,   (cl_context_properties)glXGetCurrentContext(),
          CL_GLX_DISPLAY_KHR,  (cl_context_properties)glXGetCurrentDisplay(),
          #elif defined(__APPLE__)
          CL_CONTEXT_PROPERTY_USE_CGL_SHAREGROUP_APPLE, (cl_context_properties)CGLGetShareGroup(CGLGetCurrentContext()),
          #endif
          0
        };
        
        // Create generic context
        context = cl::Context(CL_DEVICE_TYPE_GPU, props);
        std::cout << "Successfully created OpenCL context with " << platformName << std::endl;
        return true;
      }
      catch (const cl::Error& e) {
        std::cout << "  Failed to create generic context: " << e.what() << " (" << e.err() << ")" << std::endl;
      }
    }
    
    // If we reach here, try one more approach - context without OpenGL interop
    std::cout << "Attempting to create a regular OpenCL context without OpenGL sharing" << std::endl;
    try {
      // Just create a regular context with default platform
      context = cl::Context(CL_DEVICE_TYPE_GPU);
      std::cout << "Created regular OpenCL context without OpenGL sharing" << std::endl;
      std::cout << "WARNING: No OpenGL interoperation will be available!" << std::endl;
      return true;
    }
    catch (const cl::Error& e) {
      std::cout << "Failed to create even a regular context: " << e.what() << " (" << e.err() << ")" << std::endl;
    }
    
    std::cerr << "Failed to create a shared context on any platform" << std::endl;
    return false;
  }
  catch (const std::exception& e) {
    std::cerr << "Exception in oclCreateContextFromCurrentGLContext: " << e.what() << std::endl;
    return false;
  }
}

