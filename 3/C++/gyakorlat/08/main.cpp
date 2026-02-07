#include <iostream>
#include <algorithm>

class my_vector
{
public:
  my_vector(size_t len = 0) :
    len_(len),
    items_(
      len == 0 ? 0 : new double[len]
    )
  {}

  my_vector(const my_vector& v) :
    len_(v.len_),
    items_(
      len_ == 0 ? 0 : new double[len_]
    )
  {
    std::copy(
      v.items_, v.items_ + len_,
      items_
    );
  }

  my_vector& operator=(const my_vector& rhs)
  {
    if (this != &rhs)
    {
      delete[] items_;

      len_ = rhs.len_;
      items_ = len_ == 0 ? 0 : new double[len_];
      std::copy(
        rhs.items_, rhs.items_ + len_,
        items_
      );
    }

    return *this;
  }

  ~my_vector()
  {
    delete[] items_;
  }

  size_t size() const { return len_; }

private:
  size_t len_;
  double* items_;
};

class two_arrays
{
public:

private:
  my_vector items1_;
  my_vector items2_;
};


int main()
{
  my_vector v1;
  my_vector v2(21);

  my_vector v3(v2);
  v3 = v2;
  v2 = v2;

  std::cout << v1.size() << "\n";
}

