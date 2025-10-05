#include <algorithm>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <random>
#include <string>
#include <vector>

#include <CL/opencl.hpp>
#include <oclutils.hpp>

// Problem sizes to benchmark for
constexpr std::size_t MIN_SIZE = 1u << 20;
constexpr std::size_t MAX_SIZE = 1u << 27;

struct IParallelPrimitive {
  virtual ~IParallelPrimitive() = default;

  virtual uint64_t execute(cl::CommandQueue &queue, cl::Context &context,
                           cl::Buffer &inputBuffer, cl::Buffer &outputBuffer,
                           std::size_t size) = 0;
};

// Strategy pattern
struct GlobalReduction : public IParallelPrimitive {

  cl::KernelFunctor<cl::Buffer, int32_t> kernel;

  GlobalReduction(cl::Program &program, const std::string &kernelName)
      : kernel(program, kernelName.c_str()) {}

  uint64_t execute(cl::CommandQueue &queue, cl::Context &,
                   cl::Buffer &inputBuffer, cl::Buffer &outputBuffer,
                   std::size_t size) override {
    uint64_t total_ns = 0;

    for (std::size_t num_workitems = size / 2; num_workitems != 0;
         num_workitems >>= 1) {
      int32_t offset = static_cast<int32_t>(size / (num_workitems * 2));

      cl::Event evt = kernel(cl::EnqueueArgs(queue, cl::NDRange(num_workitems)),
                             inputBuffer, offset);

      evt.wait();

      cl_ulong start = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
      cl_ulong end = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
      total_ns += (end - start);
    }

    queue.enqueueCopyBuffer(inputBuffer, outputBuffer, 0, 0, sizeof(int32_t));
    queue.finish();

    return total_ns;
  }
};

struct WorkGroupReduction : public IParallelPrimitive {
  cl::KernelFunctor<cl::Buffer, cl::Buffer, cl::LocalSpaceArg, uint32_t> kernel;
  std::size_t localSize;

  explicit WorkGroupReduction(cl::Program &program, std::size_t localSize = 256)
      : kernel(program, "reduce_workgroup"), localSize(localSize) {}

  uint64_t execute(cl::CommandQueue &queue, cl::Context &context,
                   cl::Buffer &inputBuffer, cl::Buffer &outputBuffer,
                   std::size_t size) override {

    uint64_t total_ns = 0;

    std::size_t maxGroups = std::ceil(size / localSize);
    cl::Buffer intermediate(context, CL_MEM_READ_WRITE,
                            sizeof(int32_t) * maxGroups);

    std::size_t tree_level = 0;
    cl::Buffer *buff_in = &inputBuffer;
    cl::Buffer *buff_out = &intermediate;

    std::size_t currentSize = size;
    while (currentSize > 1) {
      std::size_t numGroups = std::ceil(currentSize / localSize);

      if (tree_level % 2 == 0) {
        buff_in = &inputBuffer;
        buff_out = &intermediate;
      } else {
        buff_in = &intermediate;
        buff_out = &inputBuffer;
      }

      cl::Event evt =
          kernel(cl::EnqueueArgs(queue, cl::NDRange(numGroups * localSize),
                                 cl::NDRange(localSize)),
                 *buff_in, *buff_out, cl::Local(sizeof(int32_t) * localSize),
                 static_cast<uint32_t>(currentSize));

      evt.wait();

      cl_ulong start = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
      cl_ulong end = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
      total_ns += (end - start);

      currentSize = numGroups;
      ++tree_level;
    }

    queue.enqueueCopyBuffer(*buff_out, outputBuffer, 0, 0, sizeof(int32_t));
    queue.finish();

    return total_ns;
  }
};

struct TwoStageReduction : public IParallelPrimitive {
  cl::KernelFunctor<cl::Buffer, cl::Buffer, cl::LocalSpaceArg, uint32_t>
      kernel_hybrid;                   // kernel for the first stage
  WorkGroupReduction reduce_workgroup; // second stage

  std::size_t localSize;
  cl::Buffer intermediate;

  explicit TwoStageReduction(cl::Program &program, std::size_t localSize_ = 256)
      : kernel_hybrid(program, "hybrid_reduce"), reduce_workgroup(program),
        localSize(localSize_) {}

