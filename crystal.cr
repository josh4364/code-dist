require "big"
require "socket"
require "complex"

# 1. Hello world/Text
def hello_world
  puts "Hello world!"
end

# 2. Fibonacci sequence (Iterative)
def fib(n)
  a, b = BigInt.new(0), BigInt.new(1)
  n.times do
    a, b = b, a + b
  end
  a
end

# 3. Factorial
def factorial(n)
  (1..n).reduce(BigInt.new(1)) { |acc, i| acc * i }
end

# 4. 99 bottles of beer
def bottles_of_beer
  99.step(to: 1, by: -1) do |i|
    s = i != 1 ? "s" : ""
    s_next = (i - 1) != 1 ? "s" : ""
    next_count = i - 1 > 0 ? (i - 1).to_s : "no more"
    puts "#{i} bottle#{s} of beer on the wall, #{i} bottle#{s} of beer."
    puts "Take one down, pass it around, #{next_count} bottle#{s_next} of beer on the wall.\n\n"
  end
end

# 5. Bubble sort
def bubble_sort(arr)
  n = arr.size
  (0...n).each do |i|
    (0...n - i - 1).each do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end
  arr
end

# 6. FizzBuzz
def fizzbuzz
  (1..100).each do |i|
    if i % 15 == 0
      puts "FizzBuzz"
    elsif i % 3 == 0
      puts "Fizz"
    elsif i % 5 == 0
      puts "Buzz"
    else
      puts i
    end
  end
end

# 7. Empty program
# (A file with no code or just a comment is valid in Crystal)

# 8. A+B
def a_plus_b(input_str)
  input_str.split.map(&.to_i).sum
end

# 9. 100 doors
def hundred_doors
  doors = Array.new(101, false)
  (1..100).each do |i|
    i.step(to: 100, by: i) do |j|
      doors[j] = !doors[j]
    end
  end
  (1..100).select { |i| doors[i] }
end

# 10. Quine
def quine
  s = "s = %p; printf(s, s)"
  printf(s, s)
end

# 11. Launch rocket
def launch_rocket
  accel = 9.8
  velocity = 0.0
  10.step(to: 0, by: -1) do |t|
    puts "T-minus #{t}..."
    sleep 0.1
  end
  puts "Liftoff!"
  (1..3).each do |t|
    velocity += accel
    puts "Time: #{t}s, Velocity: #{velocity.round(1)}m/s, Accel: #{accel}m/s^2"
  end
end

# 12. Experimental Verification of the NKT Law
def nkt_law_verify(t, t_env, t_init, k)
  t_env + (t_init - t_env) * Math.exp(-k * t)
end

# 13. Universal Lambda Machine (Using Procs)
def universal_lambda
  zero = ->(f : Int32 -> Int32) { ->(x : Int32) { x } }
  succ = ->(n : (Int32 -> Int32) -> (Int32 -> Int32)) {
    ->(f : Int32 -> Int32) {
      ->(x : Int32) { f.call(n.call(f).call(x)) }
    }
  }
  to_int = ->(n : (Int32 -> Int32) -> (Int32 -> Int32)) {
    n.call(->(x : Int32) { x + 1 }).call(0)
  }
  to_int.call(succ.call(succ.call(zero)))
end

# 14. Nautical bell
def nautical_bell(time_str)
  parts = time_str.split(':').map(&.to_i)
  h, m = parts[0], parts[1]
  half_hours = (h % 4) * 2 + (m >= 30 ? 1 : 0)
  (half_hours == 0 && m < 30) ? 8 : half_hours
end

# 15. Earliest difference between primes
def prime_diff(target_diff)
  is_prime = ->(n : Int32) {
    return false if n < 2
    (2..Math.sqrt(n).to_i).each { |i| return false if n % i == 0 }
    true
  }
  prev_prime = 2
  current = 3
  loop do
    if is_prime.call(current)
      return {prev_prime, current} if current - prev_prime == target_diff
      prev_prime = current
    end
    current += 2
  end
end

# 16. Canny edge detector (Mock)
def canny_concept(pixel_grid)
  height = pixel_grid.size
  width = pixel_grid[0].size
  edges = Array.new(height) { Array.new(width, 0.0) }
  (1...height - 1).each do |y|
    (1...width - 1).each do |x|
      grad_x = pixel_grid[y][x + 1] - pixel_grid[y][x - 1]
      grad_y = pixel_grid[y + 1][x] - pixel_grid[y - 1][x]
      edges[y][x] = Math.sqrt(grad_x**2 + grad_y**2)
    end
  end
  edges
end

# 17. Death Star
def draw_death_star(r = 10)
  (-r..r).each do |y|
    line = String.build do |str|
      (-(2 * r)..(2 * r)).each do |x|
        if (x / 2.0)**2 + y**2 <= r**2
          if ((x / 2.0) - r / 2.0)**2 + (y - r / 2.0)**2 <= (r / 3.0)**2
            str << " "
          else
            str << "#"
          end
        else
          str << " "
        end
      end
    end
    puts line
  end
end

# 18. Chat server (Stub)
def chat_server_stub
  host, port = "127.0.0.1", 65432
  # server = TCPServer.new(host, port)
  "Server configured for #{host}:#{port}"
end

# 19. Faulhaber's triangle
def faulhaber_triangle(n)
  bernoulli = ->(m : Int32) {
    b = Array.new(m + 1) { |i| 1.to_r / (i + 1) }
    (0..m).each do |i|
      i.step(to: 1, by: -1) do |j|
        b[j - 1] = j * (b[j - 1] - b[j])
      end
    end
    b[0]
  }

  comb = ->(n : Int32, k : Int32) {
    return 1.to_big_i if k == 0
    (1..k).reduce(1.to_big_i) { |acc, i| acc * (n - i + 1) // i }
  }

  (0...n).map do |p|
    (0..p).map do |j|
      (1.to_r / (p + 1)) * comb.call(p + 1, j) * bernoulli.call(j)
    end
  end
end

# 20. Execute a Markov algorithm
def markov_algorithm(rules, text)
  # rules is Array({String, String, Bool})
  loop do
    applied = false
    rules.each do |pattern, replacement, terminal|
      if text.includes?(pattern)
        text = text.sub(pattern, replacement)
        return text if terminal
        applied = true
        break
      end
    end
    break unless applied
  end
  text
end