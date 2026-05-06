package main

import (
	"fmt"
	"math"
	"net"
	"strings"
	"time"
)

// 1. Hello world/Text
func helloWorld() {
	fmt.Println("Hello world!")
}

// 2. Fibonacci sequence
func fib(n int) int {
	a, b := 0, 1
	for i := 0; i < n; i++ {
		a, b = b, a+b
	}
	return a
}

// 3. Factorial
func factorial(n uint64) uint64 {
	if n == 0 {
		return 1
	}
	res := uint64(1)
	for i := uint64(1); i <= n; i++ {
		res *= i
	}
	return res
}

// 4. 99 bottles of beer
func bottlesOfBeer() {
	for i := 99; i > 0; i-- {
		s := "s"
		if i == 1 {
			s = ""
		}
		sNext := "s"
		nextCountStr := fmt.Sprintf("%d", i-1)
		if i-1 == 1 {
			sNext = ""
		} else if i-1 == 0 {
			nextCountStr = "no more"
		}
		fmt.Printf("%d bottle%s of beer on the wall, %d bottle%s of beer.\n", i, s, i, s)
		fmt.Printf("Take one down, pass it around, %s bottle%s of beer on the wall.\n\n", nextCountStr, sNext)
	}
}

// 5. Bubble sort
func bubbleSort(arr []int) []int {
	n := len(arr)
	for i := 0; i < n; i++ {
		for j := 0; j < n-i-1; j++ {
			if arr[j] > arr[j+1] {
				arr[j], arr[j+1] = arr[j+1], arr[j]
			}
		}
	}
	return arr
}

// 6. FizzBuzz
func fizzbuzz() {
	for i := 1; i <= 101; i++ {
		if i%15 == 0 {
			fmt.Println("FizzBuzz")
		} else if i%3 == 0 {
			fmt.Println("Fizz")
		} else if i%5 == 0 {
			fmt.Println("Buzz")
		} else {
			fmt.Println(i)
		}
	}
}

// 7. Empty program
// func main() {}

// 8. A+B
func aPlusB(inputStr string) int {
	var a, b int
	fmt.Sscanf(inputStr, "%d %d", &a, &b)
	return a + b
}

// 9. 100 doors
func hundredDoors() []int {
	doors := make([]bool, 101)
	for i := 1; i <= 100; i++ {
		for j := i; j <= 100; j += i {
			doors[j] = !doors[j]
		}
	}
	var openDoors []int
	for i, isOpen := range doors {
		if isOpen {
			openDoors = append(openDoors, i)
		}
	}
	return openDoors
}

// 10. Quine
func quine() {
	s := "package main; import \"fmt\"; func main() { s := %q; fmt.Printf(s, s) }"
	fmt.Printf(s, s)
}

// 11. Launch rocket
func launchRocket() {
	accel := 9.8
	velocity := 0.0
	for t := 10; t >= 0; t-- {
		fmt.Printf("T-minus %d...\n", t)
		time.Sleep(100 * time.Millisecond)
	}
	fmt.Println("Liftoff!")
	for t := 1; t <= 3; t++ {
		velocity += accel
		fmt.Printf("Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n", t, velocity, accel)
	}
}

// 12. NKT Law (Newton's Law of Cooling)
func nktLawVerify(t, tEnv, tInit, k float64) float64 {
	return tEnv + (tInit-tEnv)*math.Exp(-k*t)
}

// 13. Universal Lambda Machine (Church Numerals)
type Lambda func(f Lambda) Lambda

func universalLambda() int {
	zero := func(f Lambda) Lambda { return func(x Lambda) Lambda { return x } }
	succ := func(n Lambda) Lambda {
		return func(f Lambda) Lambda {
			return func(x Lambda) Lambda {
				return f(n(f)(x).(Lambda)).(Lambda)
			}
		}
	}
	toInt := func(n Lambda) int {
		count := 0
		inc := func(x Lambda) Lambda { count++; return nil }
		n(inc)(nil)
		return count
	}
	return toInt(succ(succ(zero)))
}

