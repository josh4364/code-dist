require 'socket'
require 'bigdecimal'

# ==========================================
# PART 1: TOP 10 MOST IMPLEMENTED TASKS
# ==========================================

# 1. Hello world/Text
def hello_world
  puts "Hello world!"
end

# 2. Fibonacci sequence
def fib(n)
  a, b = 0, 1
  n.times { a, b = b, a + b }
  a
end

# 3. Factorial
def factorial(n)
  (1..n).inject(1, :*)
end

# 4. 99 bottles of beer
def bottles_of_beer
  99.downto(1) do |i|
    s = i != 1 ? "s" : ""
    s_next = (i - 1) != 1 ? "s" : ""
    next_count = (i - 1) > 0 ? (i - 1) : "no more"
    puts "#{i} bottle#{s} of beer on the wall, #{i} bottle#{s} of beer."
    puts "Take one down, pass it around, #{next_count} bottle#{s_next} of beer on the wall.\n\n"
  end
end

# 5. Bubble sort
def bubble_sort(arr)
  n = arr.length
  loop do
    swapped = false
    (n - 1).times do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i]
        swapped = true
      end
    end
    break unless swapped
  end
  arr
end

# 6. FizzBuzz
def fizzbuzz
  (1..100).each do |i|
    if i % 15 == 0 then puts "FizzBuzz"
    elsif i % 3 == 0 then puts "Fizz"
    elsif i % 5 == 0 then puts "Buzz"
    else puts i
    end
  end
end

# 7. Empty program
# Empty

# 8. A+B
def a_plus_b(input_str)
  input_str.split.map(&:to_i).sum
end

# 9. 100 doors
def hundred_doors
  doors = Array.new(101, false)
  (1..100).each do |i|
    (i..100).step(i) do |j|
      doors[j] = !doors[j]
    end
  end
  doors.each_with_index.select { |open, i| open }.map(&:last)
end

# 10. Quine
def quine
  s = "s = %p; printf(s, s)"
  printf(s, s)
end

# ==========================================
# PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
# ==========================================

# 11. Launch rocket with countdown and acceleration
def launch_rocket
  accel = 9.8
  velocity = 0.0
  10.downto(0) do |t|
    puts "T-minus #{t}..."
    sleep 0.1
  end
  puts "Liftoff!"
  (1..3).each do |t|
    velocity += accel
    puts "Time: #{t}s, Velocity: #{'%.1f' % velocity}m/s, Accel: #{accel}m/s^2"
  end
end

# 12. Experimental Verification of the NKT Law
def nkt_law_verify(t, t_env, t_init, k)
  t_env + (t_init - t_env) * Math.exp(-k * t)
end

# 13. Universal Lambda Machine
def universal_lambda
  zero = ->(f) { ->(x) { x } }
  succ = ->(n) { ->(f) { ->(x) { f.call(n.call(f).call(x)) } } }
  to_int = ->(n) { n.call(->(x) { x + 1 }).call(0) }
  to_int.call(succ.call(succ.call(zero)))
end

# 14. Nautical bell
def nautical_bell(time_str)
  h, m = time_str.split(':').map(&:to_i)
  half_hours = (h % 4) * 2 + (m >= 30 ? 1 : 0)
  (half_hours == 0 && m < 30) ? 8 : half_hours
end

# 15. Earliest difference between primes
def prime_diff(target_diff)
  is_prime = ->(n) {
    return false if n < 2
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  }
  prev_prime = 2
  current = 3
  loop do
    if is_prime.call(current)
      return [prev_prime, current] if current - prev_prime == target_diff
      prev_prime = current
    end
    current += 2
  end
end

# 16. Canny edge detector (Simplified concept)
def canny_concept(pixel_grid)
  rows = pixel_grid.length
  cols = pixel_grid[0].length
  edges = Array.new(rows) { Array.new(cols, 0) }
  (1...rows - 1).each do |y|
    (1...cols - 1).each do |x|
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
    line = ""
    ((-2 * r)..(2 * r)).each do |x|
      if (x / 2.0)**2 + y**2 <= r**2
        if ((x / 2.0) - r / 2.0)**2 + (y - r / 2.0)**2 <= (r / 3.0)**2
          line += " "
        else
          line += "#"
        end
      else
        line += " "
      end
    end
    puts line
  end
end

# 18. Chat server (Stub)
def chat_server_stub
  host, port = '127.0.0.1', 65432
  # server = TCPServer.new(host, port) # Normally enabled
  "Server configured for #{host}:#{port}"
end

# 19. Faulhaber's triangle
def faulhaber_triangle(n)
  bernoulli = ->(m) {
    b = Array.new(m + 1, 0)
    (0..m).each do |i|
      b[i] = Rational(1, i + 1)
      i.downto(1) do |j|
        b[j - 1] = j * (b[j - 1] - b[j])
      end
    end
    b[0]
  }
  
  comb = ->(n, k) {
    return 1 if k <= 0 || k >= n
    (1..k).inject(1) { |m, i| m * (n - i + 1) / i }
  }

  (0...n).map do |p|
    (0..p).map do |j|
      Rational(1, p + 1) * comb.call(p + 1, j) * bernoulli.call(j)
    end
  end
end

# 20. Execute a Markov algorithm
def markov_algorithm(rules, text)
  loop do
    applied = false
    rules.each do |pattern, replacement, terminal|
      if text.include?(pattern)
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