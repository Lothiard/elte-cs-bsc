#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <numeric>
#include <random>
#include <cstdint>

#include <CL/opencl.hpp>
#include <oclutils.hpp>

// Problem sizes to benchmark for
constexpr std::size_t MIN_SIZE = 1u << 20;
constexpr std::size_t MAX_SIZE = 1u << 27;

struct IParallelPrimitive {
  virtual ~IParallelPrimitive() = default;

  virtual uint64_t execute(
    cl::CommandQueue& queue,
    cl::Context& context,
    cl::Buffer& inputBuffer,
    cl::Buffer& outputBuffer,
    std::size_t size) = 0;
};

class NaiveScan : public IParallelPrimitive {
public:
  NaiveScan(cl::Program& prog) :
    kernel(prog, "naive_scan") {
  }

  uint64_t execute(
    cl::CommandQueue& queue,
    cl::Context& context,
    cl::Buffer& inputBuffer,
    cl::Buffer& outputBuffer,
    std::size_t size) override
  {
    using namespace cl;

    uint64_t totalTime = 0;

    Buffer* src = &inputBuffer;
    Buffer* dst = &outputBuffer;

    queue.enqueueCopyBuffer(*src, *dst, 0, 0, sizeof(int32_t) * 1);

    for (unsigned offset = 1; offset < size; offset <<= 1) {
      Event evt = kernel(
        EnqueueArgs(queue,
          NDRange(/*TODO*/)),
        *src, *dst, static_cast<int32_t>(offset));
      evt.wait();
      
      // TODO: Optionally, you may need to copy from 'dst' to 'src' some of the elements

      std::swap(src, dst);

      cl_ulong start = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
      cl_ulong end = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
      totalTime += (end - start);
    }

    // Ensure result ends up in outputBuffer
    if (src != &outputBuffer)
      queue.enqueueCopyBuffer(*src, outputBuffer, 0, 0, size * sizeof(int32_t));

    return totalTime;
  }

private:
  using NaiveFunctor = cl::KernelFunctor<cl::Buffer, cl::Buffer, int32_t>;
  NaiveFunctor kernel;
};

// A variation of Blelloch's scan
class WorkEfficientScan : public IParallelPrimitive {
public:
  WorkEfficientScan(cl::Program& prog)
    : downSweep(prog, "downSweep"), upSweep(prog, "upSweep") {
  }

  uint64_t execute(
    cl::CommandQueue& queue,
    cl::Context& context,
    cl::Buffer& inputBuffer,
    cl::Buffer& outputBuffer,
    std::size_t size) override
  {
    using namespace cl;

    uint64_t totalTime = 0;

    // Copy input into output (which is modified in-place)
    queue.enqueueCopyBuffer(inputBuffer, outputBuffer, 0, 0, size * sizeof(int32_t));

    throw std::logic_error("TODO: WorkEfficientScan");

    // Down-sweep phase
    for (int32_t offset = 1; offset < static_cast<int32_t>(size); offset *= 2) {
      std::size_t num_workitems = size / (1/*TODO*/);
      Event evt = downSweep(
        EnqueueArgs(queue,
          NDRange(num_workitems)),
        outputBuffer, offset);
      evt.wait();

      cl_ulong start = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
      cl_ulong end = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
      totalTime += (end - start);
    }

    // Up-sweep phase
    for (int32_t offset = static_cast<int32_t>(size) / 4; offset > 0; offset /= 2) {
      std::size_t num_workitems = size / (1/*TODO*/);
      Event evt = upSweep(
        EnqueueArgs(queue,
          NDRange(num_workitems)),
        outputBuffer, offset);
      evt.wait();

      cl_ulong start = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
      cl_ulong end = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
      totalTime += (end - start);
    }

    return totalTime;
  }

private:
  using SweepFunctor = cl::KernelFunctor<cl::Buffer, int32_t>;
  SweepFunctor downSweep;
  SweepFunctor upSweep;
};


