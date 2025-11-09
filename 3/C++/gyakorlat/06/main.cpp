#include <iostream>

namespace math
{
  class rational
  {
  public:
    // invariant: denom_ != 0

    rational(int num = 0, int denom = 1)
    {
      if (denom == 0)
      {
        std::abort();
      }

      num_ = num;
      denom_ = denom;
    }

    int numerator(/* const rational* this */) const
    {
      return this->num_;
    }

    int denominator() const
    {
      return denom_;
    }

  private:
    int num_;
    int denom_;
  };
  
  rational operator*(rational lhs, rational rhs)
  {
    return rational(
      lhs.numerator() * rhs.numerator(),
      lhs.denominator() * rhs.denominator()
    );
  }
}

int main()
{
  math::rational r3;
  const math::rational r(1, 3);
  math::rational r2(3);

  std::cout
    << r.numerator() << "/" << r.denominator() << "\n";

//  math::rational res = r * r2;
  math::rational res = operator*(r, r2);

  std::cout
    << res.numerator() << "/" << res.denominator() << "\n";
}
