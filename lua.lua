local socket = require("socket") -- Assumes LuaSocket is available for task 18

-- ==========================================
-- PART 1: TOP 10 MOST IMPLEMENTED TASKS
-- ==========================================

-- 1. Hello world/Text
function hello_world()
    print("Hello world!")
end

-- 2. Fibonacci sequence
function fib(n)
    local a, b = 0, 1
    for i = 1, n do
        a, b = b, a + b
    end
    return a
end

-- 3. Factorial
function factorial(n)
    local res = 1
    for i = 2, n do res = res * i end
    return res
end

-- 4. 99 bottles of beer
function bottles_of_beer()
    for i = 99, 1, -1 do
        local s = (i ~= 1) and "s" or ""
        local next_val = i - 1
        local s_next = (next_val ~= 1) and "s" or ""
        local next_count = (next_val > 0) and next_val or "no more"
        print(string.format("%d bottle%s of beer on the wall, %d bottle%s of beer.", i, s, i, s))
        print(string.format("Take one down, pass it around, %s bottle%s of beer on the wall.\n", next_count, s_next))
    end
end

-- 5. Bubble sort
function bubble_sort(arr)
    local n = #arr
    for i = 1, n do
        for j = 1, n - i do
            if arr[j] > arr[j + 1] then
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
            end
        end
    end
    return arr
end

-- 6. FizzBuzz
function fizzbuzz()
    for i = 1, 100 do
        if i % 15 == 0 then print("FizzBuzz")
        elseif i % 3 == 0 then print("Fizz")
        elseif i % 5 == 0 then print("Buzz")
        else print(i) end
    end
end

-- 7. Empty program
-- (Empty file)

-- 8. A+B
function a_plus_b(input_str)
    local sum = 0
    for x in input_str:gmatch("%S+") do
        sum = sum + tonumber(x)
    end
    return sum
end

-- 9. 100 doors
function hundred_doors()
    local doors = {}
    for i = 1, 100 do doors[i] = false end
    for i = 1, 100 do
        for j = i, 100, i do
            doors[j] = not doors[j]
        end
    end
    local open_doors = {}
    for i, is_open in ipairs(doors) do
        if is_open then table.insert(open_doors, i) end
    end
    return open_doors
end

-- 10. Quine
function quine()
    local s = "local s = %q; print(s:format(s))"
    print(s:format(s))
end

-- ==========================================
-- PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
-- ==========================================

-- 11. Launch rocket
function launch_rocket()
    local accel, velocity = 9.8, 0
    for t = 10, 0, -1 do
        print(string.format("T-minus %d...", t))
        os.execute("sleep 0.1") -- Platform dependent
    end
    print("Liftoff!")
    for t = 1, 3 do
        velocity = velocity + accel
        print(string.format("Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2", t, velocity, accel))
    end
end

-- 12. NKT Law (Newton's Law of Cooling)
function nkt_law_verify(t, t_env, t_init, k)
    return t_env + (t_init - t_env) * math.exp(-k * t)
end

-- 13. Universal Lambda Machine
function universal_lambda()
    local zero = function(f) return function(x) return x end end
    local succ = function(n) return function(f) return function(x) return f(n(f)(x)) end end end
    local to_int = function(n) return n(function(x) return x + 1 end)(0) end
    return to_int(succ(succ(zero)))
end

-- 14. Nautical bell
function nautical_bell(time_str)
    local h, m = time_str:match("(%d+):(%d+)")
    h, m = tonumber(h), tonumber(m)
    local half_hours = (h % 4) * 2 + (m >= 30 and 1 or 0)
    return (half_hours == 0 and m < 30) and 8 or half_hours
end

-- 15. Earliest difference between primes
function prime_diff(target_diff)
    local function is_prime(n)
        if n < 2 then return false end
        for i = 2, math.sqrt(n) do
            if n % i == 0 then return false end
        end
        return true
    end
    local prev_prime, current = 2, 3
    while true do
        if is_prime(current) then
            if current - prev_prime == target_diff then return prev_prime, current end
            prev_prime = current
        end
        current = current + 2
    end
end

-- 16. Canny edge detector (Simplified)
function canny_concept(pixel_grid)
    local edges = {}
    for y = 1, #pixel_grid do
        edges[y] = {}
        for x = 1, #pixel_grid[1] do
            if y > 1 and y < #pixel_grid and x > 1 and x < #pixel_grid[1] then
                local gx = pixel_grid[y][x+1] - pixel_grid[y][x-1]
                local gy = pixel_grid[y+1][x] - pixel_grid[y-1][x]
                edges[y][x] = math.sqrt(gx^2 + gy^2)
            else
                edges[y][x] = 0
            end
        end
    end
    return edges
end

-- 17. Death Star
function draw_death_star(r)
    r = r or 10
    for y = -r, r do
        local line = ""
        for x = math.floor(-2.0 * r), math.floor(2.0 * r) do
            if (x/2)^2 + y^2 <= r^2 then
                if ((x/2)-r/2)^2 + (y-r/2)^2 <= (r/3)^2 then line = line .. " "
                else line = line .. "#" end
            else line = line .. " " end
        end
        print(line)
    end
end

-- 18. Chat server
function chat_server_stub()
    local host, port = '127.0.0.1', 65432
    -- Requires LuaSocket: local s = socket.tcp()
    return string.format("Server configured for %s:%d", host, port)
end

-- 19. Faulhaber's triangle (Using basic numbers as Lua lacks built-in Fractions)
function faulhaber_triangle(n)
    local function nCr(n, r)
        if r > n then return 0 end
        local res = 1
        for i = 1, r do res = res * (n - i + 1) / i end
        return res
    end
    local B = {1} -- Simplified Bernoulli
    for m = 1, n do
        local sum = 0
        for k = 0, m - 1 do sum = sum + nCr(m + 1, k) * (B[k+1] or 0) end
        B[m+1] = -1 / (m + 1) * sum
    end
    local triangle = {}
    for p = 0, n - 1 do
        triangle[p+1] = {}
        for j = 0, p do
            triangle[p+1][j+1] = (1 / (p + 1)) * nCr(p + 1, j) * B[j+1]
        end
    end
    return triangle
end

-- 20. Execute a Markov algorithm
function markov_algorithm(rules, text)
    while true do
        local applied = false
        for _, rule in ipairs(rules) do
            local pattern, replacement, terminal = rule[1], rule[2], rule[3]
            local start_idx, end_idx = text:find(pattern, 1, true)
            if start_idx then
                text = text:sub(1, start_idx - 1) .. replacement .. text:sub(end_idx + 1)
                if terminal then return text end
                applied = true
                break
            end
        end
        if not applied then break end
    end
    return text
end