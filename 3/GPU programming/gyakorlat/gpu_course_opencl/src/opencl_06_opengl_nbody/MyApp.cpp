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
  if (!oclCreateContextFromCurrentGLContext(context))
    throw cl::Error(CL_INVALID_CONTEXT, "Failed to create shared CL/GL context");

  const auto devices = context.getInfo<CL_CONTEXT_DEVICES>();
  auto device = devices.front();
  std::cout << "Using device: " << device.getInfo<CL_DEVICE_NAME>() << '\n';
  queue = cl::CommandQueue(context, device);

  // Build OpenCL program
  const auto sourceCode = oclReadSourcesFromFile(PathTo<AssetType::Kernel>("GLinterop.cl"));
  program = cl::Program(context, sourceCode);
  try {
    program.build(devices);
  }
  catch (const cl::Error&) {
    for (auto&& [dev, log] : program.getBuildInfo<CL_PROGRAM_BUILD_LOG>())
      std::cerr << "Build log for " << dev.getInfo<CL_DEVICE_NAME>() << ":\n" << log << "\n";
    throw;
  }
  kernelUpdate = cl::Kernel(program, "update");

  // Shared GL/CL buffer
  clVboBuffer = cl::BufferGL(context, CL_MEM_WRITE_ONLY, *vbo);
  clVelocities = cl::Buffer(context, CL_MEM_READ_WRITE, numParticles * sizeof(glm::vec2));
  clMasses = cl::Buffer(context, CL_MEM_READ_WRITE, numParticles * sizeof(float));

  // Initialize particle data
  std::vector<float> masses(numParticles, 1.f);
  queue.enqueueWriteBuffer(clMasses, CL_TRUE, 0, masses.size() * sizeof(float), masses.data());

  std::vector<glm::vec2> velocities(numParticles, glm::vec2{});
  if (useRandomVelocities)
    for (size_t i = 0; i < velocities.size(); i += 2) {
      double angle = i / double(velocities.size() / 2) * (2 * M_PI);
      velocities[i].x = static_cast<float>(-std::cos(angle) * 1.7);
      velocities[i].y = static_cast<float>(std::sin(angle) * 1.7);
    }
  queue.enqueueWriteBuffer(clVelocities, CL_TRUE, 0, velocities.size() * sizeof(glm::vec2), velocities.data());

  // Initialize positions
  std::vector<glm::vec2> positions(numParticles);
  if (useRingInit) {
    for (int i = 0; i < numParticles; ++i) {
      float angle = (static_cast<float>(i) / numParticles) * 2.0f * M_PI;
      float r = 0.25f;
      positions[i] = glm::vec2(r * std::sin(angle), r * std::cos(angle));
    }
  }
  else {
    std::mt19937 rng(std::random_device{}());
    std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
    std::generate(positions.begin(), positions.end(), [&] { return glm::vec2{ dist(rng), dist(rng) }; });
  }

  glBindBuffer(GL_ARRAY_BUFFER, *vbo);
  if (glm::vec2* ptr = static_cast<glm::vec2*>(glMapBuffer(GL_ARRAY_BUFFER, GL_WRITE_ONLY))) {
    std::copy(positions.begin(), positions.end(), ptr);
    glUnmapBuffer(GL_ARRAY_BUFFER);
  }
  glBindBuffer(GL_ARRAY_BUFFER, 0);

  // Set kernel arguments
  kernelUpdate.setArg(0, clVelocities);
  kernelUpdate.setArg(1, clVboBuffer);
  kernelUpdate.setArg(2, clMasses);
}

void MyApp::Update(const UpdateInfo& info) {
  if (!simulation_paused) {
    float deltaTime = std::clamp(info.deltaTimeSec, 0.0000001f, 0.001f);
    kernelUpdate.setArg(3, deltaTime);

    std::vector<cl::Memory> glObjects{ clVboBuffer };
    queue.enqueueAcquireGLObjects(&glObjects);
    queue.enqueueNDRangeKernel(kernelUpdate, cl::NullRange, cl::NDRange(numParticles));
    queue.enqueueReleaseGLObjects(&glObjects);
    queue.finish();
  }

  addSample(frameTimes, info.deltaTimeSec * 1000);
  addSample(kernelTimes, SDL_GetTicks() - info.elapsedTimeSec * 1000);
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

  // === Compute–Render Ratio ===
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