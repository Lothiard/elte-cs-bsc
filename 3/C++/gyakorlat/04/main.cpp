#include <iostream>
#include <map>
#include <vector>
#include <list>
#include <algorithm>

void display(
  std::map<int, std::string>::iterator begin,
  std::map<int, std::string>::iterator end
)
{
  for (; begin != end; ++begin)
  {
    // std::pair<const int, std::string> !!!!!
    // struct pair { int first; std::string second; }; !!!!
    begin->second = "haha";
    std::cout
      << begin->first << " -> " << begin->second << "\n";
  }
}

// pre: nums_.find(1) != nums_.end()
void display_one(const std::map<int, std::string>& nums_)
{
  std::cout << nums_.find(1)->second << "\n";
}

int not_main()
{
  std::map<int, std::string> nums;
  nums[1] = "one";
  nums[1] = "egy";
  nums[21] = "two";

  for (const auto& [num, name] : nums)
  {
    std::cout << num << " -> " << name << "\n";
  }

  display_one(nums);

//  display(nums.begin(), nums.end());

  return 0;
}

bool is_even(int n)
{
  return n % 2 == 0;
}

bool less_10(int n)
{
  return n < 10;
}

int main()
{
  std::vector<int> nums{1, 31, 3, 21, 8};
  std::list<double> nums2(nums.begin(), nums.end());

  double x = 0;
  std::string y = 0;

  nums.erase(
    std::remove_if(nums.begin(), nums.end(), less_10),
    nums.end()
  );

  for (int n : nums)
  {
    std::cout << n << " ";
  }
  std::cout << "\n";
}

