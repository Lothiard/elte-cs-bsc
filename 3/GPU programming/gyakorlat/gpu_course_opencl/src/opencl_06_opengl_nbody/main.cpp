// GL
#include <GL/glew.h>

// SDL
#include <SDL3/SDL.h>

// Imgui
#include <imgui.h>
#include <imgui_impl_sdl3.h>
#include <imgui_impl_opengl3.h>

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
    ImGui_ImplSDL3_InitForOpenGL(window, context);
    ImGui_ImplOpenGL3_Init();
  }
  ~ImGuiManager() {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplSDL3_Shutdown();
    ImGui::DestroyContext();
  }
  ImGuiManager(const ImGuiManager&) = delete;
  ImGuiManager& operator=(const ImGuiManager&) = delete;
};

// Helper function to set up all OpenGL attributes
void setupSdlGlAttributes() {
  // Request a core profile context for modern OpenGL
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);
#ifdef _DEBUG
  // Enable debug context in debug builds for more verbose error messages
  SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_DEBUG_FLAG);
#endif
  // Set color and buffer sizes
  SDL_GL_SetAttribute(SDL_GL_BUFFER_SIZE, 32);
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
  Uint64 lastTick = SDL_GetTicks();

  while (!quit) {
    // Process all pending events
    SDL_Event ev;
    while (SDL_PollEvent(&ev)) {
      ImGui_ImplSDL3_ProcessEvent(&ev);
      const bool isMouseCaptured = ImGui::GetIO().WantCaptureMouse;
      const bool isKeyboardCaptured = ImGui::GetIO().WantCaptureKeyboard;

      switch (ev.type) {
      case SDL_EVENT_QUIT:
        quit = true;
        break;
      case SDL_EVENT_KEY_DOWN:
        if (ev.key.key == SDLK_ESCAPE) quit = true;

        // ALT+ENTER toggles fullscreen
        if (ev.key.key == SDLK_RETURN && (ev.key.mod & SDL_KMOD_ALT)) {
          Uint32 flags = (SDL_GetWindowFlags(window) & SDL_WINDOW_FULLSCREEN) ? 0 : SDL_WINDOW_FULLSCREEN;
          SDL_SetWindowFullscreen(window, flags);
        }
        // CTRL+F1 toggles ImGui visibility
        if (ev.key.key == SDLK_F1 && (ev.key.mod & SDL_KMOD_CTRL)) {
          showImGui = !showImGui;
        }
        if (!isKeyboardCaptured) app.KeyboardDown(ev.key);
        break;
      case SDL_EVENT_KEY_UP:
        if (!isKeyboardCaptured) app.KeyboardUp(ev.key);
        break;
      case SDL_EVENT_MOUSE_BUTTON_DOWN:
        if (!isMouseCaptured) app.MouseDown(ev.button);
        break;
      case SDL_EVENT_MOUSE_BUTTON_UP:
        if (!isMouseCaptured) app.MouseUp(ev.button);
        break;
      case SDL_EVENT_MOUSE_WHEEL:
        if (!isMouseCaptured) app.MouseWheel(ev.wheel);
        break;
      case SDL_EVENT_MOUSE_MOTION:
        if (!isMouseCaptured) app.MouseMove(ev.motion);
        break;
      case SDL_EVENT_WINDOW_RESIZED:
      case SDL_EVENT_WINDOW_SHOWN:
        int w, h;
        SDL_GetWindowSize(window, &w, &h);
        app.Resize(w, h);
        break;
      default:
        app.OtherEvent(ev);
      }
    }

    // Calculate time delta for the update
    const Uint64 currentTick = SDL_GetTicks();
    UpdateInfo updateInfo{
        static_cast<float>(currentTick) / 1000.0f,
        static_cast<float>(currentTick - lastTick) / 1000.0f
    };
    lastTick = currentTick;

    // Update and render application logic
    app.Update(updateInfo);

    app.Render();

    // Render ImGui UI
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplSDL3_NewFrame();
    ImGui::NewFrame();
    if (showImGui) app.RenderGUI();
    ImGui::Render();
    ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

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
    UniqueWindow window(SDL_CreateWindow("Hello SDL & OpenGL!", 1280, 720, SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE));
    if (!window) throw SdlException("Window creation failed.");

    UniqueGlContext context(SDL_GL_CreateContext(window.get()));
    if (!context) throw SdlException("OpenGL context creation failed.");

    // Enable VSync
    SDL_GL_SetSwapInterval(1);

    // Initialize GLEW
    if (GLenum err = glewInit(); err != GLEW_OK) {
      throw std::runtime_error("GLEW initialization failed: " + std::string(reinterpret_cast<const char*>(glewGetErrorString(err))));
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

