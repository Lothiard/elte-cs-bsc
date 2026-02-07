#include <iostream>

int main()
{
  std::cin >> std::noskipws;

  for (char c; std::cin >> c;)
  {
    std::cout << c;
  }
}

