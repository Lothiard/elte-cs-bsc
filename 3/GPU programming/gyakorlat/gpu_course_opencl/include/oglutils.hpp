// A simple utility file for facilitating the use of OpenCL for OpenGL interoperation.
// Author: Ivan Eichhardt

#include <stdexcept>
#include <stdexcept>
#include <memory>
#include <string>

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

#include "oclutils.hpp"

inline bool oclCreateContextFromCurrentGLContext(cl::Context &context)
{	
	std::vector<cl::Platform> platforms;
	cl::Platform::get(&platforms);

	for (const auto& platform : platforms) {
		
		cl_context_properties props[] = {
#ifdef _WIN32
			CL_CONTEXT_PLATFORM, (cl_context_properties)(platform)(),
			CL_GL_CONTEXT_KHR,   (cl_context_properties)wglGetCurrentContext(),
			CL_WGL_HDC_KHR,      (cl_context_properties)wglGetCurrentDC(),
#elif defined(__GNUC__) // Linux GLX
			CL_CONTEXT_PLATFORM, (cl_context_properties)(platform)(),
			CL_GL_CONTEXT_KHR,   (cl_context_properties)glXGetCurrentContext(),
			CL_GLX_DISPLAY_KHR,  (cl_context_properties)glXGetCurrentDisplay(),
#elif defined(__APPLE__)
			// macOS OpenGL-CL interop would use CGL context
			CL_CONTEXT_PROPERTY_USE_CGL_SHAREGROUP_APPLE, (cl_context_properties)CGLGetShareGroup(CGLGetCurrentContext()),
#endif
			0
		};

		try {
			context = cl::Context(CL_DEVICE_TYPE_GPU, props);

            return true; // context created successfully
		}
		catch (const cl::Error&) {
			continue;
		}
	}

	return false; // failed to create shared opengl - opencl context
}

// Custom Deleters for std::unique_ptr
// Since exceptions may be thrown, these custom deleters take care of releasing various objects

// Custom deleter for SDL_Window to call SDL_DestroyWindow
struct SdlWindowDeleter {
    void operator()(SDL_Window* window) const {
        if (window) {
            SDL_DestroyWindow(window);
            std::cout << "SDL_Window destroyed." << std::endl;
        }
    }
};

// Custom deleter for SDL_GLContext to call SDL_GL_DeleteContext
struct SdlGlContextDeleter {
    void operator()(SDL_GLContext context) const {
        if (context) {
            SDL_GL_DeleteContext(context);
            std::cout << "SDL_GLContext destroyed." << std::endl;
        }
    }
};

struct VaoDeleter {
    void operator()(GLuint* id) const {
        if (id && *id) {
            glDeleteVertexArrays(1, id);
        }
        delete id;
    }
};

struct VboDeleter {
    void operator()(GLuint* id) const {
        if (id && *id) {
            glDeleteBuffers(1, id);
        }
        delete id;
    }
};

struct ShaderProgramDeleter {
    void operator()(GLuint* id) const {
        if (id && *id) {
            glDeleteProgram(*id);
        }
        delete id;
    }
};

struct TextureDeleter {
    void operator()(GLuint* id) const {
        if (id && *id) {
            glDeleteTextures(1, id);
        }
        delete id;
    }
};


// RAII Type Aliases for Convenience
using UniqueWindow = std::unique_ptr<SDL_Window, SdlWindowDeleter>;
using UniqueGlContext = std::unique_ptr<void, SdlGlContextDeleter>; // SDL_GLContext is a typedef for void*
using UniqueVAO = std::unique_ptr<GLuint, VaoDeleter>;
using UniqueVBO = std::unique_ptr<GLuint, VboDeleter>;
using SharedShader = std::shared_ptr<GLuint>;
using SharedTexture = std::shared_ptr<GLuint>;

// RAII Class for SDL Library Initialization
// This class manages the SDL_Init/SDL_Quit lifecycle.
// When an SdlManager object is created, it calls SDL_Init.
// When it's destroyed (at the end of its scope), it calls SDL_Quit.
class SdlManager {
public:
    SdlManager(Uint32 flags) {
        if (SDL_Init(flags) != 0) {
            // Throw an exception if initialization fails.
            throw std::runtime_error(std::string("SDL_Init failed: ") + SDL_GetError());
        }
        std::cout << "SDL initialized." << std::endl;
    }

    ~SdlManager() {
        SDL_Quit();
        std::cout << "SDL quit." << std::endl;
    }

    // Disable copy and move operations to prevent multiple initializations/quits.
    SdlManager(const SdlManager&) = delete;
    SdlManager& operator=(const SdlManager&) = delete;
    SdlManager(SdlManager&&) = delete;
    SdlManager& operator=(SdlManager&&) = delete;
};

// Helper Functions for OpenGL objects
inline UniqueVAO makeVAO() {
    GLuint id = 0;
    glGenVertexArrays(1, &id);
    return UniqueVAO(new GLuint(id));
}

inline UniqueVBO makeVBO() {
    GLuint id = 0;
    glGenBuffers(1, &id);
    return UniqueVBO(new GLuint(id));
}

inline SharedShader makeShaderProgram() {
    GLuint id = glCreateProgram();
    return SharedShader(new GLuint(id), ShaderProgramDeleter{});
}

inline SharedTexture makeTexture() {
    GLuint id = 0;
    glGenTextures(1, &id);
    return SharedTexture(new GLuint(id), TextureDeleter{});
}