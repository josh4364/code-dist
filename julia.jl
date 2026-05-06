using Printf
using Sockets
using LinearAlgebra
using Statistics

# ==========================================
# PART 1: TOP 10 MOST IMPLEMENTED TASKS
# ==========================================

# 1. Hello world/Text
function hello_world()
    println("Hello world!")
end

# 2. Fibonacci sequence
function fib(n)
    a, b = BigInt(0), BigInt(1)
    for _ in 1:n
        a, b = b, a + b
    end
    return a
end

# 3. Factorial
function factorial_task(n)
    return factorial(big(n))
end

# 4. 99 bottles of beer
function bottles_of_beer()
    for i in 99:-1:1
        s = i != 1 ? "s" : ""
        s_next = (i - 1) != 1 ? "s" : ""
        next_count = (i - 1) > 0 ? string(i - 1) : "no more"
        println("$i bottle$s of beer on the wall, $i bottle$s of beer.")
        println("Take one down, pass it around, $next_count bottle$s_next of beer on the wall.\n")
    end
end

# 5. Bubble sort
function bubble_sort!(arr)
    n = length(arr)
    for i in 1:n
        for j in 1:n-i
            if arr[j] > arr[j+1]
                arr[j], arr[j+1] = arr[j+1], arr[j]
            end
        end
    end
    return arr
end

# 6. FizzBuzz
function fizzbuzz()
    for i in 1:100
        if i % 15 == 0 println("FizzBuzz")
        elseif i % 3 == 0 println("Fizz")
        elseif i % 5 == 0 println("Buzz")
        else println(i)
        end
    end
end

# 7. Empty program
# (Empty)

# 8. A+B
function a_plus_b(input_str)
    return sum(parse.(Int, split(input_str)))
end

# 9. 100 doors
function hundred_doors()
    doors = fill(false, 100)
    for i in 1:100
        for j in i:i:100
            doors[j] = !doors[j]
        end
    end
    return findall(doors)
end

# 10. Quine
function quine()
    s = "s = %p; @printf(stdout, s, s)"
    @printf(stdout, s, s)
end

# ==========================================
# PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
# ==========================================

# 11. Launch rocket with countdown and acceleration
function launch_rocket()
    accel = 9.8
    velocity = 0.0
    for t in 10:-1:0
        println("T-minus $t...")
        sleep(0.1)
    end
    println("Liftoff!")
    for t in 1:3
        velocity += accel
        @printf("Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n", t, velocity, accel)
    end
end

# 12. Experimental Verification of the NKT Law
function nkt_law_verify(t, t_env, t_init, k)
    return t_env + (t_init - t_env) * exp(-k * t)
end

# 13. Universal Lambda Machine
function universal_lambda()
    zero = f -> x -> x
    succ = n -> f -> x -> f(n(f)(x))
    to_int = n -> n(x -> x + 1)(0)
    return to_int(succ(succ(zero)))
end

# 14. Nautical bell
function nautical_bell(time_str)
    h, m = parse.(Int, split(time_str, ':'))
    half_hours = (h % 4) * 2 + (m >= 30 ? 1 : 0)
    return (half_hours == 0 && m < 30) ? 8 : half_hours
end

# 15. Earliest difference between primes
function is_prime(n)
    if n < 2 return false end
    for i in 2:isqrt(n)
        if n % i == 0 return false end
    end
    return true
end

function prime_diff(target_diff)
    prev_prime = 2
    current = 3
    while true
        if is_prime(current)
            if current - prev_prime == target_diff
                return (prev_prime, current)
            end
            prev_prime = current
        end
        current += 2
    end
end

# 16. Canny edge detector (Sobel concept)
function canny_concept(pixel_grid)
    rows, cols = size(pixel_grid)
    edges = zeros(Float64, rows, cols)
    for y in 2:rows-1
        for x in 2:cols-1
            grad_x = pixel_grid[y, x+1] - pixel_grid[y, x-1]
            grad_y = pixel_grid[y+1, x] - pixel_grid[y-1, x]
            edges[y, x] = sqrt(grad_x^2 + grad_y^2)
        end
    end
    return edges
end

# 17. Death Star
function draw_death_star(r=10)
    for y in -r:r
        line = ""
        for x in Int(-2.0*r):Int(2.0*r)
            if (x/2)^2 + y^2 <= r^2
                if ((x/2)-r/2)^2 + (y-r/2)^2 <= (r/3)^2
                    line *= " "
                else
                    line *= "#"
                end
            else
                line *= " "
            end
        end
        println(line)
    end
end

# 18. Chat server stub
function chat_server_stub()
    host, port = ip"127.0.0.1", 65432
    # In Julia, we'd use listen(host, port)
    return "Server configured for $host:$port"
end

# 19. Faulhaber's triangle
function faulhaber_triangle(n)
    function bernoulli(m)
        B = Vector{Rational{BigInt}}(undef, m + 1)
        for i in 0:m
            B[i+1] = 1 // (i + 1)
            for j in i:-1:1
                B[j] = j * (B[j] - B[j+1])
            end
        end
        return B[1]
    end

    triangle = Vector{Vector{Rational{BigInt}}}()
    for p in 0:n-1
        row = Rational{BigInt}[]
        for j in 0:p
            val = (1 // (p + 1)) * binomial(p + 1, j) * bernoulli(j)
            push!(row, val)
        end
        push!(triangle, row)
    end
    return triangle
end

# 20. Execute a Markov algorithm
function markov_algorithm(rules, text)
    # rules: tuple of (pattern, replacement, is_terminal)
    while true
        applied = false
        for (pattern, replacement, terminal) in rules
            if contains(text, pattern)
                text = replace(text, pattern => replacement, count=1)
                if terminal return text end
                applied = true
                break
            end
        end
        if !applied break end
    end
    return text
end