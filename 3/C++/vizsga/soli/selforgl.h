#ifndef SELFORG_H
#define SELFORG_H

#include <list>

template <typename T>
class self_organizing_list {
public:
    virtual ~self_organizing_list() = default;
    virtual bool contains(const T& item) = 0;
};

template <typename T>
class transpose : public self_organizing_list<T> {
public:
    transpose(std::list<T>& list) : _list(list) {}

    bool contains(const T& item) {
        typename std::list<T>::iterator it =
            std::find(_list.begin(), _list.end(), item);

        if (it == _list.end()) { return false; }

        if (it != _list.begin()) {
            typename std::list<T>::iterator temp = it;
            typename std::list<T>::iterator prev = --temp;
            std::iter_swap(it, prev);
        }

        return true;
    }

    template <typename Func>
    bool contains_if(Func func) {
        bool found = false;
        for (typename std::list<T>::iterator it = _list.begin();
             it != _list.end(); ++it) {
            if (func(*it)) { found = contains(*it); }
        }

        return found;
    }

private:
    std::list<T>& _list;
};

template <typename T>
class move_to_back : public self_organizing_list<T> {
public:
    move_to_back(std::list<T>& list) : _list(list) {}

    bool contains(const T& item) {
        typename std::list<T>::iterator it =
            std::find(_list.begin(), _list.end(), item);

        if (it == _list.end()) {
            return false;
        } else {
            typename std::list<T>::iterator temp = it;
            ++temp;
            std::rotate(it, temp, _list.end());
        }

        return true;
    }

    template <typename Func>
    bool contains_if(Func func) {
        bool found = false;
        for (typename std::list<T>::iterator it = _list.begin();
             it != _list.end(); ++it) {
            if (func(*it)) { found = contains(*it); }
        }

        return found;
    }

private:
    std::list<T>& _list;
};

#endif