// 14. Nautical bell
func nauticalBell(timeStr string) int {
	var h, m int
	fmt.Sscanf(timeStr, "%d:%d", &h, &m)
	halfHours := (h%4)*2 + (func() int {
		if m >= 30 {
			return 1
		}
		return 0
	}())
	if halfHours == 0 && m < 30 {
		return 8
	}
	return halfHours
}

// 15. Earliest difference between primes
func primeDiff(targetDiff int) (int, int) {
	isPrime := func(n int) bool {
		if n < 2 { return false }
		for i := 2; i*i <= n; i++ {
			if n%i == 0 { return false }
		}
		return true
	}
	prevPrime := 2
	for current := 3; ; current += 2 {
		if isPrime(current) {
			if current-prevPrime == targetDiff {
				return prevPrime, current
			}
			prevPrime = current
		}
	}
}

// 16. Canny edge detector concept
func cannyConcept(pixelGrid [][]float64) [][]float64 {
	h := len(pixelGrid)
	w := len(pixelGrid[0])
	edges := make([][]float64, h)
	for i := range edges {
		edges[i] = make([]float64, w)
	}
	for y := 1; y < h-1; y++ {
		for x := 1; x < w-1; x++ {
			gradX := pixelGrid[y][x+1] - pixelGrid[y][x-1]
			gradY := pixelGrid[y+1][x] - pixelGrid[y-1][x]
			edges[y][x] = math.Sqrt(gradX*gradX + gradY*gradY)
		}
	}
	return edges
}

// 17. Death Star
func drawDeathStar(r int) {
	for y := -r; y <= r; y++ {
		line := ""
		for x := -2 * r; x <= 2*r; x++ {
			xf := float64(x) / 2.0
			yf := float64(y)
			rf := float64(r)
			if xf*xf+yf*yf <= rf*rf {
				if math.Pow(xf-rf/2, 2)+math.Pow(yf-rf/2, 2) <= math.Pow(rf/3, 2) {
					line += " "
				} else {
					line += "#"
				}
			} else {
				line += " "
			}
		}
		fmt.Println(line)
	}
}

// 18. Chat server stub
func chatServerStub() string {
	host, port := "127.0.0.1", "65432"
	_ = net.JoinHostPort(host, port)
	return fmt.Sprintf("Server configured for %s:%s", host, port)
}

// 19. Faulhaber's triangle
// Note: Go requires math/big for Fraction equivalents; returning float64 for proximity
func faulhaberTriangle(n int) [][]float64 {
	bernoulli := func(m int) float64 {
		B := make([]float64, m+1)
		for i := 0; i <= m; i++ {
			B[i] = 1.0 / float64(i+1)
			for j := i; j > 0; j-- {
				B[j-1] = float64(j) * (B[j-1] - B[j])
			}
		}
		return B[0]
	}
	comb := func(n, k int) float64 {
		res := 1.0
		for i := 1; i <= k; i++ {
			res = res * float64(n-k+i) / float64(i)
		}
		return res
	}
	triangle := make([][]float64, n)
	for p := 0; p < n; p++ {
		triangle[p] = make([]float64, p+1)
		for j := 0; j <= p; j++ {
			triangle[p][j] = (1.0 / float64(p+1)) * comb(p+1, j) * bernoulli(j)
		}
	}
	return triangle
}

// 20. Execute a Markov algorithm
type Rule struct {
	Pattern     string
	Replacement string
	Terminal    bool
}

func markovAlgorithm(rules []Rule, text string) string {
	for {
		applied := false
		for _, rule := range rules {
			if strings.Contains(text, rule.Pattern) {
				text = strings.Replace(text, rule.Pattern, rule.Replacement, 1)
				if rule.Terminal {
					return text
				}
				applied = true
				break
			}
		}
		if !applied {
			break
		}
	}
	return text
}

func main() {
	helloWorld()
}