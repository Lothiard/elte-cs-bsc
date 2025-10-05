#include <CL/opencl.hpp>
#include <oclutils.hpp>

#include <algorithm>
#include <cstdint>
#include <exception>
#include <iostream>
#include <numeric>
#include <random>
#include <string>
#include <vector>
#include <sstream>

// Problem sizes to benchmark for
constexpr std::size_t MIN_SIZE = 1u << 20;
constexpr std::size_t MAX_SIZE = 1u << 27;

// Method that runs the reduction kernel
std::pair<uint64_t, int32_t> executeReduction(
    cl::Context& context,
    cl::CommandQueue& queue,
    cl::KernelFunctor<cl::Buffer, int32_t>& kernelFunctor,
    std::vector<int32_t>& input)
{
    std::size_t size = input.size();

    cl::Buffer buffer(context, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR,
        sizeof(int32_t) * size, input.data());

    uint64_t total_ns = 0;

    for (std::size_t num_workitems = size / 2; num_workitems != 0; num_workitems >>= 1) {
        int32_t offset = static_cast<int32_t>(size / (num_workitems * 2));

        cl::Event evt = kernelFunctor(
            cl::EnqueueArgs(queue, cl::NDRange(num_workitems)),
            buffer, offset);
        evt.wait();

        cl_ulong start = evt.getProfilingInfo<CL_PROFILING_COMMAND_START>();
        cl_ulong end = evt.getProfilingInfo<CL_PROFILING_COMMAND_END>();
        total_ns += (end - start);
    }

    int32_t gpu_result{};
    queue.enqueueReadBuffer(buffer, CL_TRUE, 0, sizeof(gpu_result), &gpu_result);

    return { total_ns, gpu_result };
}

void benchmarkReductionKernel(
    const std::string& label,
    cl::Context& context,
    cl::CommandQueue& queue,
    cl::KernelFunctor<cl::Buffer, int32_t>& kernelFunctor,
    std::size_t minSize = 1u << 20,
    std::size_t maxSize = 1u << 27)
{
    std::mt19937 rng(1);

    for (std::size_t size = minSize; size <= maxSize; size <<= 1) {
        std::vector<int32_t> input(size);
        std::uniform_int_distribution<int32_t> dist(-256, 255);
        std::generate(input.begin(), input.end(), [&] { return dist(rng); });

        // CPU run
        int64_t cpu_result = std::accumulate(input.begin(), input.end(), int64_t{ 0 });

        // GPU run
        auto [total_ns, gpu_result] = executeReduction(context, queue, kernelFunctor, input);

        double ms = static_cast<double>(total_ns) / 1e6;
        std::cout << "size=" << size << " [" << label << "] time=" << ms << " ms\n";

        if (gpu_result != cpu_result) {
            std::stringstream ss;
            ss << "  <-- mismatch (cpu=" << cpu_result << " gpu=" << gpu_result << ")";
            throw std::runtime_error(ss.str());
        }
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

    // Load and build kernel program
    const std::string sourceCode = oclReadSourcesFromFile("../kernels/krn_reduce_global.cl");
    cl::Program program(context, sourceCode);

    try {
      program.build({ device });
    }
    catch (const cl::Error&) {
      for (auto&& [dev, log] : program.getBuildInfo<CL_PROGRAM_BUILD_LOG>())
        std::cerr << "Build log for " << dev.getInfo<CL_DEVICE_NAME>() << ":\n" << log << "\n";
      throw;
    }

    // Kernel functors
    cl::KernelFunctor<cl::Buffer, int32_t> reduceAssoc(program, "reduce_associative");
    cl::KernelFunctor<cl::Buffer, int32_t> reduceComm(program, "reduce_commutative");

    // Run benchmarks
    benchmarkReductionKernel("associative", context, queue, reduceAssoc, MIN_SIZE, MAX_SIZE);
    benchmarkReductionKernel("commutative", context, queue, reduceComm, MIN_SIZE, MAX_SIZE);
  }
  catch (const cl::Error& err) {
    std::cerr << "OpenCL Error: " << err.what()
              << " (" << err.err() << "==" << oclErrorString(err.err()) << ")\n";
    return EXIT_FAILURE;
  }
  catch (const std::exception& ex) {
    std::cerr << "Error: " << ex.what() << "\n";
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}