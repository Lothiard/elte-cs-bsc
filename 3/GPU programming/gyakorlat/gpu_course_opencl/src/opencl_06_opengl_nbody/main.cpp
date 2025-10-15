// GL
#include <GL/glew.h>

// SDL
#include <SDL2/SDL.h>

// Imgui
#include <imgui.h>
#include "common/imgui/imgui_impl_sdl2_simplified.h"
#include "common/imgui/imgui_impl_opengl3_simplified.h"

#include <iostream>
#include <sstream>
#include <stdexcept>

#include "MyApp.h"
#include <oglutils.hpp>

class ImGuiManager {
public:
  ImGuiManager(SDL_Window* window, SDL_GLContext context) {
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGui::StyleColorsDark();
    
    // Initialize our simplified implementations
    bool sdl_init_success = ImGui_ImplSDL2_InitForOpenGL(window, context);
    bool gl_init_success = ImGui_ImplOpenGL3_Init("#version 120"); // Using GLSL 120 for better compatibility
    
    if (!sdl_init_success || !gl_init_success) {
      std::cerr << "ImGui initialization failed!" << std::endl;
    }
  }
  ~ImGuiManager() {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplSDL2_Shutdown();
    ImGui::DestroyContext();
  }
  ImGuiManager(const ImGuiManager&) = delete;
  ImGuiManager& operator=(const ImGuiManager&) = delete;
};

// Helper function to set up all OpenGL attributes
void setupSdlGlAttributes() {
  // Request OpenGL 2.1 (more widely supported)
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 2);
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 1);
  
  // Don't set profile for OpenGL 2.1 (profiles were introduced in 3.2)
  // Explicitly setting profile to SDL_GL_CONTEXT_PROFILE_COMPATIBILITY for maximum compatibility
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_COMPATIBILITY);
  
  // Set color and buffer sizes
  SDL_GL_SetAttribute(SDL_GL_RED_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_GREEN_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_BLUE_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_ALPHA_SIZE, 8);
  SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);

  // Enable double buffering
  SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
}

// Encapsulates the main application loop and event handling
void mainLoop(SDL_Window* window, MyApp& app) {
  bool quit = false;
  bool showImGui = true;
  Uint32 lastTick = SDL_GetTicks();

  while (!quit) {
    // Process all pending events
    SDL_Event ev;
    while (SDL_PollEvent(&ev)) {
      ImGui_ImplSDL2_ProcessEvent(&ev);
      const bool isMouseCaptured = ImGui::GetIO().WantCaptureMouse;
      const bool isKeyboardCaptured = ImGui::GetIO().WantCaptureKeyboard;

      switch (ev.type) {
      case SDL_QUIT:
        quit = true;
        break;
      case SDL_KEYDOWN:
        if (ev.key.keysym.sym == SDLK_ESCAPE) quit = true;

        // ALT+ENTER toggles fullscreen
        if (ev.key.keysym.sym == SDLK_RETURN && (ev.key.keysym.mod & KMOD_ALT)) {
          Uint32 flags = (SDL_GetWindowFlags(window) & SDL_WINDOW_FULLSCREEN) ? 0 : SDL_WINDOW_FULLSCREEN;
          SDL_SetWindowFullscreen(window, flags);
        }
        // CTRL+F1 toggles ImGui visibility
        if (ev.key.keysym.sym == SDLK_F1 && (ev.key.keysym.mod & KMOD_CTRL)) {
          showImGui = !showImGui;
        }
        if (!isKeyboardCaptured) app.KeyboardDown(ev.key);
        break;
      case SDL_KEYUP:
        if (!isKeyboardCaptured) app.KeyboardUp(ev.key);
        break;
      case SDL_MOUSEBUTTONDOWN:
        if (!isMouseCaptured) app.MouseDown(ev.button);
        break;
      case SDL_MOUSEBUTTONUP:
        if (!isMouseCaptured) app.MouseUp(ev.button);
        break;
      case SDL_MOUSEWHEEL:
        if (!isMouseCaptured) app.MouseWheel(ev.wheel);
        break;
      case SDL_MOUSEMOTION:
        if (!isMouseCaptured) app.MouseMove(ev.motion);
        break;
      case SDL_WINDOWEVENT:
        if (ev.window.event == SDL_WINDOWEVENT_RESIZED || ev.window.event == SDL_WINDOWEVENT_SHOWN) {
          int w, h;
          SDL_GetWindowSize(window, &w, &h);
          app.Resize(w, h);
        }
        break;
      default:
        app.OtherEvent(ev);
      }
    }

    // Calculate time delta for the update
    const Uint32 currentTick = SDL_GetTicks();
    UpdateInfo updateInfo{
        static_cast<float>(currentTick) / 1000.0f,
        static_cast<float>(currentTick - lastTick) / 1000.0f
    };
    lastTick = currentTick;

    // Update and render application logic
    app.Update(updateInfo);

    app.Render();

    // Render ImGui UI with additional error checking
    try {
        std::cout << "Starting ImGui rendering..." << std::endl;
        
        // Step 1: New frames
        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplSDL2_NewFrame();
        ImGui::NewFrame();
        
        std::cout << "ImGui frames created successfully" << std::endl;
        
        // Step 2: Render GUI content
        if (showImGui) {
            std::cout << "Rendering GUI content..." << std::endl;
            app.RenderGUI();
            std::cout << "GUI content rendered successfully" << std::endl;
        }
        
        // Step 3: Finalize ImGui rendering
        ImGui::Render();
        
        std::cout << "Rendering ImGui draw data..." << std::endl;
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        std::cout << "ImGui rendering completed successfully" << std::endl;
    }
    catch (const std::exception& e) {
        std::cerr << "Exception during ImGui rendering: " << e.what() << std::endl;
    }
    catch (...) {
        std::cerr << "Unknown exception during ImGui rendering" << std::endl;
    }

    // Swap buffers
    SDL_GL_SwapWindow(window);
  }
}

