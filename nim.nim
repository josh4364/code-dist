import math, strutils, strformat, os, times, net, sugar, fractions

# 1. Hello world/Text
proc helloWorld() =
  echo "Hello world!"

# 2. Fibonacci sequence
proc fib(n: int): int =
  var a = 0
  var b = 1
  for _ in 0 ..< n:
    let tmp = a
    a = b
    b = tmp + b
  return a

# 3. Factorial
proc factorial(n: int): int =
  if n < 2: return 1
  result = 1
  for i in 2..n: result *= i

# 4. 99 bottles of beer
proc bottlesOfBeer() =
  for i in countdown(99, 1):
    let s = if i != 1: "s" else: ""
    let sNext = if i-1 != 1: "s" else: ""
    let nextCount = if i - 1 > 0: $(i - 1) else: "no more"
    echo &"{i} bottle{s} of beer on the wall, {i} bottle{s} of beer."
    echo &"Take one down, pass it around, {nextCount} bottle{sNext} of beer on the wall.\n"

# 5. Bubble sort
proc bubbleSort[T](arr: var seq[T]): seq[T] =
  let n = arr.len
  for i in 0 ..< n:
    for j in 0 ..< n - i - 1:
      if arr[j] > arr[j + 1]:
        swap(arr[j], arr[j + 1])
  return arr

# 6. FizzBuzz
proc fizzbuzz() =
  for i in 1..100:
    if i mod 15 == 0: echo "FizzBuzz"
    elif i mod 3 == 0: echo "Fizz"
    elif i mod 5 == 0: echo "Buzz"
    else: echo i

# 7. Empty program
discard

# 8. A+B
proc aPlusB(inputStr: string): int =
  result = 0
  for x in inputStr.splitWhitespace():
    result += parseInt(x)

# 9. 100 doors
proc hundredDoors(): seq[int] =
  var doors = newSeq[bool](101)
  for i in 1..100:
    for j in countup(i, 100, i):
      doors[j] = not doors[j]
  for i, isOpen in doors:
    if isOpen: result.add(i)

# 10. Quine
proc quine() =
  let s = "proc quine() =%c  let s = %c%s%c%c  echo s %% [char(10), char(34), s, char(34), char(10)]%cquine()"
  echo s % [char(10), char(34), s, char(34), char(10)]
quine()

# 11. Launch rocket
proc launchRocket() =
  let accel = 9.8
  var velocity = 0.0
  for t in countdown(10, 0):
    echo &"T-minus {t}..."
    sleep(100)
  echo "Liftoff!"
  for t in 1..3:
    velocity += accel
    echo &"Time: {t}s, Velocity: {velocity:.1f}m/s, Accel: {accel}m/s^2"

# 12. NKT Law (Newton's Law of Cooling)
proc nktLawVerify(t, tEnv, tInit, k: float): float =
  return tEnv + (tInit - tEnv) * exp(-k * t)

# 13. Universal Lambda Machine
proc universalLambda(): int =
  type Lambda = (int -> int) -> (int -> int)
  let zero = (f: int -> int) => ((x: int) => x)
  let succ = (n: Lambda) => ((f: int -> int) => ((x: int) => f(n(f)(x))))
  let toInt = (n: Lambda) => n((x: int) => x + 1)(0)
  return toInt(succ(succ(zero)))

# 14. Nautical bell
proc nauticalBell(timeStr: string): int =
  let parts = timeStr.split(':')
  let h = parseInt(parts[0])
  let m = parseInt(parts[1])
  let halfHours = (h mod 4) * 2 + (if m >= 30: 1 else: 0)
  return if halfHours == 0 and m < 30: 8 else: halfHours

# 15. Earliest difference between primes
proc primeDiff(targetDiff: int): (int, int) =
  proc isPrime(n: int): bool =
    if n < 2: return false
    for i in 2 .. sqrt(n.float).int:
      if n mod i == 0: return false
    return true
  var prevPrime = 2
  var current = 3
  while true:
    if isPrime(current):
      if current - prevPrime == targetDiff: return (prevPrime, current)
      prevPrime = current
    current += 2

# 16. Canny edge detector (Mock)
proc cannyConcept(pixelGrid: seq[seq[float]]): seq[seq[float]] =
  let rows = pixelGrid.len
  let cols = pixelGrid[0].len
  var edges = newSeqWith(rows, newSeq[float](cols))
  for y in 1 ..< rows - 1:
    for x in 1 ..< cols - 1:
      let gradX = pixelGrid[y][x+1] - pixelGrid[y][x-1]
      let gradY = pixelGrid[y+1][x] - pixelGrid[y-1][x]
      edges[y][x] = sqrt(gradX^2 + gradY^2)
  return edges

# 17. Death Star
proc drawDeathStar(r: int = 10) =
  for y in -r .. r:
    var line = ""
    for x in int(-2.0 * r.float) .. int(2.0 * r.float):
      if (x.float/2.0)^2 + y.float^2 <= r.float^2:
        if (x.float/2.0 - r.float/2.0)^2 + (y.float - r.float/2.0)^2 <= (r.float/3.0)^2:
          line.add(' ')
        else:
          line.add('#')
      else:
        line.add(' ')
    echo line

# 18. Chat server stub
proc chatServerStub(): string =
  let host = "127.0.0.1"
  let port = 65432.Port
  # var s = newSocket()
  # s.setSockOpt(OptReuseAddr, true)
  return &"Server configured for {host}:{port}"

# 19. Faulhaber's triangle
proc faulhaberTriangle(n: int): seq[seq[Fraction]] =
  proc bernoulli(m: int): Fraction =
    var b = newSeq[Fraction](m + 1)
    for i in 0..m:
      b[i] = initFraction(1, i + 1)
      for j in countdown(i, 1):
        b[j-1] = initFraction(j, 1) * (b[j-1] - b[j])
    return b[0]
  
  proc binom(n, k: int): int =
    if k < 0 or k > n: return 0
    if k == 0 or k == n: return 1
    var res = 1
    for i in 1..min(k, n - k):
      res = res * (n - i + 1) div i
    return res

  for p in 0 ..< n:
    var row: seq[Fraction] = @[]
    for j in 0 .. p:
      let val = initFraction(1, p + 1) * initFraction(binom(p + 1, j), 1) * bernoulli(j)
      row.add(val)
    result.add(row)

# 20. Execute a Markov algorithm
proc markovAlgorithm(rules: seq[(string, string, bool)], text: string): string =
  var res = text
  while true:
    var applied = false
    for (pattern, replacement, terminal) in rules:
      let idx = res.find(pattern)
      if idx != -1:
        res.delete(idx, idx + pattern.len - 1)
        res.insert(replacement, idx)
        if terminal: return res
        applied = true
        break
    if not applied: break
  return res