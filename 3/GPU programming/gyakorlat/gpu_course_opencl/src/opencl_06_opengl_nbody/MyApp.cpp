#include "MyApp.h"

#include <cmath>
#include <cstdlib>
#include <ctime>
#include <deque>
#include <filesystem>
#include <numeric>
#include <random>

#include <imgui.h>

enum class AssetType { Asset, Kernel, Shader };

namespace {
  const std::filesystem::path rootPath = "../../../src/opencl_06_opengl_nbody";

  template <AssetType T>
  std::string PathTo(const std::string& filename) {
    std::filesystem::path result;

    if constexpr (T == AssetType::Asset)
      result = rootPath / "assets" / filename;
    else if constexpr (T == AssetType::Kernel)
      result = rootPath / "kernels" / filename;
    else if constexpr (T == AssetType::Shader)
      result = rootPath / "shaders" / filename;
    else
      result = rootPath / filename;

    if (!std::filesystem::exists(result))
      throw std::runtime_error("File not found: " + result.string());

    return result.string();
  }

  // Keep some history for smoother graphs
  constexpr std::size_t MAX_HISTORY = 120;
  std::deque<float> frameTimes;
  std::deque<float> kernelTimes;

  void addSample(std::deque<float>& buffer, float value) {
    if (buffer.size() >= MAX_HISTORY)
      buffer.pop_front();
    buffer.push_back(value);
  }

  float average(const std::deque<float>& buffer) {
    if (buffer.empty()) return 0.0f;
    return std::accumulate(buffer.begin(), buffer.end(), 0.0f) / buffer.size();
  }

}

MyApp::MyApp() = default;
MyApp::~MyApp() = default;

