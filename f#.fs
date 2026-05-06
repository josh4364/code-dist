open System
open System.Net
open System.Net.Sockets
open System.Threading

// 1. Hello world/Text
let helloWorld () = printfn "Hello world!"

// 2. Fibonacci sequence
let fib n =
    let mutable a, b = 0, 1
    for _ in 1 .. n do
        let temp = a
        a <- b
        b <- temp + b
    a

// 3. Factorial
let rec factorial n =
    if n <= 1 then 1I else bigint n * factorial (n - 1)

// 4. 99 bottles of beer
let bottlesOfBeer () =
    for i in 99 .. -1 .. 1 do
        let s = if i <> 1 then "s" else ""
        let sNext = if i - 1 <> 1 then "s" else ""
        let nextCount = if i - 1 > 0 then (i - 1).ToString() else "no more"
        printfn "%d bottle%s of beer on the wall, %d bottle%s of beer." i s i s
        printfn "Take one down, pass it around, %s bottle%s of beer on the wall.\n" nextCount sNext

// 5. Bubble sort
let bubbleSort (arr: 'a array) =
    let n = arr.Length
    for i in 0 .. n - 1 do
        for j in 0 .. n - i - 2 do
            if arr.[j] > arr.[j + 1] then
                let temp = arr.[j]
                arr.[j] <- arr.[j + 1]
                arr.[j + 1] <- temp
    arr

// 6. FizzBuzz
let fizzBuzz () =
    for i in 1 .. 100 do
        match i % 3, i % 5 with
        | 0, 0 -> printfn "FizzBuzz"
        | 0, _ -> printfn "Fizz"
        | _, 0 -> printfn "Buzz"
        | _    -> printfn "%d" i

// 7. Empty program
// ()

// 8. A+B
let aPlusB (inputStr: string) =
    inputStr.Split([|' '; '\t'; '\n'; '\r'|], StringSplitOptions.RemoveEmptyEntries)
    |> Array.map int
    |> Array.sum

// 9. 100 doors
let hundredDoors () =
    let doors = Array.create 101 false
    for i in 1 .. 100 do
        for j in i .. i .. 100 do
            doors.[j] <- not doors.[j]
    [ for i in 1 .. 100 do if doors.[i] then yield i ]

// 10. Quine
let quine () =
    let s = "let s = %A in printfn %s s s"
    printfn "let s = %A in printfn %s s s" s s

// 11. Launch rocket
let launchRocket () =
    let accel = 9.8
    let mutable velocity = 0.0
    for t in 10 .. -1 .. 0 do
        printfn "T-minus %d..." t
        Thread.Sleep(100)
    printfn "Liftoff!"
    for t in 1 .. 3 do
        velocity <- velocity + accel
        printfn "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2" t velocity accel

// 12. Experimental Verification of the NKT Law
let nktLawVerify t tEnv tInit k =
    tEnv + (tInit - tEnv) * Math.Exp(-k * t)

// 13. Universal Lambda Machine
let universalLambda () =
    let zero f x = x
    let succ n f x = f (n f x)
    let toInt n = n (fun x -> x + 1) 0
    toInt (succ (succ zero))

// 14. Nautical bell
let nauticalBell (timeStr: string) =
    let parts = timeStr.Split(':') |> Array.map int
    let h, m = parts.[0], parts.[1]
    let halfHours = (h % 4) * 2 + (if m >= 30 then 1 else 0)
    if halfHours = 0 && m < 30 then 8 else halfHours

// 15. Earliest difference between primes
let primeDiff targetDiff =
    let isPrime n =
        if n < 2 then false
        else 
            let limit = int (Math.Sqrt(float n))
            {2 .. limit} |> Seq.forall (fun i -> n % i <> 0)
    
    let rec find prev current =
        if isPrime current then
            if current - prev = targetDiff then (prev, current)
            else find current (current + 2)
        else find prev (current + 2)
    find 2 3

// 16. Canny edge detector (Simplified concept)
let cannyConcept (pixelGrid: float[,]) =
    let rows = pixelGrid.GetLength(0)
    let cols = pixelGrid.GetLength(1)
    let edges = Array2D.create rows cols 0.0
    for y in 1 .. rows - 2 do
        for x in 1 .. cols - 2 do
            let gradX = pixelGrid.[y, x + 1] - pixelGrid.[y, x - 1]
            let gradY = pixelGrid.[y + 1, x] - pixelGrid.[y - 1, x]
            edges.[y, x] <- Math.Sqrt(gradX ** 2.0 + gradY ** 2.0)
    edges

// 17. Death Star
let drawDeathStar r =
    for y in -r .. r do
        let mutable line = ""
        for x in int (-2.0 * float r) .. int (2.0 * float r) do
            let xf, yf, rf = float x / 2.0, float y, float r
            if xf**2.0 + yf**2.0 <= rf**2.0 then
                if (xf - rf/2.0)**2.0 + (yf - rf/2.0)**2.0 <= (rf/3.0)**2.0 then line <- line + " "
                else line <- line + "#"
            else line <- line + " "
        printfn "%s" line

// 18. Chat server stub
let chatServerStub () =
    let host, port = "127.0.0.1", 65432
    let endpoint = IPEndPoint(IPAddress.Parse(host), port)
    sprintf "Server configured for %s:%d" host port

// 19. Faulhaber's triangle
type Fraction = { Num: bigint; Den: bigint }
let rec gcd a b = if b = 0I then a else gcd b (a % b)
let makeFrac n d = let common = gcd (abs n) (abs d) in { Num = n / common; Den = d / common }
let addFrac a b = makeFrac (a.Num * b.Den + b.Num * a.Den) (a.Den * b.Den)
let subFrac a b = makeFrac (a.Num * b.Den - b.Num * a.Den) (a.Den * b.Den)
let mulFrac a b = makeFrac (a.Num * b.Num) (a.Den * b.Den)

let bernoulli m =
    let B = Array.init (m + 1) (fun i -> makeFrac 1I (bigint i + 1I))
    for i in 0 .. m do
        for j in i .. -1 .. 1 do
            B.[j-1] <- mulFrac (makeFrac (bigint j) 1I) (subFrac B.[j-1] B.[j])
    B.[0]

let combinations n k =
    let rec fact n = if n <= 1I then 1I else n * fact (n - 1I)
    fact (bigint n) / (fact (bigint k) * fact (bigint (n - k)))

let faulhaberTriangle n =
    [ for p in 0 .. n - 1 ->
        [ for j in 0 .. p ->
            let b = bernoulli j
            let comb = combinations (p + 1) j
            mulFrac (makeFrac 1I (bigint p + 1I)) (mulFrac (makeFrac comb 1I) b)
        ]
    ]

// 20. Execute a Markov algorithm
let markovAlgorithm (rules: (string * string * bool) list) (inputText: string) =
    let mutable text = inputText
    let mutable running = true
    while running do
        match rules |> List.tryFind (fun (p, _, _) -> text.Contains(p)) with
        | Some (pattern, replacement, terminal) ->
            let index = text.IndexOf(pattern)
            text <- text.Remove(index, pattern.Length).Insert(index, replacement)
            if terminal then running <- false
        | None -> running <- false
    text