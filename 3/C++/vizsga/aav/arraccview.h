#ifndef ARRACCVIEW_H
#define ARRACCVIEW_H

#include <numeric>
#include <string>
#include <vector>

template <typename T>
class array_accumulate_view {
public:
    array_accumulate_view(T* arr, std::size_t size) { add(arr, size); }

    T at(std::size_t n) const {
        T sum = 0;
        for (std::size_t i = 0; i <= n; ++i) { sum += *_data[i]; }
        return sum;
    }

    std::size_t size() const { return _data.size(); }

    void add(T* arr, std::size_t size) {
        for (std::size_t i = 0; i < size; ++i) _data.push_back(&arr[i]);
    }

    T operator[](std::size_t n) { return at(n); }
    const T operator[](std::size_t n) const { return at(n); }

private:
    std::vector<T*> _data;
};

template <>
inline std::string array_accumulate_view<std::string>::at(std::size_t n) const {
    std::string sum = "";
    for (std::size_t i = 0; i <= n; ++i) { sum += *_data[i]; }
    return sum;
}

#endif