void MyApp::InitGL() {
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

  // Create vertex buffer for particles
  vbo = createBuffer();
  glBindBuffer(GL_ARRAY_BUFFER, *vbo);
  glBufferData(GL_ARRAY_BUFFER, numParticles * sizeof(glm::vec2), nullptr, GL_DYNAMIC_DRAW);
  glBindBuffer(GL_ARRAY_BUFFER, 0);

  // Create vertex array object to handle vertex properties during rendering
  vao = createVertexArray();
  glBindVertexArray(*vao);
  glBindBuffer(GL_ARRAY_BUFFER, *vbo); // Attach VBO to VAO
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, sizeof(glm::vec2), (void*)0);
  glEnableVertexAttribArray(0);
  glBindVertexArray(0);

  // Setup particle shader
  shaderProgram.AttachShader(GL_VERTEX_SHADER, PathTo<AssetType::Shader>("particle.vert"));
  shaderProgram.AttachShader(GL_GEOMETRY_SHADER, PathTo<AssetType::Shader>("particle.geom"));
  shaderProgram.AttachShader(GL_FRAGMENT_SHADER, PathTo<AssetType::Shader>("particle.frag"));
  shaderProgram.BindAttribLoc(0, "vs_in_pos");
  if (!shaderProgram.LinkProgram())
    throw std::runtime_error("Failed to Link shader program.");

  // Load particle texture
  const auto image = ImageFromFile(PathTo<AssetType::Asset>("particle.png"));
  particleTexture = createTexture<GL_TEXTURE_2D>();
  glTextureStorage2D(*particleTexture, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
  glTextureSubImage2D(*particleTexture, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());
  glGenerateTextureMipmap(*particleTexture);
  glTextureParameteri(*particleTexture, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTextureParameteri(*particleTexture, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  float maxAnisotropy = 1.0f;
  glGetFloatv(GL_MAX_TEXTURE_MAX_ANISOTROPY, &maxAnisotropy);
  glTextureParameterf(*particleTexture, GL_TEXTURE_MAX_ANISOTROPY, maxAnisotropy);
}

void MyApp::InitCL() {
  try {
    std::cout << "DEBUG: Starting InitCL()" << std::endl;
    
    // Try to create a shared context for OpenCL/OpenGL interop
    bool glSharingSuccessful = oclCreateContextFromCurrentGLContext(context);
    
    // The glSharingSuccessful flag doesn't seem to be reliable - we're getting segfaults later
    // so let's force non-interop mode for now
    useOpenGLInterop = false;
    std::cout << "DEBUG: Forcing non-interop mode for stability" << std::endl;
    
    if (!glSharingSuccessful) {
      std::cout << "DEBUG: OpenGL sharing not successful, creating regular context" << std::endl;
      
      // Create a regular context with any available device
      std::vector<cl::Platform> platforms;
      cl::Platform::get(&platforms);
      if (platforms.empty()) {
        throw cl::Error(-1, "No OpenCL platforms found");
      }
      
      // Use the first platform
      cl_context_properties properties[] = { 
        CL_CONTEXT_PLATFORM, (cl_context_properties)(platforms[0])(), 
        0 
      };
      
      try {
        context = cl::Context(CL_DEVICE_TYPE_GPU, properties);
        std::cout << "Created regular OpenCL context without OpenGL sharing" << std::endl;
        std::cout << "WARNING: No OpenGL interoperation will be available!" << std::endl;
        useOpenGLInterop = false;
      } catch (cl::Error& e) {
        std::cerr << "Failed to create regular OpenCL context: " << e.what() << " (" << e.err() << ")" << std::endl;
        throw;
      }
    } else {
      std::cout << "DEBUG: Context created, but forcing non-interop mode anyway" << std::endl;
    }
    
    std::cout << "DEBUG: Getting device information" << std::endl;
  } catch (std::exception& e) {
    std::cerr << "Exception in InitCL initialization: " << e.what() << std::endl;
    throw;
  }

  try {
    std::cout << "DEBUG: Getting device info from context" << std::endl;
    const auto devices = context.getInfo<CL_CONTEXT_DEVICES>();
    if (devices.empty()) {
      throw std::runtime_error("No OpenCL devices in context");
    }
    
    auto device = devices.front();
    std::cout << "Using device: " << device.getInfo<CL_DEVICE_NAME>() << '\n';
    
    std::cout << "DEBUG: Creating command queue" << std::endl;
    queue = cl::CommandQueue(context, device);

    // Build OpenCL program
    std::cout << "DEBUG: Reading kernel source" << std::endl;
    const auto sourceCode = oclReadSourcesFromFile(PathTo<AssetType::Kernel>("GLinterop.cl"));
    std::cout << "DEBUG: Creating program" << std::endl;
    program = cl::Program(context, sourceCode);
    
    try {
      std::cout << "DEBUG: Building program" << std::endl;
      program.build(devices);
    }
    catch (const cl::Error&) {
      std::cout << "DEBUG: Error building program" << std::endl;
      for (auto&& [dev, log] : program.getBuildInfo<CL_PROGRAM_BUILD_LOG>())
        std::cerr << "Build log for " << dev.getInfo<CL_DEVICE_NAME>() << ":\n" << log << "\n";
      throw;
    }
    
    std::cout << "DEBUG: Creating kernel" << std::endl;
    kernelUpdate = cl::Kernel(program, "update");
    std::cout << "DEBUG: Kernel created successfully" << std::endl;
  } catch (std::exception& e) {
    std::cerr << "Exception in OpenCL program setup: " << e.what() << std::endl;
    throw;
  }

  try {
    std::cout << "DEBUG: Creating velocity buffer" << std::endl;
    clVelocities = cl::Buffer(context, CL_MEM_READ_WRITE, numParticles * sizeof(glm::vec2));
    
    std::cout << "DEBUG: Creating masses buffer" << std::endl;
    clMasses = cl::Buffer(context, CL_MEM_READ_WRITE, numParticles * sizeof(float));
    
    // Since we're forcing non-interop mode, just create the regular buffer
    std::cout << "DEBUG: Creating regular position buffer (interop disabled)" << std::endl;
    clVboBuffer = cl::Buffer(context, CL_MEM_READ_WRITE, numParticles * sizeof(glm::vec2));
    std::cout << "DEBUG: Regular position buffer created successfully" << std::endl;
  } catch (std::exception& e) {
    std::cerr << "Exception in buffer creation: " << e.what() << std::endl;
    throw;
  }

  try {
    std::cout << "DEBUG: Initializing particle data" << std::endl;
    
    // Initialize particle data
    std::vector<float> masses(numParticles, 1.f);
    std::cout << "DEBUG: Writing masses to buffer" << std::endl;
    queue.enqueueWriteBuffer(clMasses, CL_TRUE, 0, masses.size() * sizeof(float), masses.data());

    std::vector<glm::vec2> velocities(numParticles, glm::vec2{});
    if (useRandomVelocities) {
      std::cout << "DEBUG: Generating random velocities" << std::endl;
      for (size_t i = 0; i < velocities.size(); i += 2) {
        double angle = i / double(velocities.size() / 2) * (2 * M_PI);
        velocities[i].x = static_cast<float>(-std::cos(angle) * 1.7);
        velocities[i].y = static_cast<float>(std::sin(angle) * 1.7);
      }
    }
    
    std::cout << "DEBUG: Writing velocities to buffer" << std::endl;
    queue.enqueueWriteBuffer(clVelocities, CL_TRUE, 0, velocities.size() * sizeof(glm::vec2), velocities.data());
    std::cout << "DEBUG: Particle data initialized successfully" << std::endl;
  } catch (std::exception& e) {
    std::cerr << "Exception in particle data initialization: " << e.what() << std::endl;
    throw;
  }

  try {
    std::cout << "DEBUG: Initializing positions" << std::endl;
    // Initialize positions
    std::vector<glm::vec2> positions(numParticles);
    if (useRingInit) {
      std::cout << "DEBUG: Using ring initialization" << std::endl;
      for (int i = 0; i < numParticles; ++i) {
        float angle = (static_cast<float>(i) / numParticles) * 2.0f * M_PI;
        float r = 0.25f;
        positions[i] = glm::vec2(r * std::sin(angle), r * std::cos(angle));
      }
    }
    else {
      std::cout << "DEBUG: Using random initialization" << std::endl;
      std::mt19937 rng(std::random_device{}());
      std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
      std::generate(positions.begin(), positions.end(), [&] { return glm::vec2{ dist(rng), dist(rng) }; });
    }

    std::cout << "DEBUG: Writing positions to OpenGL buffer" << std::endl;
    // Initialize OpenGL buffer with positions
    glBindBuffer(GL_ARRAY_BUFFER, *vbo);
    if (glm::vec2* ptr = static_cast<glm::vec2*>(glMapBuffer(GL_ARRAY_BUFFER, GL_WRITE_ONLY))) {
      std::copy(positions.begin(), positions.end(), ptr);
      glUnmapBuffer(GL_ARRAY_BUFFER);
      std::cout << "DEBUG: Successfully mapped and copied to OpenGL buffer" << std::endl;
    } else {
      std::cerr << "WARNING: Failed to map OpenGL buffer" << std::endl;
    }
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    
    // If not using interop, also initialize the OpenCL buffer with positions
    if (!useOpenGLInterop) {
      std::cout << "DEBUG: Writing positions to separate OpenCL buffer (non-interop mode)" << std::endl;
      queue.enqueueWriteBuffer(clVboBuffer, CL_TRUE, 0, positions.size() * sizeof(glm::vec2), positions.data());
    }

    std::cout << "DEBUG: Setting kernel arguments" << std::endl;
    // Set kernel arguments
    kernelUpdate.setArg(0, clVelocities);
    std::cout << "DEBUG: Using clVboBuffer for kernel arg 1 (non-interop)" << std::endl;
    kernelUpdate.setArg(1, clVboBuffer);
    kernelUpdate.setArg(2, clMasses);
    std::cout << "DEBUG: InitCL completed successfully" << std::endl;
  } catch (std::exception& e) {
    std::cerr << "Exception in positions initialization or kernel setup: " << e.what() << std::endl;
    throw;
  }
}

void MyApp::Update(const UpdateInfo& info) {
  if (!simulation_paused) {
    try {
      float deltaTime = std::clamp(info.deltaTimeSec, 0.0000001f, 0.001f);
      kernelUpdate.setArg(3, deltaTime);
      
      static bool firstUpdate = true;
      if (firstUpdate) {
        std::cout << "DEBUG: First update call" << std::endl;
        firstUpdate = false;
      }

      if (useOpenGLInterop) {
        // Using OpenGL-OpenCL interop
        try {
          if (firstUpdate) std::cout << "DEBUG: Using interop path" << std::endl;
          std::vector<cl::Memory> glObjects{ clVboBufferGL };
          queue.enqueueAcquireGLObjects(&glObjects);
          queue.enqueueNDRangeKernel(kernelUpdate, cl::NullRange, cl::NDRange(numParticles));
          queue.enqueueReleaseGLObjects(&glObjects);
          queue.finish();
        } catch (std::exception& e) {
          std::cerr << "Exception in interop update path: " << e.what() << std::endl;
          throw;
        }
      } else {
        // Non-interop mode: run OpenCL kernel then manually copy data to OpenGL buffer
        try {
          if (firstUpdate) std::cout << "DEBUG: Using non-interop path" << std::endl;
          queue.enqueueNDRangeKernel(kernelUpdate, cl::NullRange, cl::NDRange(numParticles));
          queue.finish();
          
          // Copy positions from OpenCL to CPU
          std::vector<glm::vec2> positions(numParticles);
          queue.enqueueReadBuffer(clVboBuffer, CL_TRUE, 0, positions.size() * sizeof(glm::vec2), positions.data());
          
          // Copy positions from CPU to OpenGL
          glBindBuffer(GL_ARRAY_BUFFER, *vbo);
          if (glm::vec2* ptr = static_cast<glm::vec2*>(glMapBuffer(GL_ARRAY_BUFFER, GL_WRITE_ONLY))) {
            std::copy(positions.begin(), positions.end(), ptr);
            glUnmapBuffer(GL_ARRAY_BUFFER);
          } else {
            std::cerr << "WARNING: Failed to map OpenGL buffer during update" << std::endl;
          }
          glBindBuffer(GL_ARRAY_BUFFER, 0);
        } catch (std::exception& e) {
          std::cerr << "Exception in non-interop update path: " << e.what() << std::endl;
          throw;
        }
      }
    } catch (std::exception& e) {
      std::cerr << "Exception in Update: " << e.what() << std::endl;
      throw;
    }
  }

  // Skip metrics for now
}

void MyApp::Render() {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glDisable(GL_DEPTH_TEST);
  glDepthMask(GL_FALSE);

  shaderProgram.On();
  shaderProgram.SetUniform("particle_size", particleSize);
  shaderProgram.SetTexture("tex0", 0, *particleTexture);

  glBindVertexArray(*vao);
  glDrawArrays(GL_POINTS, 0, numParticles);
  glBindVertexArray(0);

  shaderProgram.Off();
}

void MyApp::RenderGUI()
{
  // ImGui rendering logic would go here
  //ImGui::ShowDemoWindow();

  ImGui::Begin("Performance");

  // === FPS ===
  float avgFrame = average(frameTimes);
  float fps = avgFrame > 0.0f ? 1000.0f / avgFrame : 0.0f;
  ImGui::Text("Frame time: %.2f ms (%.1f FPS)", avgFrame, fps);
  auto vec_frameTimes = std::vector<float>(frameTimes.begin(), frameTimes.end());
  ImGui::PlotLines("Frame Time (ms)", vec_frameTimes.data(),
    static_cast<int>(frameTimes.size()), 0, nullptr, 0.0f, 50.0f,
    ImVec2(0, 60));

  // === Kernel timing ===
  ImGui::Separator();
  float avgKernel = average(kernelTimes);
  ImGui::Text("Kernel time: %.3f ms (avg over %zu frames)", avgKernel, kernelTimes.size());
  auto vec_kernelTimes = std::vector<float>(kernelTimes.begin(), kernelTimes.end());
  ImGui::PlotLines("Kernel Time (ms)", vec_kernelTimes.data(),
    static_cast<int>(kernelTimes.size()), 0, nullptr, 0.0f, avgKernel * 3.0f,
    ImVec2(0, 60));

  // === Compute�Render Ratio ===
  ImGui::Separator();
  if (avgFrame > 0.0f)
    ImGui::Text("GPU compute load: %.1f%%", (avgKernel / avgFrame) * 100.0f);

  // === Controls ===
  ImGui::Separator();
  ImGui::Text("Simulation Controls");
  ImGui::Checkbox("Pause Simulation", &simulation_paused);

  ImGui::End();
}

void MyApp::KeyboardDown(const SDL_KeyboardEvent&) {}
void MyApp::KeyboardUp(const SDL_KeyboardEvent&) {}
void MyApp::MouseMove(const SDL_MouseMotionEvent&) {}
void MyApp::MouseDown(const SDL_MouseButtonEvent&) {}
void MyApp::MouseUp(const SDL_MouseButtonEvent&) {}
void MyApp::MouseWheel(const SDL_MouseWheelEvent&) {}
void MyApp::OtherEvent(const SDL_Event&) {}

void MyApp::Resize(int width, int height) {
  glViewport(0, 0, width, height);
  windowWidth = width;
  windowHeight = height;
}