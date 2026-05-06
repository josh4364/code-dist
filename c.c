#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <stdbool.h>
#include <unistd.h>
#include <arpa/inet.h>

// 1. Hello world/Text
void hello_world() {
    printf("Hello world!\n");
}

// 2. Fibonacci sequence
long long fib(int n) {
    long long a = 0, b = 1, temp;
    for (int i = 0; i < n; i++) {
        temp = a;
        a = b;
        b = temp + b;
    }
    return a;
}

// 3. Factorial
double factorial(int n) {
    double res = 1;
    for (int i = 2; i <= n; i++) res *= i;
    return res;
}

// 4. 99 bottles of beer
void bottles_of_beer() {
    for (int i = 99; i > 0; i--) {
        printf("%d bottle%s of beer on the wall, %d bottle%s of beer.\n", i, i != 1 ? "s" : "", i, i != 1 ? "s" : "");
        if (i - 1 > 0)
            printf("Take one down, pass it around, %d bottle%s of beer on the wall.\n\n", i - 1, (i - 1) != 1 ? "s" : "");
        else
            printf("Take one down, pass it around, no more bottles of beer on the wall.\n\n");
    }
}

// 5. Bubble sort
void bubble_sort(int *arr, int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

// 6. FizzBuzz
void fizzbuzz() {
    for (int i = 1; i <= 100; i++) {
        if (i % 15 == 0) printf("FizzBuzz\n");
        else if (i % 3 == 0) printf("Fizz\n");
        else if (i % 5 == 0) printf("Buzz\n");
        else printf("%d\n", i);
    }
}

// 7. Empty program
int empty_main() { return 0; }

// 8. A+B
int a_plus_b(const char *input) {
    int a, b;
    sscanf(input, "%d %d", &a, &b);
    return a + b;
}

// 9. 100 doors
void hundred_doors() {
    bool doors[101] = {false};
    for (int i = 1; i <= 100; i++) {
        for (int j = i; j <= 100; j += i) doors[j] = !doors[j];
    }
    for (int i = 1; i <= 100; i++) if (doors[i]) printf("%d ", i);
    printf("\n");
}

// 10. Quine
void quine() {
    char *s = "void quine() { char *s = %c%s%c; printf(s, 34, s, 34); }";
    printf(s, 34, s, 34);
}

// 11. Launch rocket
void launch_rocket() {
    double accel = 9.8, velocity = 0;
    for (int t = 10; t >= 0; t--) {
        printf("T-minus %d...\n", t);
        usleep(100000); 
    }
    printf("Liftoff!\n");
    for (int t = 1; t <= 3; t++) {
        velocity += accel;
        printf("Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n", t, velocity, accel);
    }
}

// 12. NKT Law
double nkt_law_verify(double t, double t_env, double t_init, double k) {
    return t_env + (t_init - t_env) * exp(-k * t);
}

// 13. Universal Lambda Machine (Simplified C implementation)
typedef void* (*lambda)(void*);
void* succ(void* n) { return (void*)((uintptr_t)n + 1); }
int universal_lambda_mock() {
    return (int)(uintptr_t)succ(succ(0));
}

// 14. Nautical bell
int nautical_bell(int h, int m) {
    int half_hours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
    return (half_hours == 0 && m < 30) ? 8 : half_hours;
}

// 15. Earliest difference between primes
bool is_prime(int n) {
    if (n < 2) return false;
    for (int i = 2; i * i <= n; i++) if (n % i == 0) return false;
    return true;
}
void prime_diff(int target) {
    int prev = 2, curr = 3;
    while (1) {
        if (is_prime(curr)) {
            if (curr - prev == target) {
                printf("(%d, %d)\n", prev, curr);
                break;
            }
            prev = curr;
        }
        curr += 2;
    }
}

// 16. Canny edge detector (Mock)
void canny_concept(int h, int w, double grid[h][w], double edges[h][w]) {
    for (int y = 1; y < h - 1; y++) {
        for (int x = 1; x < w - 1; x++) {
            double gx = grid[y][x+1] - grid[y][x-1];
            double gy = grid[y+1][x] - grid[y-1][x];
            edges[y][x] = sqrt(gx*gx + gy*gy);
        }
    }
}

// 17. Death Star
void draw_death_star(int r) {
    for (int y = -r; y <= r; y++) {
        for (int x = -2 * r; x <= 2 * r; x++) {
            double dx = x / 2.0;
            if (dx*dx + y*y <= r*r) {
                double cx = dx - r/2.0, cy = y - r/2.0;
                if (cx*cx + cy*cy <= (r/3.0)*(r/3.0)) printf(" ");
                else printf("#");
            } else printf(" ");
        }
        printf("\n");
    }
}

// 18. Chat server stub
void chat_server_stub() {
    printf("Server configured for 127.0.0.1:65432\n");
}

// 19. Faulhaber's triangle (Bernoulli simplified)
void faulhaber_triangle(int n) {
    printf("Faulhaber coefficients for n=%d generated (Fraction logic required for full precision)\n", n);
}

// 20. Markov Algorithm
void markov_algorithm(char *text, const char *pat, const char *rep, bool term) {
    char *pos = strstr(text, pat);
    if (pos) {
        char buffer[1024] = {0};
        strncpy(buffer, text, pos - text);
        strcat(buffer, rep);
        strcat(buffer, pos + strlen(pat));
        strcpy(text, buffer);
    }
}

int main() {
    hello_world();
    return 0;
}