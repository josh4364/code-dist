import java.net.ServerSocket
import java.util.*
import kotlin.math.*

// ==========================================
// PART 1: TOP 10 MOST IMPLEMENTED TASKS
// ==========================================

// 1. Hello world/Text
fun helloWorld() {
    println("Hello world!")
}

// 2. Fibonacci sequence
fun fib(n: Int): Long {
    var a = 0L
    var b = 1L
    repeat(n) {
        val temp = a
        a = b
        b = temp + b
    }
    return a
}

// 3. Factorial
fun factorial(n: Int): java.math.BigInteger {
    var res = java.math.BigInteger.ONE
    for (i in 2..n) res = res.multiply(java.math.BigInteger.valueOf(i.toLong()))
    return res
}

// 4. 99 bottles of beer
fun bottlesOfBeer() {
    for (i in 99 downTo 1) {
        val s = if (i != 1) "s" else ""
        val nextCount = if (i - 1 > 0) (i - 1).toString() else "no more"
        val sNext = if (i - 1 != 1) "s" else ""
        println("$i bottle$s of beer on the wall, $i bottle$s of beer.")
        println("Take one down, pass it around, $nextCount bottle$sNext of beer on the wall.\n")
    }
}

// 5. Bubble sort
fun <T : Comparable<T>> bubbleSort(arr: MutableList<T>): List<T> {
    val n = arr.size
    for (i in 0 until n) {
        for (j in 0 until n - i - 1) {
            if (arr[j] > arr[j + 1]) {
                val temp = arr[j]
                arr[j] = arr[j + 1]
                arr[j + 1] = temp
            }
        }
    }
    return arr
}

// 6. FizzBuzz
fun fizzBuzz() {
    for (i in 1..100) {
        when {
            i % 15 == 0 -> println("FizzBuzz")
            i % 3 == 0 -> println("Fizz")
            i % 5 == 0 -> println("Buzz")
            else -> println(i)
        }
    }
}

// 7. Empty program
fun main() {}

// 8. A+B
fun aPlusB(inputStr: String): Int {
    return inputStr.split(Regex("\\s+")).filter { it.isNotBlank() }.sumOf { it.toInt() }
}

// 9. 100 doors
fun hundredDoors(): List<Int> {
    val doors = BooleanArray(101)
    for (i in 1..100) {
        for (j in i..100 step i) {
            doors[j] = !doors[j]
        }
    }
    return doors.indices.filter { doors[it] }
}

// 10. Quine
fun quine() {
    val s = "fun main() { val s = %c%s%c; println(s.format(34, s, 34)) }"
    println(s.format(34, s, 34))
}

// ==========================================
// PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
// ==========================================

// 11. Launch rocket with countdown and acceleration
fun launchRocket() {
    val accel = 9.8
    var velocity = 0.0
    for (t in 10 downTo 0) {
        println("T-minus $t...")
        Thread.sleep(100)
    }
    println("Liftoff!")
    for (t in 1..3) {
        velocity += accel
        println("Time: ${t}s, Velocity: ${"%.1f".format(velocity)}m/s, Accel: ${accel}m/s^2")
    }
}

// 12. Experimental Verification of the NKT Law
fun nktLawVerify(t: Double, tEnv: Double, tInit: Double, k: Double): Double {
    return tEnv + (tInit - tEnv) * exp(-k * t)
}

// 13. Universal Lambda Machine
fun universalLambda() {
    val zero: ((Int) -> Int) -> (Int) -> Int = { _ -> { x -> x } }
    val succ: (((Int) -> Int) -> (Int) -> Int) -> ((Int) -> Int) -> (Int) -> Int = 
        { n -> { f -> { x -> f(n(f)(x)) } } }
    
    val toInt: (((Int) -> Int) -> (Int) -> Int) -> Int = { n -> n({ it + 1 })(0) }
    println(toInt(succ(succ(zero)))) // Returns 2
}

// 14. Nautical bell
fun nauticalBell(timeStr: String): Int {
    val parts = timeStr.split(":")
    val h = parts[0].toInt()
    val m = parts[1].toInt()
    val halfHours = (h % 4) * 2 + (if (m >= 30) 1 else 0)
    return if (halfHours == 0 && m < 30) 8 else halfHours
}

// 15. Earliest difference between primes
fun primeDiff(targetDiff: Int): Pair<Int, Int> {
    fun isPrime(n: Int): Boolean {
        if (n < 2) return false
        for (i in 2..sqrt(n.toDouble()).toInt()) if (n % i == 0) return false
        return true
    }
    var prevPrime = 2
    var current = 3
    while (true) {
        if (isPrime(current)) {
            if (current - prevPrime == targetDiff) return Pair(prevPrime, current)
            prevPrime = current
        }
        current += 2
    }
}

// 16. Canny edge detector (Simplified)
fun cannyConcept(pixelGrid: Array<DoubleArray>): Array<DoubleArray> {
    val rows = pixelGrid.size
    val cols = pixelGrid[0].size
    val edges = Array(rows) { DoubleArray(cols) }
    for (y in 1 until rows - 1) {
        for (x in 1 until cols - 1) {
            val gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1]
            val gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x]
            edges[y][x] = sqrt(gradX.pow(2) + gradY.pow(2))
        }
    }
    return edges
}

// 17. Death Star
fun drawDeathStar(r: Int = 10) {
    for (y in -r..r) {
        var line = ""
        for (x in (-2 * r)..(2 * r)) {
            val xAdj = x / 2.0
            if (xAdj.pow(2) + y.pow(2) <= r.pow(2)) {
                if ((xAdj - r / 2.0).pow(2) + (y - r / 2.0).pow(2) <= (r / 3.0).pow(2)) line += " "
                else line += "#"
            } else line += " "
        }
        println(line)
    }
}

// 18. Chat server (Stub)
fun chatServerStub(): String {
    val host = "127.0.0.1"
    val port = 65432
    // val server = ServerSocket(port) // Normally binding would happen here
    return "Server configured for $host:$port"
}

// 19. Faulhaber's triangle
fun faulhaberTriangle(n: Int): List<List<Double>> {
    fun combinations(n: Int, k: Int): Long {
        var res = 1L
        for (i in 1..k) res = res * (n - i + 1) / i
        return res
    }
    fun bernoulli(m: Int): Double {
        val b = DoubleArray(m + 1)
        for (i in 0..m) {
            b[i] = 1.0 / (i + 1)
            for (j in i downTo 1) b[j - 1] = j * (b[j - 1] - b[j])
        }
        return b[0]
    }
    return (0 until n).map { p ->
        (0..p).map { j ->
            (1.0 / (p + 1)) * combinations(p + 1, j) * bernoulli(j)
        }
    }
}

// 20. Execute a Markov algorithm
data class Rule(val pattern: String, val replacement: String, val isTerminal: Boolean)

fun markovAlgorithm(rules: List<Rule>, input: String): String {
    var text = input
    while (true) {
        var applied = false
        for (rule in rules) {
            if (text.contains(rule.pattern)) {
                text = text.replaceFirst(rule.pattern, rule.replacement)
                if (rule.isTerminal) return text
                applied = true
                break
            }
        }
        if (!applied) break
    }
    return text
}

private fun Int.pow(exp: Int): Double = this.toDouble().pow(exp)
private fun Double.pow(exp: Int): Double = this.pow(exp.toDouble())
