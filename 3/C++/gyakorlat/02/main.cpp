#include <iostream>
#include <vector>

void other_fun(std::vector<int>&);

void display(const std::vector<int>& vec)
{
//  other_fun(vec);
//  vec.push_back(13);
  for (
    std::vector<int>::const_iterator i = vec.begin();
    i != vec.end();
    ++i
  )
  {
    std::cout << *i << "\n";
  }
}

int main()
{
  std::vector<int> numbers;
  numbers.push_back(1);
  numbers.push_back(31);
  numbers.push_back(3);
  numbers.push_back(21);

//  for (int i = 0; i < numbers.size(); ++i)
//  {
//    std::cout << numbers[i] << "\n";
//  }
  
  display(numbers);

//  for (int n : numbers)
//  {
//    std::cout << n << "\n";
//  }

  return 0;
}
