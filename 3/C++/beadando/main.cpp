#include <array>
#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

typedef std::vector<int> State;

constexpr std::array<int, 24> target_arr{ 0, 3, 4, 3, 0, 5, 6,  5, 0, 1, 2, 1,
                                         0, 7, 8, 7, 0, 9, 10, 9, 0, 1, 2, 1 };
constexpr std::size_t target_arr_size{ target_arr.size() };
constexpr std::array<char, 4> move_chars{ '1', '2', '3', '4' };

State make_target() {
    State s{};
    for (std::size_t i{}; i < target_arr_size; ++i) s.push_back(target_arr[i]);
    return s;
}

const State target(target_arr.begin(), target_arr.end());

State rotateLeftCW(State s) {
    int temp1{ s[10] }, temp2{ s[11] };
    for (std::size_t i{ 11 }; i >= 2; --i) { s[i] = s[i - 2]; }
    s[0] = temp1;
    s[1] = temp2;
    s[21] = s[9];
    s[22] = s[10];
    s[23] = s[11];
    return s;
}
State rotateLeftCCW(State s) {
    int temp1{ s[0] }, temp2{ s[1] };
    for (std::size_t i{}; i <= 9; ++i) { s[i] = s[i + 2]; }
    s[10] = temp1;
    s[11] = temp2;
    s[21] = s[9];
    s[22] = s[10];
    s[23] = s[11];
    return s;
}
State rotateRightCW(State s) {
    int temp1{ s[22] }, temp2{ s[23] };
    for (std::size_t i{ 23 }; i >= 14; --i) { s[i] = s[i - 2]; }
    s[12] = temp1;
    s[13] = temp2;
    s[9] = s[21];
    s[10] = s[22];
    s[11] = s[23];
    return s;
}
State rotateRightCCW(State s) {
    int temp1{ s[12] }, temp2{ s[13] };
    for (std::size_t i{ 12 }; i <= 21; ++i) { s[i] = s[i + 2]; }
    s[22] = temp1;
    s[23] = temp2;
    s[9] = s[21];
    s[10] = s[22];
    s[11] = s[23];
    return s;
}

std::string reverseAndInvert(const std::string& path) {
    std::string result{};
    result.reserve(path.size());
    for (auto it{ path.rbegin() }; it != path.rend(); ++it) {
        switch (*it) {
        case '1': result += '3'; break;
        case '2': result += '4'; break;
        case '3': result += '1'; break;
        case '4': result += '2'; break;
        }
    }
    return result;
}

bool isTarget(const State& s) {
    for (std::size_t i{}; i < target_arr_size; ++i)
        if (s[i] != target_arr[i]) { return false; }
    return true;
}

std::string solve(const State& initial) {
    if (isTarget(initial)) { return "MEGOLDOTT"; }
    std::map<State, std::string> forwardMap{}, backwardMap{};
    std::map<State, std::string> forwardCurrent{}, backwardCurrent{};
    std::set<std::string> solutions{};
    forwardCurrent[initial] = "";
    forwardMap[initial] = "";
    State tgt(target_arr.begin(), target_arr.end());
    backwardCurrent[tgt] = "";
    backwardMap[tgt] = "";

    int depth{};
    while (depth < 8 && (!forwardCurrent.empty() || !backwardCurrent.empty())) {
        std::map<State, std::string> forwardNext{};
        for (const auto& [state, path] : forwardCurrent) {
            const std::array<State, 4> moves{
                rotateLeftCW(state), rotateRightCW(state), rotateLeftCCW(state),
                rotateRightCCW(state)};
            for (std::size_t m{}; m < 4; ++m) {
                const State& nextState{ moves[m] };
                std::string newPath{ path + move_chars[m] };
                if (backwardMap.count(nextState)) {
                    std::string candidate {
                        newPath + reverseAndInvert(backwardMap[nextState]) };
                    if (candidate.length() <= 16) {
                        solutions.insert(candidate);
                    }
                }
                if (!forwardMap.count(nextState) ||
                    newPath < forwardMap[nextState]) {
                    if (!forwardNext.count(nextState) ||
                        newPath < forwardNext[nextState])
                        forwardNext[nextState] = newPath;
                }
            }
        }
        for (const auto& [state, path] : forwardNext) {
            forwardMap[state] = path;
        }
        forwardCurrent = std::move(forwardNext);

        std::map<State, std::string> backwardNext{};
        for (const auto& [state, path] : backwardCurrent) {
            std::array<State, 4> moves{
                rotateLeftCW(state), rotateRightCW(state), rotateLeftCCW(state),
                rotateRightCCW(state)};
            for (std::size_t m{}; m < 4; ++m) {
                const State& nextState{ moves[m] };
                std::string newPath{ path + move_chars[m] };
                if (forwardMap.count(nextState)) {
                    std::string candidate{ forwardMap[nextState] +
                                          reverseAndInvert(newPath) };
                    if (candidate.length() <= 16) {
                        solutions.insert(candidate);
                    }
                }
                if (!backwardMap.count(nextState) ||
                    newPath < backwardMap[nextState]) {
                    if (!backwardNext.count(nextState) ||
                        newPath < backwardNext[nextState]) {
                        backwardNext[nextState] = newPath;
                    }
                }
            }
        }
        for (const auto& [state, path] : backwardNext) {
            backwardMap[state] = path;
        }
        backwardCurrent = std::move(backwardNext);

        if (!solutions.empty()) { return *solutions.begin(); }
        ++depth;
    }
    return "N/A";
}

int main() {
    int n{};
    std::cin >> n;
    for (int i{}; i < n; ++i) {
        State state(target_arr_size);
        for (std::size_t j{}; j < target_arr_size; ++j) {
            std::cin >> state[j];
        }
        std::cout << solve(state) << '\n';
    }
    return 0;
}
