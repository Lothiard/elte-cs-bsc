#ifndef RATIONAL_HPP
#define RATIONAL_HPP

#include <iosfwd>

namespace math
{
  class rational;

  class rational
  {
  public:
    // invariant: denom_ != 0 && gcd(num_, denom_) == 1

    /* implicit */ rational(int num, int denom = 1)
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

    int denominator() const;

    rational& operator*=(const rational& rhs)
    {
      num_ *= rhs.num_;
      denom_ *= rhs.denom_;
      return *this;
    }

    rational& operator++()
    {
      num_ += denom_;
      return *this;
    }

    rational operator++(int)
    {
      rational result = *this;
      ++*this;
      return result;
    }

  friend std::ostream& operator<<(
    std::ostream&,
    const rational&
  );

  private:
    int num_;
    int denom_;
  };
}

#endif
