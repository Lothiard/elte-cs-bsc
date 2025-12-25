#ifndef SORTER_H
#define SORTER_H

#include <algorithm>
#include <cstddef>
#include <list>
#include <vector>

template <typename Container>
struct get_value_type {
    typedef typename Container::value_type type;
};

template <typename Container,
          typename T = typename get_value_type<Container>::type>
class sorter {
public:
    sorter(Container& c) : _ref(c), _original(c) {}

    void sort() { std::sort(_ref.begin(), _ref.end()); }

    template <typename Compare>
    void sort(Compare comp) {
        std::sort(_ref.begin(), _ref.end(), comp);
    }

    void reset() { _ref = _original; }

private:
    Container& _ref;
    Container _original;
};

template <typename T>
class sorter<T*, T> {
public:
    sorter(T* arr, std::size_t size) :
        ref(arr),
        n(size),
        original(arr, arr + size) {}

    void sort() { std::sort(ref, ref + n); }

    template <typename Compare>
    void sort(Compare comp) {
        std::sort(ref, ref + n, comp);
    }

    void reset() {
        for (std::size_t i = 0; i < n; ++i) ref[i] = original[i];
    }

private:
    T* ref;
    std::size_t n;
    std::vector<T> original;
};

template <typename T>
class sorter<std::list<T>, T> {
public:
    sorter(std::list<T>& c) : _ref(c), _original(c) {}

    void sort() { _ref.sort(); }

    template <typename Compare>
    void sort(Compare comp) {
        _ref.sort(comp);
    }

    void reset() { _ref = _original; }

private:
    std::list<T>& _ref;
    std::list<T> _original;
};

#endif
