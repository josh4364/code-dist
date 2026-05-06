import java.net.ServerSocket
import java.net.Socket
import groovy.transform.Field

// ==========================================
// PART 1: TOP 10 MOST IMPLEMENTED TASKS
// ==========================================

// 1. Hello world/Text
def helloWorld() {
    println "Hello world!"
}

// 2. Fibonacci sequence
def fib(n) {
    def (a, b) = [0G, 1G]
    n.times {
        def temp = a
        a = b
        b = temp + b
    }
    a
}

// 3. Factorial
def factorial(n) {
    (1..n).inject(1G) { acc, val -> acc * val }
}

// 4. 99 bottles of beer
def bottlesOfBeer() {
    99.downto(1) { i ->
        def s = i != 1 ? "s" : ""
        def sNext = (i - 1) != 1 ? "s" : ""
        def nextCount = (i - 1) > 0 ? (i - 1) : "no more"
        println "${i} bottle${s} of beer on the wall, ${i} bottle${s} of beer."
        println "Take one down, pass it around, ${nextCount} bottle${sNext} of beer on the wall.\n"
    }
}

// 5. Bubble sort
def bubbleSort(arr) {
    def n = arr.size()
    for (i in 0..<n) {
        for (j in 0..<n - i - 1) {
            if (arr[j] > arr[j + 1]) {
                def temp = arr[j]
                arr[j] = arr[j + 1]
                arr[j + 1] = temp
            }
        }
    }
    arr
}

// 6. FizzBuzz
def fizzbuzz() {
    (1..100).each { i ->
        if (i % 15 == 0) println "FizzBuzz"
        else if (i % 3 == 0) println "Fizz"
        else if (i % 5 == 0) println "Buzz"
        else println i
    }
}

// 7. Empty program
// (Empty)

// 8. A+B
def aPlusB(inputStr) {
    inputStr.split(/\s+/).findAll { it }.collect { it.toInteger() }.sum()
}

// 9. 100 doors
def hundredDoors() {
    def doors = new boolean[101]
    (1..100).each { i ->
        (i..100).step(i) { j ->
            doors[j] = !doors[j]
        }
    }
    (1..100).findAll { doors[it] }
}

// 10. Quine
def quine() {
    def s = 'def quine() { def s = %c%s%c; printf(s, 39, s, 39) }; quine()'
    printf(s, 39, s, 39)
}

// ==========================================
// PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
// ==========================================

// 11. Launch rocket
def launchRocket() {
    def accel = 9.8
    def velocity = 0.0
    10.downto(0) { t ->
        println "T-minus ${t}..."
        Thread.sleep(100)
    }
    println "Liftoff!"
    (1..3).each { t ->
        velocity += accel
        printf "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2%n", t, velocity, accel
    }
}

// 12. Experimental Verification of the NKT Law
def nktLawVerify(t, tEnv, tInit, k) {
    tEnv + (tInit - tEnv) * Math.exp(-k * t)
}

// 13. Universal Lambda Machine
def universalLambda() {
    def zero = { f -> { x -> x } }
    def succ = { n -> { f -> { x -> f(n(f)(x)) } } }
    def toInt = { n -> n({ x -> x + 1 })(0) }
    toInt(succ(succ(zero)))
}

// 14. Nautical bell
def nauticalBell(timeStr) {
    def (h, m) = timeStr.split(':').collect { it.toInteger() }
    def halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0)
    (halfHours == 0 && m < 30) ? 8 : halfHours
}

// 15. Earliest difference between primes
def primeDiff(targetDiff) {
    def isPrime = { n ->
        if (n < 2) return false
        for (i in 2..Math.sqrt(n)) if (n % i == 0) return false
        true
    }
    def prevPrime = 2
    def current = 3
    while (true) {
        if (isPrime(current)) {
            if (current - prevPrime == targetDiff) return [prevPrime, current]
            prevPrime = current
        }
        current += 2
    }
}

// 16. Canny edge detector (Mock gradient)
def cannyConcept(pixelGrid) {
    def rows = pixelGrid.size()
    def cols = pixelGrid[0].size()
    def edges = Array.newInstance(double.class, rows, cols)
    for (y in 1..<rows - 1) {
        for (x in 1..<cols - 1) {
            def gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1]
            def gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x]
            edges[y][x] = Math.sqrt(gradX**2 + gradY**2)
        }
    }
    edges
}

// 17. Death Star
def drawDeathStar(r = 10) {
    (-r..r).each { y ->
        def line = ""
        ((-(2 * r))..(2 * r)).each { x ->
            if ((x / 2.0)**2 + y**2 <= r**2) {
                if (((x / 2.0) - r / 2.0)**2 + (y - r / 2.0)**2 <= (r / 3.0)**2) line += " "
                else line += "#"
            } else line += " "
        }
        println line
    }
}

// 18. Chat server stub
def chatServerStub() {
    def host = '127.0.0.1'
    def port = 65432
    // Minimal configuration representation
    "Server configured for ${host}:${port}"
}

// 19. Faulhaber's triangle
def faulhaberTriangle(n) {
    def nCr = { nVal, rVal ->
        if (rVal == 0 || rVal == nVal) return 1G
        if (rVal > nVal / 2) rVal = nVal - rVal
        def res = 1G
        for (i in 1..rVal) res = res * (nVal - i + 1) / i
        res
    }
    
    def bernoulli = { m ->
        def B = new BigFraction[m + 1]
        for (i in 0..m) {
            B[i] = new BigFraction(1, i + 1)
            for (j in i.downto(1)) {
                B[j - 1] = BigFraction.multiply(j, BigFraction.subtract(B[j - 1], B[j]))
            }
        }
        B[0]
    }
    
    (0..<n).collect { p ->
        (0..p).collect { j ->
            def val = new BigFraction(1, p + 1) * nCr(p + 1, j) * bernoulli(j)
            val
        }
    }
}

// Helper for Faulhaber's
class BigFraction {
    BigInteger n, d
    BigFraction(n, d) { 
        def common = n.gcd(d)
        this.n = n/common; this.d = d/common 
    }
    static subtract(a, b) { new BigFraction(a.n * b.d - b.n * a.d, a.d * b.d) }
    static multiply(scalar, a) { new BigFraction(a.n * scalar, a.d) }
    String toString() { d == 1 ? "$n" : "$n/$d" }
}

// 20. Execute a Markov algorithm
def markovAlgorithm(rules, text) {
    while (true) {
        def applied = false
        for (rule in rules) {
            def (pattern, replacement, terminal) = rule
            if (text.contains(pattern)) {
                text = text.replaceFirst(java.util.regex.Pattern.quote(pattern), replacement)
                if (terminal) return text
                applied = true
                break
            }
        }
        if (!applied) break
    }
    text
}