int main(int argc, char* args[]) {
  try {
    // SdlManager handles SDL_Init and SDL_Quit automatically
    SdlManager sdlManager(SDL_INIT_VIDEO);

    setupSdlGlAttributes();

    // Create window and context using RAII wrappers
    UniqueWindow window(SDL_CreateWindow("Hello SDL & OpenGL!", 
                                        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                                        1280, 720, 
                                        SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE));
    if (!window) throw SdlException("Window creation failed.");

    UniqueGlContext context(SDL_GL_CreateContext(window.get()));
    if (!context) throw SdlException("OpenGL context creation failed.");

    // Enable VSync
    SDL_GL_SetSwapInterval(1);

    // Initialize GLEW
    std::cout << "About to initialize GLEW..." << std::endl;
    glewExperimental = GL_TRUE; // Try setting experimental flag
    GLenum err = glewInit();
    if (err != GLEW_OK) {
      std::cerr << "GLEW error code: " << err << std::endl;
      std::cerr << "GLEW initialization failed, but we'll continue anyway for testing purposes." << std::endl;
      // Don't throw, continue execution for testing
    } else {
      std::cout << "GLEW initialized successfully!" << std::endl;
    }
    
    // Clear any OpenGL error that GLEW might have caused
    GLenum glErr = glGetError();
    while (glErr != GL_NO_ERROR) {
      std::cerr << "OpenGL error after GLEW init: " << glErr << std::endl;
      glErr = glGetError();
    }

    // Log OpenGL version
    int major, minor;
    glGetIntegerv(GL_MAJOR_VERSION, &major);
    glGetIntegerv(GL_MINOR_VERSION, &minor);
    SDL_LogInfo(SDL_LOG_CATEGORY_APPLICATION, "Initialized OpenGL %d.%d", major, minor);

    std::stringstream title;
    title << "OpenGL " << major << "." << minor;
    SDL_SetWindowTitle(window.get(), title.str().c_str());

    // ImGuiManager handles all ImGui setup and shutdown
    ImGuiManager imguiManager(window.get(), context.get());

    // Scoped application lifetime
    {
      MyApp app;

      app.InitGL();
      app.InitCL();

      mainLoop(window.get(), app);
    } // app destructor runs here, before OpenGL context is destroyed

  }
  catch (const cl::Error& e) {
    SDL_LogError(SDL_LOG_CATEGORY_ERROR, "OpenCL Error (%d - %s): %s", e.err(), oclErrorString(e.err()), e.what());
    return EXIT_FAILURE;
  }
  catch (const std::exception& e) {
    SDL_LogError(SDL_LOG_CATEGORY_ERROR, "A fatal error occurred: %s", e.what());
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}

