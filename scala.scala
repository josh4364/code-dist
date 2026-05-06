import scala.math._
import java.net.ServerSocket
import java.util.Scanner

object RosettaCodeTasks {

  // 1. Hello world/Text
  def helloWorld(): Unit = {
    println("Hello world!")
  }

  // 2. Fibonacci sequence (Iterative)
  def fib(n: Int): Long = {
    var a = 0L
    var b = 1L
    for (_ <- 0 until n) {
      val temp = a
      a = b
      b = temp + b
    }
    a
  }

  // 3. Factorial
  def factorial(n: Int): BigInt = {
    (1 to n).map(BigInt(_)).product
  }

  // 4. 99 bottles of beer
  def bottlesOfBeer(): Unit = {
    for (i <- 99 downTo 1) {
      val s = if (i != 1) "s" else ""
      val sNext = if (i - 1 != 1) "s" else ""
      val nextCount = if (i - 1 > 0) (i - 1).toString else "no more"
      println(s"$i bottle$s of beer on the wall, $i bottle$s of beer.")
      println(s"Take one down, pass it around, $nextCount bottle$sNext of beer on the wall.\n")
    }
  }

  // 5. Bubble sort
  def bubbleSort(arr: Array[Int]): Array[Int] = {
    val n = arr.length
    for (i <- 0 until n; j <- 0 until n - i - 1) {
      if (arr(j) > arr(j + 1)) {
        val temp = arr(j)
        arr(j) = arr(j + 1)
        arr(j + 1) = temp
      }
    }
    arr
  }

  // 6. FizzBuzz
  def fizzBuzz(): Unit = {
    for (i <- 1 to 100) {
      if (i % 15 == 0) println("FizzBuzz")
      else if (i % 3 == 0) println("Fizz")
      else if (i % 5 == 0) println("Buzz")
      else println(i)
    }
  }

  // 7. Empty program
  def emptyProgram(): Unit = {
    ()
  }

  // 8. A+B
  def aPlusB(inputStr: String): Int = {
    inputStr.split("\\s+").filter(_.nonEmpty).map(_.toInt).sum
  }

  // 9. 100 doors
  def hundredDoors(): List[Int] = {
    val doors = Array.fill(101)(false)
    for (i <- 1 to 100; j <- i to 100 by i) {
      doors(j) = !doors(j)
    }
    doors.zipWithIndex.collect { case (true, i) => i }.toList
  }

  // 10. Quine
  def quine(): Unit = {
    val s = "val s = %c%s%1$c; printf(s, 34, s)"
    printf(s, 34, s)
  }

  // 11. Launch rocket
  def launchRocket(): Unit = {
    val accel = 9.8
    var velocity = 0.0
    for (t <- 10 downTo 0) {
      println(s"T-minus $t...")
      Thread.sleep(100)
    }
    println("Liftoff!")
    for (t <- 1 to 3) {
      velocity += accel
      println(f"Time: ${t}s, Velocity: $velocity%.1fm/s, Accel: $accel m/s^2")
    }
  }

  // 12. Experimental Verification of the NKT Law
  def nktLawVerify(t: Double, tEnv: Double, tInit: Double, k: Double): Double = {
    tEnv + (tInit - tEnv) * exp(-k * t)
  }

  // 13. Universal Lambda Machine
  def universalLambda(): Int = {
    type Lambda = (Int => Int) => (Int => Int)
    val zero: Lambda = f => x => x
    val succ: Lambda => Lambda = n => f => x => f(n(f)(x))
    val toInt: Lambda => Int = n => n(x => x + 1)(0)
    toInt(succ(succ(zero)))
  }

  // 14. Nautical bell
  def nauticalBell(timeStr: String): Int = {
    val parts = timeStr.split(":")
    val h = parts(0).toInt
    val m = parts(1).toInt
    val halfHours = (h % 4) * 2 + (if (m >= 30) 1 else 0)
    if (halfHours == 0 && m < 30) 8 else halfHours
  }

  // 15. Earliest difference between primes
  def primeDiff(targetDiff: Int): (Int, Int) = {
    def isPrime(n: Int): Boolean = {
      if (n < 2) false
      else if (n == 2) true
      else !(2 to sqrt(n).toInt).exists(n % _ == 0)
    }
    var prevPrime = 2
    var current = 3
    while (true) {
      if (isPrime(current)) {
        if (current - prevPrime == targetDiff) return (prevPrime, current)
        prevPrime = current
      }
      current += 2
    }
    throw new Exception("Not found")
  }

  // 16. Canny edge detector (Sobel core)
  def cannyConcept(pixelGrid: Array[Array[Int]]): Array[Array[Double]] = {
    val rows = pixelGrid.length
    val cols = pixelGrid(0).length
    val edges = Array.ofDim[Double](rows, cols)
    for (y <- 1 until rows - 1; x <- 1 until cols - 1) {
      val gradX = pixelGrid(y)(x + 1) - pixelGrid(y)(x - 1)
      val gradY = pixelGrid(y + 1)(x) - pixelGrid(y - 1)(x)
      edges(y)(x) = sqrt(pow(gradX, 2) + pow(gradY, 2))
    }
    edges
  }

  // 17. Death Star
  def drawDeathStar(r: Int = 10): Unit = {
    for (y <- -r to r) {
      val line = for (x <- (-2 * r) to (2 * r)) yield {
        val xScaled = x / 2.0
        if (pow(xScaled, 2) + pow(y, 2) <= pow(r, 2)) {
          if (pow(xScaled - r / 2.0, 2) + pow(y - r / 2.0, 2) <= pow(r / 3.0, 2)) " "
          else "#"
        } else " "
      }
      println(line.mkString)
    }
  }

  // 18. Chat server
  def chatServerStub(): String = {
    val host = "127.0.0.1"
    val port = 65432
    // val server = new ServerSocket(port) // Simulated
    s"Server configured for $host:$port"
  }

  // 19. Faulhaber's triangle
  case class Frac(n: BigInt, d: BigInt) {
    private val g = n.gcd(d); val num = n / g; val den = d / g
    def *(o: Frac) = Frac(num * o.num, den * o.den)
    def -(o: Frac) = Frac(num * o.den - o.num * den, den * o.den)
  }
  def faulhaberTriangle(n: Int): List[List[Frac]] = {
    def comb(n: Int, k: Int): BigInt = {
      if (k < 0 || k > n) 0 else factorial(n) / (factorial(k) * factorial(n - k))
    }
    def bernoulli(m: Int): Frac = {
      val b = Array.fill(m + 1)(Frac(0, 1))
      for (i <- 0 to m) {
        b(i) = Frac(1, i + 1)
        for (j <- i downTo 1) b(j - 1) = Frac(j, 1) * (b(j - 1) - b(j))
      }
      b(0)
    }
    (0 until n).map { p =>
      (0 to p).map { j =>
        Frac(1, p + 1) * Frac(comb(p + 1, j), 1) * bernoulli(j)
      }.toList
    }.toList
  }

  // 20. Markov algorithm
  case class Rule(pattern: String, replacement: String, terminal: Boolean)
  def markovAlgorithm(rules: List[Rule], text: String): String = {
    var currentText = text
    var active = true
    while (active) {
      active = false
      rules.find(r => currentText.contains(r.pattern)) match {
        case Some(rule) =>
          currentText = currentText.replaceFirst(java.util.regex.Pattern.quote(rule.pattern), rule.replacement)
          if (rule.terminal) return currentText
          active = true
        case None => ()
      }
    }
    currentText
  }
}