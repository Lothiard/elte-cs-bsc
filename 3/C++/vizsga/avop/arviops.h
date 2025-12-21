#ifndef ARVIOPS_H
#define ARVIOPS_H

#include <algorithm>
#include <cstddef>
#include <iostream>
#include <vector>

template <typename T>
class array_view_operations {
public:
    array_view_operations<T>(T* arr, std::size_t size) :
        _arr(arr),
        _size(size),
        _original(arr, arr + size) {}

    template <std::size_t N>
    array_view_operations(std::string (&arr)[N]) :
        _arr(arr),
        _size(N),
        _original(arr, arr + N) {}

    ~array_view_operations<T>() { reset(); }

    void reverse() { std::reverse(_arr, _arr + _size); }

    void reset() {
        for (std::size_t i = 0; i < _size; ++i) { _arr[i] = _original[i]; }
    }

    void shift(int k) {
        int n = _size;
        k = ((k % n) + n) % n;
        std::rotate(_arr, _arr + (n - k), _arr + n);
    }

    void sort() { std::sort(_arr, _arr + _size); }

    template <typename F>
    void sort(F func) {
        std::sort(_arr, _arr + _size, func);
    }

    template <typename F>
    int get_first_index_if(F func) {
        for (std::size_t i = 0; i < _size; ++i) {
            if (func(_arr[i])) { return i; }
        }
        return -1;
    }

private:
    T* _arr;
    std::size_t _size;
    std::vector<T> _original;
};

#endif
