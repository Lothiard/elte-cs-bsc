#include <iostream>
#include <vector>

void other_fun(std::vector<int>&);

void display(
  std::vector<int>::const_iterator begin,
  std::vector<int>::const_iterator end
)
{
  for (
    std::vector<int>::const_iterator i = begin;
    i != end;
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
  
  display(
    numbers.begin(),
    numbers.begin() + numbers.size() / 2
  );

//  for (int n : numbers)
//  {
//    std::cout << n << "\n";
//  }

  return 0;
}