void benchmarkScan(
  const std::string& label,
  IParallelPrimitive& strategy,
  cl::Context& context,
  cl::CommandQueue& queue,
  std::size_t minSize = 1u << 20,
  std::size_t maxSize = 1u << 24)
{
  std::mt19937 rng(1);
  std::uniform_int_distribution<int32_t> dist(-256, 255);


  for (std::size_t size = minSize; size <= maxSize; size <<= 1) {
    std::vector<int32_t> input(size);
    std::generate(input.begin(), input.end(), [&] { return dist(rng); });

    cl::Buffer inputBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR,
      sizeof(int32_t) * size, input.data());
    cl::Buffer outputBuf(context, CL_MEM_READ_WRITE, sizeof(int32_t) * size);

    uint64_t total_ns = strategy.execute(queue, context, inputBuffer, outputBuf, size);

    double ms = static_cast<double>(total_ns) / 1e6;
    std::cout << "size=" << size << " [" << label << "] time=" << ms << " ms";

    std::vector<int32_t> output(size);
    queue.enqueueReadBuffer(outputBuf, CL_TRUE, 0, sizeof(int32_t) * output.size(), output.data());

    int32_t prefixSum = 0;
    for (int i = 0; i < size; ++i) {
      prefixSum += input[i];
      input[i] = prefixSum;
    }

    // check outputs
    for (int i = 0; i < size; ++i) {
      if (input[i] == output[i])
        continue;

      std::cout << "  <-- mismatch at idx=" << i << " (cpu=" << input[i] << " gpu=" << output[i] << ")";
      std::cout << "\n";
      return;
    }
    std::cout << "\n";
  }
}

int main() {
  try {
    // Select platform (prefer OpenCL 3.x)
    std::vector<cl::Platform> platforms;
    cl::Platform::get(&platforms);
    if (platforms.empty())
      throw std::runtime_error("No OpenCL platforms found");

    auto platIt = std::find_if(platforms.begin(), platforms.end(),
      [](const cl::Platform& p) {
        return p.getInfo<CL_PLATFORM_VERSION>().find("OpenCL 3.") != std::string::npos;
      });

    if (platIt == platforms.end())
      throw std::runtime_error("No OpenCL 3.x platform found");

    cl::Platform::setDefault(*platIt);
    cl::Device device = cl::Device::getDefault();
    cl::Context context = cl::Context::getDefault();
    cl::CommandQueue queue(context, device, CL_QUEUE_PROFILING_ENABLE);

    std::cout << "Using device: " << device.getInfo<CL_DEVICE_NAME>() << "\n";

    auto loadAndBuildProgram = [&context, &device](const std::string& fileName) {
      cl::Program program(context, oclReadSourcesFromFile(fileName.c_str()));

      try {
        program.build({ device });
      }
      catch (const cl::Error&) {
        std::cerr << "Error while processing " << fileName << ".\n";
        for (auto&& [dev, log] : program.getBuildInfo<CL_PROGRAM_BUILD_LOG>())
          std::cerr << "Build log for " << dev.getInfo<CL_DEVICE_NAME>() << ":\n" << log << "\n";
        throw;
      }

      return program;
      };

    // Load and build kernel programs
    auto program_global = loadAndBuildProgram("../kernels/krn_scan.cl");

    // Create strategies
    NaiveScan naiveScan(program_global);
    WorkEfficientScan workEfficientScan(program_global);

    // Run benchmarks
    benchmarkScan("naive", naiveScan, context, queue, MIN_SIZE, MAX_SIZE);
    benchmarkScan("work-efficient", workEfficientScan, context, queue, MIN_SIZE, MAX_SIZE);
  }
  catch (const cl::Error& err) {
    std::cerr << "OpenCL Error: " << err.what() << " (" << err.err() << ")\n";
    return EXIT_FAILURE;
  }
  catch (const std::exception& ex) {
    std::cerr << "Error: " << ex.what() << "\n";
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}
