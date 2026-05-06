import * as net from 'net';

// ==========================================
// PART 1: TOP 10 MOST IMPLEMENTED TASKS
// ==========================================

// 1. Hello world/Text
function helloWorld(): void {
    console.log("Hello world!");
}

// 2. Fibonacci sequence (Iterative for efficiency)
function fib(n: number): number {
    let [a, b] = [0, 1];
    for (let i = 0; i < n; i++) {
        [a, b] = [b, a + b];
    }
    return a;
}

// 3. Factorial
function factorial(n: number): number {
    if (n < 0) return 0;
    if (n <= 1) return 1;
    let res = 1;
    for (let i = 2; i <= n; i++) res *= i;
    return res;
}

// 4. 99 bottles of beer
function bottlesOfBeer(): void {
    for (let i = 99; i > 0; i--) {
        const s = i !== 1 ? "s" : "";
        const nextCount = i - 1 > 0 ? i - 1 : "no more";
        const sNext = nextCount !== 1 ? "s" : "";
        console.log(`${i} bottle${s} of beer on the wall, ${i} bottle${s} of beer.`);
        console.log(`Take one down, pass it around, ${nextCount} bottle${sNext} of beer on the wall.\n`);
    }
}

// 5. Bubble sort
function bubbleSort(arr: number[]): number[] {
    const n = arr.length;
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
function fizzBuzz(): void {
    for (let i = 1; i <= 101; i++) {
        if (i % 15 === 0) console.log("FizzBuzz");
        else if (i % 3 === 0) console.log("Fizz");
        else if (i % 5 === 0) console.log("Buzz");
        else console.log(i);
    }
}

// 7. Empty program
// A file with no executable statements or a single comment is valid.

// 8. A+B
function aPlusB(inputStr: string): number {
    return inputStr.split(/\s+/).reduce((acc, curr) => acc + parseInt(curr || "0"), 0);
}

// 9. 100 doors
function hundredDoors(): number[] {
    const doors = new Array(101).fill(false);
    for (let i = 1; i <= 100; i++) {
        for (let j = i; j <= 100; j += i) {
            doors[j] = !doors[j];
        }
    }
    return doors.map((isOpen, i) => isOpen ? i : -1).filter(i => i !== -1);
}

// 10. Quine
function quine(): void {
    const s = 'const s = %j; console.log(s, s);';
    console.log('const s = %j; console.log(s.replace("%j", JSON.stringify(s)));', s);
    // Alternatively, following the Python logic:
    const q = "const s = %j; console.log(s.replace('%j', JSON.stringify(s)))";
    console.log(q.replace('%j', JSON.stringify(q)));
}

// ==========================================
// PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
// ==========================================

// 11. Launch rocket with countdown and acceleration
async function launchRocket(): Promise<void> {
    const accel = 9.8;
    let velocity = 0;
    const sleep = (ms: number) => new Promise(res => setTimeout(res, ms));

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
function nktLawVerify(t: number, tEnv: number, tInit: number, k: number): number {
    return tEnv + (tInit - tEnv) * Math.exp(-k * t);
}

// 13. Universal Lambda Machine
function universalLambda(): number {
    const zero = (f: Function) => (x: any) => x;
    const succ = (n: Function) => (f: Function) => (x: any) => f(n(f)(x));
    const toInt = (n: Function) => n((x: number) => x + 1)(0);
    return toInt(succ(succ(zero)));
}

// 14. Nautical bell
function nauticalBell(timeStr: string): number {
    const [h, m] = timeStr.split(':').map(Number);
    const halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
    return (halfHours === 0 && m < 30) ? 8 : halfHours;
}

// 15. Earliest difference between primes
function primeDiff(targetDiff: number): [number, number] {
    const isPrime = (n: number): boolean => {
        if (n < 2) return false;
        for (let i = 2; i <= Math.sqrt(n); i++) {
            if (n % i === 0) return false;
        }
        return true;
    };
    let prevPrime = 2;
    let current = 3;
    while (true) {
        if (isPrime(current)) {
            if (current - prevPrime === targetDiff) return [prevPrime, current];
            prevPrime = current;
        }
        current += 2;
    }
}

// 16. Canny edge detector (Simplified concept)
function cannyConcept(pixelGrid: number[][]): number[][] {
    const height = pixelGrid.length;
    const width = pixelGrid[0].length;
    const edges = Array.from({ length: height }, () => Array(width).fill(0));
    for (let y = 1; y < height - 1; y++) {
        for (let x = 1; x < width - 1; x++) {
            const gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1];
            const gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x];
            edges[y][x] = Math.sqrt(gradX ** 2 + gradY ** 2);
        }
    }
    return edges;
}

// 17. Death Star
function drawDeathStar(r: number = 10): void {
    for (let y = -r; y <= r; y++) {
        let line = "";
        for (let x = Math.floor(-2.0 * r); x <= Math.floor(2.0 * r); x++) {
            if (Math.pow(x / 2, 2) + Math.pow(y, 2) <= Math.pow(r, 2)) {
                if (Math.pow(x / 2 - r / 2, 2) + Math.pow(y - r / 2, 2) <= Math.pow(r / 3, 2)) line += " ";
                else line += "#";
            } else line += " ";
        }
        console.log(line);
    }
}

// 18. Chat server (Core Socket Listener Pattern)
function chatServerStub(): string {
    const host = '127.0.0.1';
    const port = 65432;
    const server = net.createServer();
    // server.listen(port, host); // Logic stubbed as per Python example
    return `Server configured for ${host}:${port}`;
}

// 19. Faulhaber's triangle (Requires BigInt or Fraction library for precision)
// Minimal version using numbers for logic demonstration
function faulhaberTriangle(n: number): number[][] {
    const combinations = (n: number, k: number): number => {
        if (k === 0 || k === n) return 1;
        if (k > n) return 0;
        let res = 1;
        for (let i = 1; i <= k; i++) res = res * (n - i + 1) / i;
        return res;
    };

    const getBernoulli = (m: number): number => {
        let B = new Array(m + 1).fill(0);
        for (let i = 0; i <= m; i++) {
            B[i] = 1 / (i + 1);
            for (let j = i; j >= 1; j--) B[j - 1] = j * (B[j - 1] - B[j]);
        }
        return B[0];
    };

    const triangle: number[][] = [];
    for (let p = 0; p < n; p++) {
        const row: number[] = [];
        for (let j = 0; j <= p; j++) {
            const val = (1 / (p + 1)) * combinations(p + 1, j) * getBernoulli(j);
            row.push(val);
        }
        triangle.push(row);
    }
    return triangle;
}

// 20. Execute a Markov algorithm
function markovAlgorithm(rules: [string, string, boolean][], text: string): string {
    while (true) {
        let applied = false;
        for (const [pattern, replacement, terminal] of rules) {
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