#ifndef CISTRING_H
#define CISTRING_H

#include <string>

template <typename T>
class case_insensitive_basic_string {
public:
    typedef typename std::basic_string<T>::size_type size_type;
    static const size_type npos = std::basic_string<T>::npos;

    case_insensitive_basic_string<T>(){};
    case_insensitive_basic_string<T>(
        const case_insensitive_basic_string<T>& other) {
        _str = other._str;
    }
    case_insensitive_basic_string<T>&

    operator=(const case_insensitive_basic_string<T>& other) const {
        return case_insensitive_basic_string<T>(other);
    }

    T& operator[](std::size_t idx) { return _str[idx]; }
    const T& operator[](std::size_t idx) const { return _str[idx]; }

    void push_back(T item) { _str.push_back(item); }
    void push_back(const T item) const { _str.push_back(item); }

    std::size_t find(const T item) const {
        return lower().find(std::tolower(item));
    }
    std::size_t find(std::basic_string<T> str) const {
        return lower().find(lower(str));
    }
    std::size_t find(case_insensitive_basic_string<T> str) const {
        return lower().find(lower(str._str));
    }

    std::size_t rfind(const T item) const {
        return lower().rfind(std::tolower(item));
    }
    std::size_t rfind(std::basic_string<T> str) const {
        return lower().rfind(lower(str));
    }

    std::size_t size() const { return _str.size(); }

private:
    std::basic_string<T> _str;

    std::basic_string<T> lower() const {
        std::basic_string<T> temp(_str);
        for (std::size_t i = 0; i < _str.size(); ++i) {
            temp[i] = std::tolower(_str[i]);
        }
        return temp;
    }
    std::basic_string<T> lower(std::basic_string<T> str) const {
        std::basic_string<T> temp(str);
        for (std::size_t i = 0; i < str.size(); ++i) {
            temp[i] = std::tolower(str[i]);
        }
        return temp;
    }
};

typedef case_insensitive_basic_string<char> case_insensitive_string;

template <typename T>
bool operator==(const case_insensitive_basic_string<T>& lhs,
                const std::basic_string<T>& rhs) {
    return lhs.find(rhs) == 0 && lhs.size() == rhs.size();
}

template <typename T>
bool operator==(const std::basic_string<T>& lhs,
                const case_insensitive_basic_string<T>& rhs) {
    return rhs == lhs;
}

template <typename T>
bool operator==(const case_insensitive_basic_string<T>& lhs,
                const case_insensitive_basic_string<T>& rhs) {
    return lhs.size() == rhs.size() && lhs.find(rhs) == 0;
}

#endif
