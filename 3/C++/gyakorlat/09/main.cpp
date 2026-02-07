#include <iostream>
#include <algorithm>
#include <iterator>

class my_vector
{
public:
  class iterator
  {
  public:
    typedef
      std::input_iterator_tag iterator_category;
    typedef double value_type;
    typedef std::ptrdiff_t difference_type;
    typedef value_type* pointer;
    typedef value_type& reference;

    explicit iterator(value_type* current) :
      current_(current) {}

    bool operator==(const iterator& rhs) const
    {
      return current_ == rhs.current_;
    }

    bool operator!=(const iterator& rhs) const
    {
      return !(*this == rhs);
    }

    iterator& operator++()
    {
      ++current_;
      return *this;
    }

    iterator operator++(int)
    {
      iterator result = *this;
      ++*this;
      return result;
    }

    value_type& operator*()
    {
      return *current_;
    }

    value_type* current() const
    {
      return current_;
    }

  private:
    value_type* current_;
  };

  class const_iterator
  {
  public:
    typedef
      std::input_iterator_tag iterator_category;
    typedef const double value_type;
    typedef std::ptrdiff_t difference_type;
    typedef value_type* pointer;
    typedef value_type& reference;

    explicit const_iterator(value_type* current) :
      current_(current) {}

    /* implicit */ const_iterator(iterator i) :
      current_(i.current())
    {}

    bool operator==(const const_iterator& rhs) const
    {
      return current_ == rhs.current_;
    }

    bool operator!=(const const_iterator& rhs) const
    {
      return !(*this == rhs);
    }

    const_iterator& operator++()
    {
      ++current_;
      return *this;
    }

    const_iterator operator++(int)
    {
      const_iterator result = *this;
      ++*this;
      return result;
    }

    value_type& operator*()
    {
      return *current_;
    }

  private:
    value_type* current_;
  };

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

  double& operator[](size_t n)
  {
    return items_[n];
  }

  const double& operator[](size_t n) const
  {
    return items_[n];
  }

  const_iterator begin() const
  {
    return const_iterator(items_);
  }

  iterator begin()
  {
    return iterator(items_);
  }

  const_iterator end() const
  {
    return const_iterator(items_ + len_);
  }

  iterator end()
  {
    return iterator(items_ + len_);
  }

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

void display(const my_vector& vec)
{
  for (
    my_vector::const_iterator i = vec.begin();
    i != vec.end();
    ++i
  )
  {
    std::cout << *i << "\n";
  }
}


int main()
{
  my_vector v2(3);
  v2[0] = 1;
  v2[1] = 31;
  v2[2] = 321;
  display(v2);

  for (
    my_vector::const_iterator i(v2.begin());
    i != v2.end();
    ++i
  )
  {
    std::cout << *i << "\n";
  }
}

