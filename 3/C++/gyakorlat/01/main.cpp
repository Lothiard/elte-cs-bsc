#include <iostream>
#include "math.hpp"


double no_such_function();

constexpr int add(int a, int b) { return a + b; }

int main()
{
  std::cout << add(1, 2) << "\n";
  const double pi;
  std::cout << my_tan(20) << "\n";
  std::cout << pi << "\n";
  return 0;
}
