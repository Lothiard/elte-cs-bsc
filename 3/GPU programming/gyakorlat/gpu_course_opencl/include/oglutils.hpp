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
#include <SDL3/SDL.h>
#include <SDL3/SDL_opengl.h>
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
    // Corrected logic for SDL3: returns 0 on failure, non-zero on success.
    if (SDL_Init(flags) == 0) {
      throw SdlException("SDL_Init failed.");
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
      SDL_GL_DestroyContext(context);
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
using UniqueGlContext = std::unique_ptr<SDL_GLContextState, SdlGlContextDeleter>;
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
  std::vector<cl::Platform> platforms;
  cl::Platform::get(&platforms);

  for (const auto& platform : platforms) {
    cl_context_properties props[] = {
      CL_CONTEXT_PLATFORM, (cl_context_properties)(platform)(),
      #if defined(_WIN32)
      CL_GL_CONTEXT_KHR,   (cl_context_properties)wglGetCurrentContext(),
      CL_WGL_HDC_KHR,      (cl_context_properties)wglGetCurrentDC(),
      #elif defined(__linux__)
      CL_GL_CONTEXT_KHR,   (cl_context_properties)glXGetCurrentContext(),
      CL_GLX_DISPLAY_KHR,  (cl_context_properties)glXGetCurrentDisplay(),
      #elif defined(__APPLE__)
      // macOS OpenGL-CL interop would use CGL context. This is the legacy path.
      CL_CONTEXT_PROPERTY_USE_CGL_SHAREGROUP_APPLE, (cl_context_properties)CGLGetShareGroup(CGLGetCurrentContext()),
      #endif
      0
    };

    try {
      context = cl::Context(CL_DEVICE_TYPE_GPU, props);
      return true; // Context created successfully
    }
    catch (const cl::Error&) {
      // Try the next platform
      continue;
    }
  }
  return false; // Failed to create a shared context on any platform
}

