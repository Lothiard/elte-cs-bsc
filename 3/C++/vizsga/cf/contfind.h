#ifndef CONTFIND_H
#define CONTFIND_H

#include <cstddef>
#include <list>
#include <string>
#include <vector>

template <typename Container>
class container_finder {
public:
    container_finder() {}
    container_finder& add_container(Container& cont) {
        containers.push_back(&cont);
        return *this;
    }

    container_finder& operator+=(Container& cont) {
        for (std::size_t i = 0; i < containers.size(); ++i) {
            if (containers[i] == &cont) {
                containers.erase(containers.begin() + i);
                return *this;
            }
        }
        add_container(cont);
        return *this;
    }
    container_finder& operator-=(Container& cont) {
        for (std::size_t i = 0; i < containers.size(); ++i) {
            if (containers[i] == &cont) {
                containers.erase(containers.begin() + i);
                break;
            }
        }
        return *this;
    }
    Container& operator[](typename Container::iterator it) {
        return *which(it);
    }
    Container& operator[](typename Container::const_iterator it) {
        return *which(it);
    }
    Container& operator[](typename Container::reverse_iterator it) {
        return *which(it);
    }
    Container& operator[](typename Container::const_reverse_iterator it) {
        return *which(it);
    }
    bool operator==(const container_finder& other) const {
        if (containers.size() != other.containers.size()) return false;
        for (std::size_t i = 0; i < containers.size(); ++i)
            if (containers[i] != other.containers[i]) return false;
        return true;
    }
    bool operator!=(const container_finder& other) const {
        return !(*this == other);
    }

    Container* which(typename Container::iterator it) {
        for (std::size_t i = 0; i < containers.size(); ++i) {
            Container* cont = containers[i];
            for (typename Container::iterator cit = cont->begin();
                 cit != cont->end(); ++cit) {
                if (cit == it) return cont;
            }
        }
        return NULL;
    }
    Container* which(typename Container::const_iterator it) {
        for (std::size_t i = 0; i < containers.size(); ++i) {
            Container* cont = containers[i];
            for (typename Container::const_iterator cit = cont->begin();
                 cit != cont->end(); ++cit) {
                if (cit == it) return cont;
            }
        }
        return NULL;
    }
    Container* which(typename Container::reverse_iterator it) {
        for (std::size_t i = 0; i < containers.size(); ++i) {
            Container* cont = containers[i];
            for (typename Container::reverse_iterator cit = cont->rbegin();
                 cit != cont->rend(); ++cit) {
                if (cit == it) return cont;
            }
        }
        return NULL;
    }
    Container* which(typename Container::const_reverse_iterator it) {
        for (std::size_t i = 0; i < containers.size(); ++i) {
            Container* cont = containers[i];
            for (typename Container::const_reverse_iterator cit =
                     cont->rbegin();
                 cit != cont->rend(); ++cit) {
                if (cit == it) return cont;
            }
        }
        return NULL;
    }

private:
    std::vector<Container*> containers;
};

template <>
class container_finder<std::string> {
public:
    container_finder() {}
    container_finder& add_container(std::string& s) {
        strings.push_back(&s);
        return *this;
    }

    container_finder& operator+=(std::string& s) {
        for (std::size_t i = 0; i < strings.size(); ++i) {
            if (strings[i] == &s) {
                strings.erase(strings.begin() + i);
                return *this;
            }
        }
        add_container(s);
        return *this;
    }
    container_finder& operator-=(std::string& s) {
        for (std::size_t i = 0; i < strings.size(); ++i) {
            if (strings[i] == &s) {
                strings.erase(strings.begin() + i);
                break;
            }
        }
        return *this;
    }
    std::string& operator[](typename std::string::iterator it) {
        return *which(it);
    }
    std::string& operator[](typename std::string::const_iterator it) {
        return *which(it);
    }
    std::string& operator[](typename std::string::reverse_iterator it) {
        return *which(it);
    }
    std::string& operator[](typename std::string::const_reverse_iterator it) {
        return *which(it);
    }
    bool operator==(const container_finder& other) const {
        if (strings.size() != other.strings.size()) return false;
        for (std::size_t i = 0; i < strings.size(); ++i)
            if (strings[i] != other.strings[i]) return false;
        return true;
    }
    bool operator!=(const container_finder& other) const {
        return !(*this == other);
    }

    std::string* which(std::string::iterator it) {
        for (std::size_t i = 0; i < strings.size(); ++i) {
            std::string* s = strings[i];
            if (!s->empty() && &(*it) >= &(*s)[0] &&
                &(*it) < &(*s)[0] + s->size())
                return s;
        }
        return NULL;
    }
    std::string* which(std::string::const_iterator it) {
        for (std::size_t i = 0; i < strings.size(); ++i) {
            std::string* s = strings[i];
            if (!s->empty() && &(*it) >= &(*s)[0] &&
                &(*it) < &(*s)[0] + s->size())
                return s;
        }
        return NULL;
    }
    std::string* which(std::string::reverse_iterator it) {
        for (std::size_t i = 0; i < strings.size(); ++i) {
            std::string* s = strings[i];
            if (!s->empty()) {
                std::string::iterator base = (it + 1).base();
                if (&(*base) >= &(*s)[0] && &(*base) < &(*s)[0] + s->size())
                    return s;
            }
        }
        return NULL;
    }
    std::string* which(std::string::const_reverse_iterator it) {
        for (std::size_t i = 0; i < strings.size(); ++i) {
            std::string* s = strings[i];
            if (!s->empty()) {
                std::string::const_iterator base = (it + 1).base();
                if (&(*base) >= &(*s)[0] && &(*base) < &(*s)[0] + s->size())
                    return s;
            }
        }
        return NULL;
    }

private:
    std::vector<std::string*> strings;
};

#endif
