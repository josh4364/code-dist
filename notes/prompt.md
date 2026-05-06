Using these python examples, implement the <language> examples the are as close to equivalent as you can be to each of the rosetta code tasks. 
Respond with only a single code block containing the example source code.
## Tasks:
* Hello world/Text
* Fibonacci sequence
* Factorial
* 99 bottles of beer
* Bubble sort
* FizzBuzz
* Empty program
* A+B
* 100 doors
* Quine
* Launch rocket with countdown and acceleration in stdout
* Experimental Verification of the NKT Law
* Universal Lambda Machine
* Nautical bell
* Earliest difference between primes
* Canny edge detector
* Death Star
* Chat server
* Faulhaber's triangle
* Execute a Markov algorithm

## Python reference:
```python
import math
import time
import socket

# ==========================================
# PART 1: TOP 10 MOST IMPLEMENTED TASKS
# ==========================================

# 1. Hello world/Text
def hello_world():
    print("Hello world!")

# 2. Fibonacci sequence (Iterative for efficiency)
def fib(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a

# 3. Factorial
def factorial(n):
    return math.factorial(n)

# 4. 99 bottles of beer
def bottles_of_beer():
    for i in range(99, 0, -1):
        s = "s" if i != 1 else ""
        s_next = "s" if i-1 != 1 else ""
        next_count = i - 1 if i - 1 > 0 else "no more"
        print(f"{i} bottle{s} of beer on the wall, {i} bottle{s} of beer.")
        print(f"Take one down, pass it around, {next_count} bottle{s_next} of beer on the wall.\n")

# 5. Bubble sort
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr

# 6. FizzBuzz (Standard readable implementation)
def fizzbuzz():
    for i in range(1, 101):
        if i % 15 == 0: print("FizzBuzz")
        elif i % 3 == 0: print("Fizz")
        elif i % 5 == 0: print("Buzz")
        else: print(i)

# 7. Empty program
# A file containing only this comment or a single 'pass' is valid.
pass

# 8. A+B (Fulfilling the common competitive programming requirement)
def a_plus_b(input_str):
    # Splits input by whitespace and sums the integers
    return sum(int(x) for x in input_str.split())

# 9. 100 doors
def hundred_doors():
    # A door is toggled on every i-th pass. Only perfect squares remain open.
    doors = [False] * 101
    for i in range(1, 101):
        for j in range(i, 101, i):
            doors[j] = not doors[j]
    return [i for i, is_open in enumerate(doors) if is_open]

# 10. Quine (Prints its own source code)
def quine():
    s = 's = %r; print(s %% s)'
    print(s % s)


# ==========================================
# PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
# ==========================================

# 11. Launch rocket with countdown and acceleration
def launch_rocket():
    # Simulates a T-10 countdown with basic velocity/accel printout
    accel = 9.8
    velocity = 0
    for t in range(10, -1, -1):
        print(f"T-minus {t}...")
        time.sleep(0.1)
    print("Liftoff!")
    for t in range(1, 4):
        velocity += accel
        print(f"Time: {t}s, Velocity: {velocity:.1f}m/s, Accel: {accel}m/s^2")

# 12. Experimental Verification of the NKT Law (Newton's Law of Cooling)
def nkt_law_verify(t, t_env, t_init, k):
    # Formula: T(t) = T_env + (T_init - T_env) * e^(-kt)
    return t_env + (t_init - t_env) * math.exp(-k * t)

# 13. Universal Lambda Machine (Basic Church Encoding Example)
def universal_lambda():
    # Zero: λf.λx.x
    zero = lambda f: lambda x: x
    # Successor: λn.λf.λx.f(n f x)
    succ = lambda n: lambda f: lambda x: f(n(f)(x))
    # Test: Get integer value from Church numeral
    to_int = lambda n: n(lambda x: x + 1)(0)
    return to_int(succ(succ(zero)))  # Should return 2

# 14. Nautical bell (Standard 8-bell cycle)
def nautical_bell(time_str):
    # Watches are 4 hours long (8 half-hours). Cycle resets at 00:00, 04:00, etc.
    h, m = map(int, time_str.split(':'))
    half_hours = (h % 4) * 2 + (1 if m >= 30 else 0)
    return 8 if half_hours == 0 and m < 30 else half_hours

# 15. Earliest difference between primes
def prime_diff(target_diff):
    def is_prime(n):
        if n < 2: return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0: return False
        return True
    
    prev_prime = 2
    current = 3
    while True:
        if is_prime(current):
            if current - prev_prime == target_diff:
                return (prev_prime, current)
            prev_prime = current
        current += 2

# 16. Canny edge detector (Simplified concept: Sobel-based logic)
def canny_concept(pixel_grid):
    # Real Canny requires Gaussian blur, Sobel, Non-max suppression, and Hysteresis.
    # This mock represents the intensity gradient check core to the task.
    edges = [[0 for _ in row] for row in pixel_grid]
    for y in range(1, len(pixel_grid)-1):
        for x in range(1, len(pixel_grid[0])-1):
            grad_x = pixel_grid[y][x+1] - pixel_grid[y][x-1]
            grad_y = pixel_grid[y+1][x] - pixel_grid[y-1][x]
            edges[y][x] = math.sqrt(grad_x**2 + grad_y**2)
    return edges

# 17. Death Star (Mathematical model for the dish crater)
def draw_death_star(r=10):
    res = 0.5  # Adjust for aspect ratio
    for y in range(-r, r + 1):
        line = ""
        for x in range(int(-2.0 * r), int(2.0 * r) + 1):
            # Sphere equation: x^2 + y^2 + z^2 = r^2. We check if point is in sphere.
            # Crater: Another sphere subtracted or moved.
            if (x/2)**2 + y**2 <= r**2:
                # Check for the dish (indented area)
                if ((x/2)-r/2)**2 + (y-r/2)**2 <= (r/3)**2: line += " "
                else: line += "#"
            else: line += " "
        print(line)

# 18. Chat server (Core Socket Listener Pattern)
def chat_server_stub():
    # Minimal logic to show how a Rosetta Code chat server starts
    host, port = '127.0.0.1', 65432
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        # s.bind((host, port)) # Normally enabled for a running server
        # s.listen()
        return f"Server configured for {host}:{port}"

# 19. Faulhaber's triangle (Generates coefficients for sum of powers)
from fractions import Fraction
def faulhaber_triangle(n):
    def bernoulli(m):
        B = [0] * (m + 1)
        for i in range(m + 1):
            B[i] = Fraction(1, i + 1)
            for j in range(i, 0, -1):
                B[j-1] = j * (B[j-1] - B[j])
        return B[0]

    triangle = []
    for p in range(n):
        row = []
        for j in range(p + 1):
            # Calculation involves binomial coefficients and Bernoulli numbers
            val = Fraction(1, p + 1) * math.comb(p + 1, j) * bernoulli(j)
            row.append(val)
        triangle.append(row)
    return triangle

# 20. Execute a Markov algorithm
def markov_algorithm(rules, text):
    # rules: list of (pattern, replacement, is_terminal)
    while True:
        applied = False
        for pattern, replacement, terminal in rules:
            if pattern in text:
                text = text.replace(pattern, replacement, 1)
                if terminal: return text
                applied = True
                break
        if not applied: break
    return text
    
```