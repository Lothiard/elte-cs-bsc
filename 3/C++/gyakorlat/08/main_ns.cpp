#include <iostream>
#include <map>
#include <vector>
#include <list>
#include <algorithm>
#include <iterator>

namespace cpp_class
{
  namespace
  {
    void f()
    {
      std::cout << "f()\n";
    }
  }

  void display(
    std::map<int, std::string>::iterator begin,
    std::map<int, std::string>::iterator end
  );
}

void cpp_class::display(
  std::map<int, std::string>::iterator begin,
  std::map<int, std::string>::iterator end
)
{
  f();

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

using namespace cpp_class;

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

void my_copy(
  std::vector<int>::iterator begin1,
  std::vector<int>::iterator end1,
  std::list<double>::iterator begin2
)
{
  for (; begin1 != end1; ++begin1, ++begin2)
  {
    *begin2 = *begin1;
  }
}

double twice(int n)
{
  return 2 * n;
}


int main()
{
/*  std::transform(
    std::istream_iterator<int>(std::cin),
    std::istream_iterator<int>(),
    std::ostream_iterator<int>(std::cout, " "),
    twice
  );*/

  std::map<int, std::string> vals{
    {1, "one"},
    {2, "two"}
  };

  cpp_class::display(vals.begin(), vals.end());

  std::cout << "\n";
  f();
  g();
}

