#include <iostream>
#include <vector>
#include <string>
#include <cmath>
#include <numeric>
#include <thread>
#include <chrono>
#include <iomanip>
#include <sstream>
#include <functional>
#include <sys/socket.h>
#include <netinet/in.h>

// 1. Hello world/Text
void hello_world() {
    std::cout << "Hello world!" << std::endl;
}

// 2. Fibonacci sequence
long long fib(int n) {
    long long a = 0, b = 1;
    for (int i = 0; i < n; ++i) {
        long long temp = a;
        a = b;
        b = temp + b;
    }
    return a;
}

// 3. Factorial
unsigned long long factorial(int n) {
    unsigned long long res = 1;
    for (int i = 2; i <= n; ++i) res *= i;
    return res;
}

// 4. 99 bottles of beer
void bottles_of_beer() {
    for (int i = 99; i > 0; --i) {
        std::string s = (i != 1) ? "s" : "";
        std::string s_next = (i - 1 != 1) ? "s" : "";
        std::cout << i << " bottle" << s << " of beer on the wall, " << i << " bottle" << s << " of beer.\n";
        if (i - 1 > 0)
            std::cout << "Take one down, pass it around, " << i - 1 << " bottle" << s_next << " of beer on the wall.\n\n";
        else
            std::cout << "Take one down, pass it around, no more bottles of beer on the wall.\n\n";
    }
}

// 5. Bubble sort
void bubble_sort(std::vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < n - i - 1; ++j)
            if (arr[j] > arr[j + 1]) std::swap(arr[j], arr[j + 1]);
}

// 6. FizzBuzz
void fizzbuzz() {
    for (int i = 1; i <= 101; ++i) {
        if (i % 15 == 0) std::cout << "FizzBuzz\n";
        else if (i % 3 == 0) std::cout << "Fizz\n";
        else if (i % 5 == 0) std::cout << "Buzz\n";
        else std::cout << i << "\n";
    }
}

// 7. Empty program
int main_empty() { return 0; }

// 8. A+B
int a_plus_b(std::string input_str) {
    std::stringstream ss(input_str);
    int sum = 0, val;
    while (ss >> val) sum += val;
    return sum;
}

// 9. 100 doors
std::vector<int> hundred_doors() {
    std::vector<bool> doors(101, false);
    for (int i = 1; i <= 100; ++i)
        for (int j = i; j <= 100; j += i)
            doors[j] = !doors[j];
    std::vector<int> open_doors;
    for (int i = 1; i <= 100; ++i) if (doors[i]) open_doors.push_back(i);
    return open_doors;
}

// 10. Quine
void quine() {
    char q = 34;
    const char* s = "void quine() { char q = 34; const char* s = %c%s%c; printf(s, q, s, q); }";
    printf(s, q, s, q);
}

// 11. Launch rocket
void launch_rocket() {
    double accel = 9.8, velocity = 0;
    for (int t = 10; t >= 0; --t) {
        std::cout << "T-minus " << t << "...\n";
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
    std::cout << "Liftoff!\n";
    for (int t = 1; t <= 3; ++t) {
        velocity += accel;
        std::cout << "Time: " << t << "s, Velocity: " << std::fixed << std::setprecision(1) << velocity << "m/s, Accel: " << accel << "m/s^2\n";
    }
}

// 12. Experimental Verification of the NKT Law
double nkt_law_verify(double t, double t_env, double t_init, double k) {
    return t_env + (t_init - t_env) * std::exp(-k * t);
}

// 13. Universal Lambda Machine (Basic Church Encoding)
typedef std::function<int(int)> Func;
typedef std::function<Func(Func)> Church;

int universal_lambda() {
    auto zero = [](Func f) { return [](int x) { return x; }; };
    auto succ = [](Church n) {
        return [n](Func f) {
            return [n, f](int x) { return f(n(f)(x)); };
        };
    };
    auto to_int = [](Church n) { return n([](int x) { return x + 1; })(0); };
    return to_int(succ(succ(zero)));
}

// 14. Nautical bell
int nautical_bell(std::string time_str) {
    int h, m;
    char colon;
    std::stringstream ss(time_str);
    ss >> h >> colon >> m;
    int half_hours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
    return (half_hours == 0 && m < 30) ? 8 : half_hours;
}

// 15. Earliest difference between primes
std::pair<int, int> prime_diff(int target_diff) {
    auto is_prime = [](int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; ++i) if (n % i == 0) return false;
        return true;
    };
    int prev_prime = 2, current = 3;
    while (true) {
        if (is_prime(current)) {
            if (current - prev_prime == target_diff) return {prev_prime, current};
            prev_prime = current;
        }
        current += 2;
    }
}

// 16. Canny edge detector (Sobel Concept)
std::vector<std::vector<double>> canny_concept(const std::vector<std::vector<int>>& grid) {
    int rows = grid.size(), cols = grid[0].size();
    std::vector<std::vector<double>> edges(rows, std::vector<double>(cols, 0.0));
    for (int y = 1; y < rows - 1; ++y) {
        for (int x = 1; x < cols - 1; ++x) {
            int gx = grid[y][x+1] - grid[y][x-1];
            int gy = grid[y+1][x] - grid[y-1][x];
            edges[y][x] = std::sqrt(gx*gx + gy*gy);
        }
    }
    return edges;
}

// 17. Death Star
void draw_death_star(int r = 10) {
    for (int y = -r; y <= r; ++y) {
        for (int x = -2 * r; x <= 2 * r; ++x) {
            double x_scaled = x / 2.0;
            if (x_scaled * x_scaled + y * y <= r * r) {
                if (std::pow(x_scaled - r / 2.0, 2) + std::pow(y - r / 2.0, 2) <= std::pow(r / 3.0, 2)) std::cout << " ";
                else std::cout << "#";
            } else std::cout << " ";
        }
        std::cout << "\n";
    }
}

// 18. Chat server stub
std::string chat_server_stub() {
    int port = 65432;
    int fd = socket(AF_INET, SOCK_STREAM, 0);
    if (fd >= 0) {
        int opt = 1;
        setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
    }
    return "Server configured for 127.0.0.1:65432";
}

// 19. Faulhaber's triangle (Double approximation for simplicity vs C++ Fraction complexity)
std::vector<std::vector<double>> faulhaber_triangle(int n) {
    std::vector<double> B(n + 1);
    for (int i = 0; i <= n; ++i) {
        B[i] = 1.0 / (i + 1);
        for (int j = i; j > 0; --j) B[j-1] = j * (B[j-1] - B[j]);
    }
    auto nCr = [](int n, int r) {
        if (r > n) return 0.0;
        double res = 1;
        for (int i = 1; i <= r; ++i) res = res * (n - r + i) / i;
        return res;
    };
    std::vector<std::vector<double>> triangle;
    for (int p = 0; p < n; ++p) {
        std::vector<double> row;
        for (int j = 0; j <= p; ++j) row.push_back((1.0 / (p + 1)) * nCr(p + 1, j) * B[j]);
        triangle.push_back(row);
    }
    return triangle;
}

// 20. Execute a Markov algorithm
struct Rule { std::string pattern, replacement; bool terminal; };
std::string markov_algorithm(std::vector<Rule> rules, std::string text) {
    while (true) {
        bool applied = false;
        for (const auto& rule : rules) {
            size_t pos = text.find(rule.pattern);
            if (pos != std::string::npos) {
                text.replace(pos, rule.pattern.length(), rule.replacement);
                if (rule.terminal) return text;
                applied = true;
                break;
            }
        }
        if (!applied) break;
    }
    return text;
}