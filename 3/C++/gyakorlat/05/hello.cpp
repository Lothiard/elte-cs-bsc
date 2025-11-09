#include <iostream>
#include <string>

int main()
{
  std::cout << "Hogy hivnak? ";

  std::string name;
  std::cin >> name;
  if (!std::cin)
  {
     std::cout << "Hiba tortent" << std::endl;
     return 1;
  }

  std::cout << "Hello " << name << "!\n";
}

