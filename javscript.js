const net = require('net');

// ==========================================
// PART 1: TOP 10 MOST IMPLEMENTED TASKS
// ==========================================

// 1. Hello world/Text
function helloWorld() {
    console.log("Hello world!");
}

// 2. Fibonacci sequence (Iterative for efficiency)
function fib(n) {
    let a = 0, b = 1;
    for (let i = 0; i < n; i++) {
        [a, b] = [b, a + b];
    }
    return a;
}

// 3. Factorial
function factorial(n) {
    if (n === 0 || n === 1) return 1;
    let res = 1;
    for (let i = 2; i <= n; i++) res *= i;
    return res;
}

// 4. 99 bottles of beer
function bottlesOfBeer() {
    for (let i = 99; i > 0; i--) {
        let s = i !== 1 ? "s" : "";
        let sNext = (i - 1) !== 1 ? "s" : "";
        let nextCount = (i - 1) > 0 ? (i - 1) : "no more";
        console.log(`${i} bottle${s} of beer on the wall, ${i} bottle${s} of beer.`);
        console.log(`Take one down, pass it around, ${nextCount} bottle${sNext} of beer on the wall.\n`);
    }
}

// 5. Bubble sort
function bubbleSort(arr) {
    let n = arr.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                [arr[j], arr[j + 1]] = [arr[j + 1], arr[j]];
            }
        }
    }
    return arr;
}

// 6. FizzBuzz
function fizzbuzz() {
    for (let i = 1; i <= 100; i++) {
        if (i % 15 === 0) console.log("FizzBuzz");
        else if (i % 3 === 0) console.log("Fizz");
        else if (i % 5 === 0) console.log("Buzz");
        else console.log(i);
    }
}

// 7. Empty program
// (Equivalent to Python's pass)

// 8. A+B
function aPlusB(inputStr) {
    return inputStr.trim().split(/\s+/).reduce((acc, val) => acc + parseInt(val), 0);
}

// 9. 100 doors
function hundredDoors() {
    let doors = new Array(101).fill(false);
    for (let i = 1; i <= 100; i++) {
        for (let j = i; j <= 100; j += i) {
            doors[j] = !doors[j];
        }
    }
    let result = [];
    doors.forEach((isOpen, i) => { if (isOpen) result.push(i); });
    return result;
}

// 10. Quine
function quine() {
    let s = 'let s = %j; console.log(s.replace("%j", JSON.stringify(s)))';
    console.log(s.replace('%j', JSON.stringify(s)));
}

// ==========================================
// PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
// ==========================================

// 11. Launch rocket with countdown and acceleration
async function launchRocket() {
    const sleep = ms => new Promise(r => setTimeout(r, ms));
    let accel = 9.8, velocity = 0;
    for (let t = 10; t >= 0; t--) {
        console.log(`T-minus ${t}...`);
        await sleep(100);
    }
    console.log("Liftoff!");
    for (let t = 1; t <= 3; t++) {
        velocity += accel;
        console.log(`Time: ${t}s, Velocity: ${velocity.toFixed(1)}m/s, Accel: ${accel}m/s^2`);
    }
}

// 12. Experimental Verification of the NKT Law
function nktLawVerify(t, tEnv, tInit, k) {
    return tEnv + (tInit - tEnv) * Math.exp(-k * t);
}

// 13. Universal Lambda Machine
function universalLambda() {
    const zero = f => x => x;
    const succ = n => f => x => f(n(f)(x));
    const toInt = n => n(x => x + 1)(0);
    return toInt(succ(succ(zero)));
}

// 14. Nautical bell
function nauticalBell(timeStr) {
    let [h, m] = timeStr.split(':').map(Number);
    let halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
    return (halfHours === 0 && m < 30) ? 8 : halfHours;
}

// 15. Earliest difference between primes
function primeDiff(targetDiff) {
    const isPrime = n => {
        if (n < 2) return false;
        for (let i = 2; i <= Math.sqrt(n); i++) {
            if (n % i === 0) return false;
        }
        return true;
    };
    let prevPrime = 2, current = 3;
    while (true) {
        if (isPrime(current)) {
            if (current - prevPrime === targetDiff) return [prevPrime, current];
            prevPrime = current;
        }
        current += 2;
    }
}

// 16. Canny edge detector (Simplified concept)
function cannyConcept(pixelGrid) {
    let edges = Array.from({ length: pixelGrid.length }, () => new Array(pixelGrid[0].length).fill(0));
    for (let y = 1; y < pixelGrid.length - 1; y++) {
        for (let x = 1; x < pixelGrid[0].length - 1; x++) {
            let gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1];
            let gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x];
            edges[y][x] = Math.sqrt(Math.pow(gradX, 2) + Math.pow(gradY, 2));
        }
    }
    return edges;
}

// 17. Death Star
function drawDeathStar(r = 10) {
    for (let y = -r; y <= r; y++) {
        let line = "";
        for (let x = Math.floor(-2.0 * r); x <= Math.floor(2.0 * r); x++) {
            if (Math.pow(x / 2, 2) + Math.pow(y, 2) <= Math.pow(r, 2)) {
                if (Math.pow((x / 2) - r / 2, 2) + Math.pow(y - r / 2, 2) <= Math.pow(r / 3, 2)) line += " ";
                else line += "#";
            } else line += " ";
        }
        console.log(line);
    }
}

// 18. Chat server (Core Socket Listener Pattern)
function chatServerStub() {
    const host = '127.0.0.1', port = 65432;
    const server = net.createServer();
    // server.listen(port, host);
    return `Server configured for ${host}:${port}`;
}

// 19. Faulhaber's triangle
function faulhaberTriangle(n) {
    const gcd = (a, b) => b ? gcd(b, a % b) : Math.abs(a);
    class Frac {
        constructor(n, d = 1) {
            let common = gcd(n, d);
            this.n = n / common; this.d = d / common;
        }
    }
    const comb = (n, k) => {
        let res = 1;
        if (k > n) return 0;
        if (k > n / 2) k = n - k;
        for (let i = 1; i <= k; i++) res = res * (n - i + 1) / i;
        return res;
    };
    const bernoulli = (m) => {
        let B = new Array(m + 1);
        for (let i = 0; i <= m; i++) {
            B[i] = new Frac(1, i + 1);
            for (let j = i; j >= 1; j--) {
                B[j - 1] = new Frac(j * (B[j - 1].n * B[j].d - B[j].n * B[j - 1].d), B[j - 1].d * B[j].d);
            }
        }
        return B[0];
    };
    let triangle = [];
    for (let p = 0; p < n; p++) {
        let row = [];
        for (let j = 0; j <= p; j++) {
            let b = bernoulli(j);
            let c = comb(p + 1, j);
            row.push(new Frac(c * b.n, (p + 1) * b.d));
        }
        triangle.push(row);
    }
    return triangle;
}

// 20. Execute a Markov algorithm
function markovAlgorithm(rules, text) {
    while (true) {
        let applied = false;
        for (let [pattern, replacement, terminal] of rules) {
            if (text.includes(pattern)) {
                text = text.replace(pattern, replacement);
                if (terminal) return text;
                applied = true;
                break;
            }
        }
        if (!applied) break;
    }
    return text;
}