#pragma once
#define _USE_MATH_DEFINES

// GLM
#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <glm/gtx/transform.hpp>

// GLEW
#include <GL/glew.h>

// SDL
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>

// Utils
#include "gShaderProgram.h"
#include <GLUtils.hpp>

// OpenCL
#include <CL/opencl.hpp>
#include <oclutils.hpp>
#include <oglutils.hpp>

#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>

struct UpdateInfo {
  float elapsedTimeSec = 0.0f; // Total time since program start
  float deltaTimeSec = 0.0f; // Time since last update
};

class MyApp {
public:
  MyApp();
  ~MyApp();

  void InitGL();
  void InitCL();

  void Update(const UpdateInfo& info);
  void Render();
  void RenderGUI();

  // SDL Event Handlers
  void KeyboardDown(const SDL_KeyboardEvent&);
  void KeyboardUp(const SDL_KeyboardEvent&);
  void MouseMove(const SDL_MouseMotionEvent&);
  void MouseDown(const SDL_MouseButtonEvent&);
  void MouseUp(const SDL_MouseButtonEvent&);
  void MouseWheel(const SDL_MouseWheelEvent&);
  void Resize(int width, int height);
  void OtherEvent(const SDL_Event&);

private:
  // Window
  int windowWidth = 0;
  int windowHeight = 0;

  // OpenGL
  UniqueGlVertexArray vao;
  UniqueGlBuffer      vbo;
  UniqueGlTexture     particleTexture;
  gShaderProgram      shaderProgram;

  // OpenCL 
  cl::Context       context;
  cl::CommandQueue  queue;
  cl::Program       program;
  cl::Kernel        kernelUpdate;
  
  // We need to handle both interop and non-interop cases
  cl::BufferGL      clVboBufferGL;  // Used for OpenGL interop
  cl::Buffer        clVboBuffer;    // Used when OpenGL interop is not available
  cl::Buffer        clVelocities;
  cl::Buffer        clMasses;
  bool              useOpenGLInterop = true;

  // Simulation parameters
  static constexpr int   numParticles = 15000;
  static constexpr float particleSize = 0.01f;
  static constexpr bool  useRingInit = true;
  static constexpr bool  useRandomVelocities = true;
  static constexpr float massiveObjectMass = 1.0f;

  // Application state
  bool simulation_paused = false;
};
