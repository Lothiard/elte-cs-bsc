#include <iostream>
#include <algorithm>
#include <iterator>

template <class Item, class NonConstItem>
class vector_iterator
{
public:
  typedef
    std::input_iterator_tag iterator_category;
  typedef Item value_type;
  typedef std::ptrdiff_t difference_type;
  typedef value_type* pointer;
  typedef value_type& reference;

  explicit vector_iterator(value_type* current) :
    current_(current) {}

  /* implicit */ vector_iterator(
    const
    vector_iterator<NonConstItem, NonConstItem>& i
  ) :
    current_(i.current())
  {}

  bool operator==(const vector_iterator& rhs) const
  {
    return current_ == rhs.current_;
  }

  bool operator!=(const vector_iterator& rhs) const
  {
    return !(*this == rhs);
  }

  vector_iterator& operator++()
  {
    ++current_;
    return *this;
  }

  vector_iterator operator++(int)
  {
    vector_iterator result = *this;
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

template <class> class my_vector;

template <class Item>
class my_vector
{
public:
  typedef vector_iterator<Item, Item> iterator;
  typedef vector_iterator<const Item, Item> const_iterator;

  my_vector(size_t len = 0) :
    len_(len),
    items_(
      len == 0 ? 0 : new Item[len]
    )
  {}

  my_vector(const my_vector& v) :
    len_(v.len_),
    items_(
      len_ == 0 ? 0 : new Item[len_]
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
      items_ = len_ == 0 ? 0 : new Item[len_];
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

  Item& operator[](size_t n)
  {
    return items_[n];
  }

  const Item& operator[](size_t n) const
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
  Item* items_;
};

class two_arrays
{
public:

private:
  my_vector<double> items1_;
  my_vector<double> items2_;
};

class c
{
public:
   static const int const_iterator = 9;
};

template <class Item>
typename my_vector<Item>::hello display(
  const my_vector<Item>& vec)
{
  for (
    typename my_vector<Item>::const_iterator
      i = vec.begin();
    i != vec.end();
    ++i
  )
  {
    std::cout << *i << "\n";
  }
}

void display(const my_vector<int>& vec)
{
  std::cout << "another one\n";
}

int main()
{
  my_vector<double> v2(3);
  v2[0] = 1;
  v2[1] = 31;
  v2[2] = 321;
  display(v2);

  for (
    my_vector<double>::const_iterator i(v2.begin());
    i != v2.end();
    ++i
  )
  {
    std::cout << *i << "\n";
  }
}

