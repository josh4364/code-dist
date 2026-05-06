defmodule RosettaCode do
  # 1. Hello world/Text
  def hello_world, do: IO.puts("Hello world!")

  # 2. Fibonacci sequence (Recursive with tail-call optimization)
  def fib(n), do: do_fib(n, 0, 1)
  defp do_fib(0, a, _b), do: a
  defp do_fib(n, a, b), do: do_fib(n - 1, b, a + b)

  # 3. Factorial
  def factorial(0), do: 1
  def factorial(n) when n > 0, do: Enum.reduce(1..n, 1, &*/2)

  # 4. 99 bottles of beer
  def bottles_of_beer do
    for i <- 99..1 do
      s = if i != 1, do: "s", else: ""
      s_next = if i - 1 != 1, do: "s", else: ""
      next_count = if i - 1 > 0, do: i - 1, else: "no more"
      IO.puts("#{i} bottle#{s} of beer on the wall, #{i} bottle#{s} of beer.")
      IO.puts("Take one down, pass it around, #{next_count} bottle#{s_next} of beer on the wall.\n")
    end
  end

  # 5. Bubble sort
  def bubble_sort(list) when is_list(list) do
    n = length(list)
    if n <= 1 do
      list
    else
      Enum.reduce(1..n, list, fn _, acc -> sweep(acc) end)
    end
  end
  defp sweep([h1, h2 | t]) when h1 > h2, do: [h2 | sweep([h1 | t])]
  defp sweep([h1, h2 | t]), do: [h1 | sweep([h2 | t])]
  defp sweep(list), do: list

  # 6. FizzBuzz
  def fizzbuzz do
    for i <- 1..100 do
      cond do
        rem(i, 15) == 0 -> IO.puts("FizzBuzz")
        rem(i, 3) == 0 -> IO.puts("Fizz")
        rem(i, 5) == 0 -> IO.puts("Buzz")
        true -> IO.puts(i)
      end
    end
  end

  # 7. Empty program
  # (Empty file or a module definition is valid Elixir)

  # 8. A+B
  def a_plus_b(input_str) do
    input_str
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  # 9. 100 doors
  def hundred_doors do
    doors = Tuple.duplicate(false, 101)
    final_doors = Enum.reduce(1..100, doors, fn i, acc ->
      Enum.reduce(step_range(i, 100, i), acc, fn j, inner_acc ->
        put_elem(inner_acc, j, !elem(inner_acc, j))
      end)
    end)
    for i <- 1..100, elem(final_doors, i), do: i
  end
  defp step_range(start, stop, step), do: Stream.iterate(start, &(&1 + step)) |> Stream.take_while(&(&1 <= stop))

  # 10. Quine
  def quine do
    s = "s = ~p; :io.format(s, [s])"
    :io.format(s, [s])
  end

  # 11. Launch rocket
  def launch_rocket do
    accel = 9.8
    for t <- 10..0 do
      IO.puts("T-minus #{t}...")
      Process.sleep(100)
    end
    IO.puts("Liftoff!")
    Enum.reduce(1..3, 0.0, fn t, velocity ->
      new_v = velocity + accel
      IO.puts("Time: #{t}s, Velocity: #{Float.round(new_v, 1)}m/s, Accel: #{accel}m/s^2")
      new_v
    end)
  end

  # 12. Experimental Verification of the NKT Law
  def nkt_law_verify(t, t_env, t_init, k) do
    t_env + (t_init - t_env) * :math.exp(-k * t)
  end

  # 13. Universal Lambda Machine
  def universal_lambda do
    zero = fn _f -> fn x -> x end end
    succ = fn n -> fn f -> fn x -> f.(n.(f).(x)) end end end
    to_int = fn n -> n.(fn x -> x + 1 end).(0) end
    to_int.(succ.(succ.(zero)))
  end

  # 14. Nautical bell
  def nautical_bell(time_str) do
    [h, m] = String.split(time_str, ":") |> Enum.map(&String.to_integer/1)
    half_hours = rem(h, 4) * 2 + (if m >= 30, do: 1, else: 0)
    if half_hours == 0 and m < 30, do: 8, else: half_hours
  end

  # 15. Earliest difference between primes
  def prime_diff(target_diff) do
    Stream.iterate(3, &(&1 + 2))
    |> Stream.filter(&is_prime/1)
    |> Enum.reduce_while(2, fn curr, prev ->
      if curr - prev == target_diff, do: {:halt, {prev, curr}}, else: {:cont, curr}
    end)
  end
  defp is_prime(n) when n < 2, do: false
  defp is_prime(2), do: true
  defp is_prime(n) do
    limit = :math.sqrt(n) |> trunc()
    !Enum.any?(2..limit, fn i -> rem(n, i) == 0 end)
  end

  # 16. Canny edge detector (Conceptual)
  def canny_concept(pixel_grid) do
    rows = length(pixel_grid)
    cols = length(hd(pixel_grid))
    grid = Enum.map(pixel_grid, &List.to_tuple/1) |> List.to_tuple()

    for y <- 1..(rows - 2) do
      for x <- 1..(cols - 2) do
        grad_x = elem(elem(grid, y), x + 1) - elem(elem(grid, y), x - 1)
        grad_y = elem(elem(grid, y + 1), x) - elem(elem(grid, y - 1), x)
        :math.sqrt(grad_x * grad_x + grad_y * grad_y)
      end
    end
  end

  # 17. Death Star
  def draw_death_star(r \\ 10) do
    for y <- -r..r do
      line = for x <- round(-2.0 * r)..round(2.0 * r), into: "" do
        cond do
          :math.pow(x / 2, 2) + :math.pow(y, 2) <= :math.pow(r, 2) ->
            if :math.pow(x / 2 - r / 2, 2) + :math.pow(y - r / 2, 2) <= :math.pow(r / 3, 2), do: " ", else: "#"
          true -> " "
        end
      end
      IO.puts(line)
    end
  end

  # 18. Chat server (Stub)
  def chat_server_stub do
    host = '127.0.0.1'
    port = 65432
    # opts = [:binary, packet: :line, active: false, reuseaddr: true]
    # {:ok, _socket} = :gen_tcp.listen(port, opts)
    "Server configured for #{List.to_string(host)}:#{port}"
  end

  # 19. Faulhaber's triangle
  def faulhaber_triangle(n) do
    for p <- 0..(n - 1) do
      for j <- 0..p do
        # Simplified: Elixir doesn't have a native Fraction lib in core, 
        # so we return floats or use a custom ratio logic.
        (1 / (p + 1)) * comb(p + 1, j) * bernoulli(j)
      end
    end
  end
  defp comb(n, k), do: div(factorial(n), factorial(k) * factorial(n - k))
  defp bernoulli(m) do
    # Basic Akiyama-Tanigawa algorithm for Bernoulli numbers
    res = Enum.reduce(0..m, [], fn i, acc -> [1 / (i + 1) | acc] end) |> Enum.reverse()
    final_list = Enum.reduce(1..m, res, fn j, acc ->
      for i <- 0..(m - j), do: (j + 1) * (Enum.at(acc, i) - Enum.at(acc, i + 1))
    end)
    hd(final_list)
  end

  # 20. Execute a Markov algorithm
  def markov_algorithm(rules, text) do
    case Enum.find(rules, fn {p, _, _} -> String.contains?(text, p) end) do
      nil -> text
      {pattern, replacement, terminal} ->
        new_text = String.replace(text, pattern, replacement, global: false)
        if terminal, do: new_text, else: markov_algorithm(rules, new_text)
    end
  end
end