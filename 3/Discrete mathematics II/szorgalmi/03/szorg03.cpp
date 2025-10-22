#include "Random.h"
#include <iostream>

uint64_t phi(uint64_t n) {
    uint64_t result = n;
    for (uint64_t p = 2; p * p <= n; ++p) {
        if (n % p == 0) {
            while (n % p == 0) n /= p;
            result -= result / p;
        }
    }
    if (n > 1) result -= result / n;
    return result;
}

uint64_t random_k_bit_int(int k) {
    uint64_t min_val = (1ULL << (k - 1));
    uint64_t max_val = (1ULL << k) - 1;
    return Random::get<uint64_t>(min_val, max_val);
}

int main() {
    std::vector<int> k_values = {50, 100, 150, 200, 250, 300, 350, 400};
    int num_tests = 10;

    std::cout << "Bit hossz\tátlag idő (ms)" << std::endl;
    for (int k : k_values) {
        double total_time = 0.0;
        for (int test = 0; test < num_tests; ++test) {
            uint64_t n = random_k_bit_int(k);

            auto start = std::chrono::high_resolution_clock::now();
            [[maybe_unused]] volatile uint64_t phi_val = phi(n);
            auto end = std::chrono::high_resolution_clock::now();
            std::chrono::duration<double, std::milli> elapsed = end - start;
            total_time += elapsed.count();
        }
        std::cout << k << "\t\t" << total_time / num_tests << std::endl;
    }
    return 0;
}
