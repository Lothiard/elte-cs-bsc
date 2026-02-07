#include <iostream>
#include <vector>

int main()
{
  std::vector<int> v;
  v.reserve(512);
  for (int i = 0; i != 512; ++i)
  {
    std::cout
      << "size = " << v.size()
      << ", capacity = " << v.capacity() << "\n";
    v.push_back(i);
  }
}