  uint64_t execute(cl::CommandQueue &queue, cl::Context &context,
                   cl::Buffer &inputBuffer, cl::Buffer &outputBuffer,
                   std::size_t size) override {
    uint64_t total_ns = 0;

    // // First stage: run hybrid_reduce across entire input, produce a single
    // // workgroup worth of elements
    // std::size_t numGroups = /*TODO*/;
    // auto intermediate =
    //     cl::Buffer(context, CL_MEM_READ_WRITE, sizeof(int32_t) * numGroups);
    //
    // cl::Event evt = kernel_hybrid(
    //     cl::EnqueueArgs(queue, cl::NDRange(/*TODO*/),
    //     cl::NDRange(localSize)), inputBuffer, intermediate,
    //     cl::Local(sizeof(int32_t) * localSize), static_cast<uint32_t>(size));
    //
    // evt.wait();
    //
    // cl_ulong s = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
    // cl_ulong e = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
    // total_ns += (e - s);
    //
    // // Second stage: reduce the numGroups results with a single work-group
    // // reduction
    // if (numGroups > 1) {
    //   total_ns += reduce_workgroup.execute(/*TODO*/);
    // } else {
    //   queue.enqueueCopyBuffer(intermediate, outputBuffer, 0, 0,
    //                           sizeof(int32_t));
    // }

    queue.finish();
    return total_ns;
  }
};

void benchmarkReductionKernel(const std::string &label,
                              IParallelPrimitive &strategy,
                              cl::Context &context, cl::CommandQueue &queue,
                              std::size_t minSize = 1u << 20,
                              std::size_t maxSize = 1u << 24) {
  std::mt19937 rng(1);
  std::uniform_int_distribution<int32_t> dist(-256, 255);

  cl::Buffer outputBuf(context, CL_MEM_READ_WRITE, sizeof(int32_t));

  for (std::size_t size = minSize; size <= maxSize; size <<= 1) {
    std::vector<int32_t> input(size);
    std::generate(input.begin(), input.end(), [&] { return dist(rng); });

    int64_t cpu_result =
        std::accumulate(input.begin(), input.end(), int64_t{0});
    cl::Buffer inputBuffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR,
                           sizeof(int32_t) * input.size(), input.data());

    uint64_t total_ns =
        strategy.execute(queue, context, inputBuffer, outputBuf, size);

    double ms = static_cast<double>(total_ns) / 1e6;
    std::cout << "size=" << size << " [" << label << "] time=" << ms << " ms";

    int32_t gpu_result{};
    queue.enqueueReadBuffer(outputBuf, CL_TRUE, 0, sizeof(gpu_result),
                            &gpu_result);

    if (gpu_result != cpu_result)
      std::cout << "  <-- mismatch (cpu=" << cpu_result << " gpu=" << gpu_result
                << ")";
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

    auto platIt = std::find_if(
        platforms.begin(), platforms.end(), [](const cl::Platform &p) {
          return p.getInfo<CL_PLATFORM_VERSION>().find("OpenCL 3.") !=
                 std::string::npos;
        });

    if (platIt == platforms.end())
      throw std::runtime_error("No OpenCL 3.x platform found");

    cl::Platform::setDefault(*platIt);
    cl::Device device = cl::Device::getDefault();
    cl::Context context = cl::Context::getDefault();
    cl::CommandQueue queue(context, device, CL_QUEUE_PROFILING_ENABLE);

    std::cout << "Using device: " << device.getInfo<CL_DEVICE_NAME>() << "\n";

    auto loadAndBuildProgram = [&context,
                                &device](const std::string &fileName) {
      cl::Program program(context, oclReadSourcesFromFile(fileName.c_str()));

      try {
        program.build({device});
      } catch (const cl::Error &) {
        std::cerr << "Error while processing " << fileName << ".\n";
        for (auto &&[dev, log] : program.getBuildInfo<CL_PROGRAM_BUILD_LOG>())
          std::cerr << "Build log for " << dev.getInfo<CL_DEVICE_NAME>()
                    << ":\n"
                    << log << "\n";
        throw;
      }

      return program;
    };

    // Load and build kernel programs
    auto program_global =
        loadAndBuildProgram("../kernels/krn_reduce_global.cl");
    auto program_local = loadAndBuildProgram("../kernels/krn_reduce_local.cl");

    // Create strategies
    GlobalReduction reduce_assoc(program_global, "reduce_associative");
    GlobalReduction reduce_comm(program_global, "reduce_commutative");
    WorkGroupReduction reduce_wg(program_local);
    TwoStageReduction reduce_hybrid(program_local);

    // Run benchmarks
    benchmarkReductionKernel("associative", reduce_assoc, context, queue,
                             MIN_SIZE, MAX_SIZE);
    benchmarkReductionKernel("commutative", reduce_comm, context, queue,
                             MIN_SIZE, MAX_SIZE);
    benchmarkReductionKernel("workgroup", reduce_wg, context, queue, MIN_SIZE,
                             MAX_SIZE);
    benchmarkReductionKernel("hybrid", reduce_hybrid, context, queue, MIN_SIZE,
                             MAX_SIZE);
  } catch (const cl::Error &err) {
    std::cerr << "OpenCL Error: " << err.what() << " (" << err.err() << ")\n";
    return EXIT_FAILURE;
  } catch (const std::exception &ex) {
    std::cerr << "Error: " << ex.what() << "\n";
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}
