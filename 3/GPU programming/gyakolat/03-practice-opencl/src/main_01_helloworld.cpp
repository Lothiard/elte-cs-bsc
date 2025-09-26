#include <CL/opencl.hpp>
#include <iostream>

int main() {
  try {
    std::vector<cl::Platform> platforms;
    cl::Platform::get(&platforms);
    
    if (platforms.empty()) {
      std::cout << "No OpenCL platforms found." << std::endl;
      return 1;
    }

    std::cout << "Found " << platforms.size() << " OpenCL platform(s):\n";
    for (const auto& platform : platforms) {
      std::string platformName = platform.getInfo<CL_PLATFORM_NAME>();
      std::cout << "Platform: " << platformName << "\n";
      std::cout << "  Version: " << platform.getInfo<CL_PLATFORM_VERSION>() << "\n";
      std::cout << "\n";

      std::vector<cl::Device> devices;
      platform.getDevices(CL_DEVICE_TYPE_ALL, &devices);

      for (const auto& device : devices) {
        std::string deviceName = device.getInfo<CL_DEVICE_NAME>();;
        std::cout << "  Device: " << deviceName << "\n";
        std::cout << "    Max Freq:              " << device.getInfo<CL_DEVICE_MAX_CLOCK_FREQUENCY>() << "\n";
        std::cout << "    Max CUs:               " << device.getInfo<CL_DEVICE_MAX_COMPUTE_UNITS>() << "\n";
        std::cout << "    Local mem size:        " << device.getInfo<CL_DEVICE_LOCAL_MEM_SIZE>() << "\n";
        std::cout << "    Global mem cache size: " << device.getInfo<CL_DEVICE_GLOBAL_MEM_CACHE_SIZE>() << "\n";
        std::cout << "    Global mem size:       " << device.getInfo<CL_DEVICE_GLOBAL_MEM_SIZE>() << "\n";
      }
    }
  }
  catch (const cl::Error& err) {
    std::cerr << "OpenCL Error: " << err.what() << " (" << err.err() << ")" << std::endl;
    return 1;
  }

  return 0;
}
