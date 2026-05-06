import Foundation

// 1. Hello world/Text
func helloWorld() {
    print("Hello world!")
}

// 2. Fibonacci sequence
func fib(_ n: Int) -> Int {
    var (a, b) = (0, 1)
    for _ in 0..<n {
        (a, b) = (b, a + b)
    }
    return a
}

// 3. Factorial
func factorial(_ n: Int) -> Int {
    return (1...max(1, n)).reduce(1, *)
}

// 4. 99 bottles of beer
func bottlesOfBeer() {
    for i in stride(from: 99, through: 1, by: -1) {
        let s = i != 1 ? "s" : ""
        let sNext = (i - 1) != 1 ? "s" : ""
        let nextCount = (i - 1) > 0 ? String(i - 1) : "no more"
        print("\(i) bottle\(s) of beer on the wall, \(i) bottle\(s) of beer.")
        print("Take one down, pass it around, \(nextCount) bottle\(sNext) of beer on the wall.\n")
    }
}

// 5. Bubble sort
func bubbleSort(_ arr: [Int]) -> [Int] {
    var result = arr
    let n = result.count
    for i in 0..<n {
        for j in 0..<(n - i - 1) {
            if result[j] > result[j + 1] {
                result.swapAt(j, j + 1)
            }
        }
    }
    return result
}

// 6. FizzBuzz
func fizzBuzz() {
    for i in 1...100 {
        if i % 15 == 0 { print("FizzBuzz") }
        else if i % 3 == 0 { print("Fizz") }
        else if i % 5 == 0 { print("Buzz") }
        else { print(i) }
    }
}

// 7. Empty program
// A Swift file can be empty or contain only whitespace.

// 8. A+B
func aPlusB(_ inputStr: String) -> Int {
    return inputStr.split(whereSeparator: { $0.isWhitespace })
        .compactMap { Int($0) }
        .reduce(0, +)
}

// 9. 100 doors
func hundredDoors() -> [Int] {
    var doors = Array(repeating: false, count: 101)
    for i in 1...100 {
        for j in stride(from: i, through: 100, by: i) {
            doors[j].toggle()
        }
    }
    return doors.enumerated().compactMap { $0.element ? $0.offset : nil }
}

// 10. Quine
func quine() {
    let s = "let s = %1$c%2$s%1$c; print(String(format: s, 34, s))"
    print(String(format: s, 34, s))
}

// 11. Launch rocket with countdown and acceleration
func launchRocket() {
    let accel = 9.8
    var velocity = 0.0
    for t in stride(from: 10, through: 0, by: -1) {
        print("T-minus \(t)...")
        Thread.sleep(forTimeInterval: 0.1)
    }
    print("Liftoff!")
    for t in 1...3 {
        velocity += accel
        print(String(format: "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2", t, velocity, accel))
    }
}

// 12. Experimental Verification of the NKT Law
func nktLawVerify(t: Double, tEnv: Double, tInit: Double, k: Double) -> Double {
    return tEnv + (tInit - tEnv) * exp(-k * t)
}

// 13. Universal Lambda Machine
func universalLambda() -> Int {
    typealias Church<T> = (@escaping (T) -> T) -> (T) -> T
    let zero: Church<Int> = { f in { x in x } }
    let succ: ( @escaping Church<Int>) -> Church<Int> = { n in { f in { x in f(n(f)(x)) } } }
    let toInt: (Church<Int>) -> Int = { n in n({ $0 + 1 })(0) }
    return toInt(succ(succ(zero)))
}

// 14. Nautical bell
func nauticalBell(_ timeStr: String) -> Int {
    let components = timeStr.split(separator: ":").compactMap { Int($0) }
    let h = components[0], m = components[1]
    let halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0)
    return (halfHours == 0 && m < 30) ? 8 : halfHours
}

// 15. Earliest difference between primes
func primeDiff(_ targetDiff: Int) -> (Int, Int) {
    func isPrime(_ n: Int) -> Bool {
        if n < 2 { return false }
        if n == 2 { return true }
        for i in 2...Int(sqrt(Double(n))) {
            if n % i == 0 { return false }
        }
        return true
    }
    var prevPrime = 2
    var current = 3
    while true {
        if isPrime(current) {
            if current - prevPrime == targetDiff { return (prevPrime, current) }
            prevPrime = current
        }
        current += 2
    }
}

// 16. Canny edge detector (Simplified concept)
func cannyConcept(_ pixelGrid: [[Double]]) -> [[Double]] {
    let rows = pixelGrid.count
    let cols = pixelGrid[0].count
    var edges = Array(repeating: Array(repeating: 0.0, count: cols), count: rows)
    for y in 1..<(rows - 1) {
        for x in 1..<(cols - 1) {
            let gradX = pixelGrid[y][x+1] - pixelGrid[y][x-1]
            let gradY = pixelGrid[y+1][x] - pixelGrid[y-1][x]
            edges[y][x] = sqrt(pow(gradX, 2) + pow(gradY, 2))
        }
    }
    return edges
}

// 17. Death Star
func drawDeathStar(r: Int = 10) {
    for y in -r...r {
        var line = ""
        for x in Int(-2.0 * Double(r))...Int(2.0 * Double(r)) {
            let dx = Double(x) / 2.0
            let dy = Double(y)
            if (dx*dx + dy*dy) <= Double(r*r) {
                let dishX = dx - Double(r)/2.0
                let dishY = dy - Double(r)/2.0
                if (dishX*dishX + dishY*dishY) <= Double((r*r)/9) { line += " " }
                else { line += "#" }
            } else { line += " " }
        }
        print(line)
    }
}

// 18. Chat server (Stub logic)
func chatServerStub() -> String {
    let host = "127.0.0.1", port = 65432
    // Swift uses Network.framework for modern sockets, returning a stub description:
    return "Server configured for \(host):\(port)"
}

// 19. Faulhaber's triangle
func faulhaberTriangle(_ n: Int) -> [[Double]] {
    func combinations(_ n: Int, _ k: Int) -> Double {
        if k < 0 || k > n { return 0 }
        if k == 0 || k == n { return 1 }
        var res = 1.0
        for i in 1...min(k, n - k) {
            res = res * Double(n - i + 1) / Double(i)
        }
        return res
    }
    func bernoulli(_ m: Int) -> Double {
        var b = Array(repeating: 0.0, count: m + 1)
        for i in 0...m {
            b[i] = 1.0 / Double(i + 1)
            for j in stride(from: i, through: 1, by: -1) {
                b[j-1] = Double(j) * (b[j-1] - b[j])
            }
        }
        return b[0]
    }
    var triangle: [[Double]] = []
    for p in 0..<n {
        var row: [Double] = []
        for j in 0...p {
            let val = (1.0 / Double(p + 1)) * combinations(p + 1, j) * bernoulli(j)
            row.append(val)
        }
        triangle.append(row)
    }
    return triangle
}

// 20. Execute a Markov algorithm
func markovAlgorithm(rules: [(pattern: String, replacement: String, terminal: Bool)], text: String) -> String {
    var result = text
    while true {
        var applied = false
        for rule in rules {
            if let range = result.range(of: rule.pattern) {
                result.replaceSubrange(range, with: rule.replacement)
                if rule.terminal { return result }
                applied = true
                break
            }
        }
        if !applied { break }
    }
    return result
}