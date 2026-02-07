#include <iostream>
#include <vector>

namespace math
{
  bool operator==(const rational& lhs, const rational& rhs)
  {
    return
      lhs.numerator() == rhs.numerator()
      && lhs.denominator() == rhs.denominator();
  }
  
  rational operator*(rational lhs, rational rhs)
  {
    return lhs *= rhs;
  }

  std::string to_string(const rational& r)
  {
    // ...
  }

  std::ostream& operator<<(
    std::ostream& out,
    const rational& r
  )
  {
    return out << r.numerator() << "/" << r.denominator();
  }
}

class other
{
public:
  /* implicit */ other(math::rational num) :
    r(num)
  {
  }

  math::rational r;
};

int main()
{
  other o(31);

  math::rational r3(0);
  const math::rational r(1, 3);
  math::rational r2(3);

  std::cout << r << "\n";

  math::rational res = r;
  res *= r2;

  res++;

  std::cout << res << "\n";

  std::cout << math::rational(21) << "\n";

  if (res == r3)
  {
  }
}
