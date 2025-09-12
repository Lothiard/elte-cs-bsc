#include <algorithm>
#include <cstdint>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

#include <CL/opencl.hpp>
#include <oclutils.hpp>

constexpr std::size_t NUM_ELEMENTS = 2000;

int main() {
    try {
        // Create input vectors of fixed-width integers (int32_t matches OpenCL
        // `int` = 32-bit)
        std::vector<int32_t> A(NUM_ELEMENTS), B(NUM_ELEMENTS);
        std::iota(A.begin(), A.end(), 0);
        std::transform(A.begin(), A.end(), B.begin(), [](int32_t x) {
            return static_cast<int32_t>(NUM_ELEMENTS) - x;
        });

        // Select platform (prefer OpenCL 3.x)
        std::vector<cl::Platform> platforms;
        cl::Platform::get(&platforms);

        auto platIt = std::find_if(
            platforms.begin(), platforms.end(), [](const cl::Platform& p) {
                return p.getInfo<CL_PLATFORM_VERSION>().find("OpenCL 3.") !=
                       std::string::npos;
            });

        if (platIt == platforms.end())
            throw std::runtime_error("No OpenCL 3.x platform found");

        // From the chosen platform, get the default Context and Device
        //   Note: Alternatively you may use oclCreateContextBy, useful in a
        //   multi-device system
        cl::Platform::setDefault(*platIt);
        cl::Device device = cl::Device::getDefault();
        cl::Context context = cl::Context::getDefault();
        cl::CommandQueue queue(context, device);

        std::cout << "Using device: " << device.getInfo<CL_DEVICE_NAME>()
                  << "\n";

        // Load and build kernel program
        const std::string sourceCode =
            oclReadSourcesFromFile("../kernels/krn_vectoradd.cl");
        cl::Program program(context, sourceCode);

        try {
            program.build({device});
        } catch (const cl::Error&) {
            for (auto&& [dev, log] :
                 program.getBuildInfo<CL_PROGRAM_BUILD_LOG>())
                std::cerr << "Build log for " << dev.getInfo<CL_DEVICE_NAME>()
                          << ":\n"
                          << log << "\n";
            throw;
        }

        // Allocate buffers (also copy from host when defined)
        cl::Buffer bufferA(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                           sizeof(int32_t) * NUM_ELEMENTS,
                           &A[0]); // &A[0] <=> A.data()
        cl::Buffer bufferB(context, CL_MEM_READ_ONLY,
                           sizeof(int32_t) * NUM_ELEMENTS);
        cl::Buffer bufferC(context, CL_MEM_WRITE_ONLY,
                           sizeof(int32_t) * NUM_ELEMENTS);

        // Explicit copy from host to device
        queue.enqueueWriteBuffer(bufferB, CL_TRUE, 0,
                                 sizeof(int32_t) * NUM_ELEMENTS, B.data());

        // Kernel creation and launch

        // Old (explicit) style:
        //
        // cl::Kernel kernel(program, "vector_add");
        // kernel.setArg(0, bufferA);
        // kernel.setArg(1, bufferB);
        // kernel.setArg(2, bufferC);
        //
        // queue.enqueueNDRangeKernel(
        //     kernel,
        //     cl::NullRange,
        //     cl::NDRange(NUM_ELEMENTS),
        //     cl::NullRange
        // );

        // Modern functor style:

        cl::KernelFunctor<cl::Buffer, cl::Buffer, cl::Buffer> vector_add(
            program, "vector_add");

        vector_add(cl::EnqueueArgs(queue, cl::NDRange(NUM_ELEMENTS)), bufferA,
                   bufferB, bufferC);

        // Read results
        std::vector<int32_t> C(NUM_ELEMENTS);
        queue.enqueueReadBuffer(bufferC, CL_TRUE, 0,
                                sizeof(int32_t) * NUM_ELEMENTS, C.data());

        // Verify results (print first 10 for sanity)
        for (std::size_t i = 0; i < std::min<std::size_t>(NUM_ELEMENTS, 10);
             ++i)
            std::cout << A[i] << " + " << B[i] << " = " << C[i] << "\n";

    } catch (const cl::Error& err) {
        std::cerr << "OpenCL Error: " << err.what() << " (" << err.err()
                  << "==" << oclErrorString(err.err()) << ")\n";
        return EXIT_FAILURE;
    } catch (const std::exception& ex) {
        std::cerr << "Error: " << ex.what() << "\n";
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
