#include <iostream>
#include <vector>
#include <list>

int main()
{
  std::list<int> nums;
  for (int num; std::cin >> num; )
  {
    nums.push_back(num);
  }


  int sum = 0;
  for (int num : nums)
  {
    sum += num;
  }
  std::cout << "sum = " << sum << "\n";
}

