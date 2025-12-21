#ifndef ACCOP_H
#define ACCOP_H

#include <list>
#include <map>
#include <string>
#include <set>

template <typename Container>
class access_operations {
public:
    access_operations(Container& cont) : _cont(cont) {}

    bool is_valid(typename Container::iterator it) {
        for (typename Container::iterator cit = _cont.begin();
             cit != _cont.end(); ++cit) {
            if (cit == it) return true;
        }
        return false;
    }

    bool is_valid(int i) const { return (i >= 0 && i < _cont.size()); }


    typename Container::value_type& operator[](std::size_t i) const {
        return _cont[i];
    }

private:
    Container& _cont;
};

template <>
bool access_operations<std::list<double> >::is_valid(int) const {
    return false;
}

template <>
bool access_operations<std::set<std::string> >::is_valid(int) const {
    return false;
}

template <typename K, typename V, typename Comp>
class access_operations<std::map<K, V, Comp> > {
public:
    access_operations(std::map<K, V, Comp>& cont) : _cont(cont) {}

    bool is_valid(typename std::map<K, V, Comp>::iterator it) const {
        for (typename std::map<K, V, Comp>::iterator cit = _cont.begin(); cit != _cont.end(); ++cit) {
            if (cit == it) return true;
        }
        return false;
    }

    bool is_valid(const K& key) const {
        return _cont.find(key) != _cont.end();
    }

    V& operator[](const K& key) {
        return _cont[key];
    }

    const V& operator[](const K& key) const {
        typename std::map<K, V, Comp>::const_iterator it = _cont.find(key);
        if (it != _cont.end()) return it->second;
        static V dummy = V();
        return dummy;
    }

private:
    std::map<K, V, Comp>& _cont;
};

#endif
