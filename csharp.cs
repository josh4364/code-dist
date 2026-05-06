using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Numerics;
using System.Threading;

public class RosettaCodeTasks
{
    // 1. Hello world/Text
    public static void HelloWorld() => Console.WriteLine("Hello world!");

    // 2. Fibonacci sequence
    public static long Fibonacci(int n)
    {
        long a = 0, b = 1;
        for (int i = 0; i < n; i++)
        {
            long temp = a;
            a = b;
            b = temp + b;
        }
        return a;
    }

    // 3. Factorial
    public static BigInteger Factorial(int n)
    {
        BigInteger result = 1;
        for (int i = 2; i <= n; i++) result *= i;
        return result;
    }

    // 4. 99 bottles of beer
    public static void BottlesOfBeer()
    {
        for (int i = 99; i > 0; i--)
        {
            string s = i != 1 ? "s" : "";
            string sNext = (i - 1) != 1 ? "s" : "";
            string nextCount = (i - 1) > 0 ? (i - 1).ToString() : "no more";
            Console.WriteLine($"{i} bottle{s} of beer on the wall, {i} bottle{s} of beer.");
            Console.WriteLine($"Take one down, pass it around, {nextCount} bottle{sNext} of beer on the wall.\n");
        }
    }

    // 5. Bubble sort
    public static int[] BubbleSort(int[] arr)
    {
        int n = arr.Length;
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n - i - 1; j++)
                if (arr[j] > arr[j + 1])
                    (arr[j], arr[j + 1]) = (arr[j + 1], arr[j]);
        return arr;
    }

    // 6. FizzBuzz
    public static void FizzBuzz()
    {
        for (int i = 1; i <= 100; i++)
        {
            if (i % 15 == 0) Console.WriteLine("FizzBuzz");
            else if (i % 3 == 0) Console.WriteLine("Fizz");
            else if (i % 5 == 0) Console.WriteLine("Buzz");
            else Console.WriteLine(i);
        }
    }

    // 7. Empty program
    // static void Main() {} 

    // 8. A+B
    public static int APlusB(string inputStr) => 
        inputStr.Split(new[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(int.Parse).Sum();

    // 9. 100 doors
    public static List<int> HundredDoors()
    {
        bool[] doors = new bool[101];
        for (int i = 1; i <= 100; i++)
            for (int j = i; j <= 100; j += i)
                doors[j] = !doors[j];
        
        return Enumerable.Range(1, 100).Where(i => doors[i]).ToList();
    }

    // 10. Quine
    public static void Quine()
    {
        var s = "using System; class Program {{ static void Main() {{ var s = {0}{1}{0}; Console.Write(s, (char)34, s); }} }}";
        Console.Write(s, (char)34, s);
    }

    // 11. Launch rocket
    public static void LaunchRocket()
    {
        double accel = 9.8, velocity = 0;
        for (int t = 10; t >= 0; t--)
        {
            Console.WriteLine($"T-minus {t}...");
            Thread.Sleep(100);
        }
        Console.WriteLine("Liftoff!");
        for (int t = 1; t <= 3; t++)
        {
            velocity += accel;
            Console.WriteLine($"Time: {t}s, Velocity: {velocity:F1}m/s, Accel: {accel}m/s^2");
        }
    }

    // 12. Experimental Verification of the NKT Law
    public static double NktLawVerify(double t, double tEnv, double tInit, double k) =>
        tEnv + (tInit - tEnv) * Math.Exp(-k * t);

    // 13. Universal Lambda Machine
    public static int UniversalLambda()
    {
        Func<Func<Func<int, int>, Func<int, int>>, Func<Func<int, int>, Func<int, int>>> succ = 
            n => f => x => f(n(f)(x));
        Func<Func<int, int>, Func<int, int>> zero = f => x => x;
        Func<Func<Func<int, int>, Func<int, int>>, int> toInt = n => n(x => x + 1)(0);
        return toInt(succ(succ(zero)));
    }

    // 14. Nautical bell
    public static int NauticalBell(string timeStr)
    {
        var parts = timeStr.Split(':');
        int h = int.Parse(parts[0]), m = int.Parse(parts[1]);
        int halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
        return (halfHours == 0 && m < 30) ? 8 : halfHours;
    }

    // 15. Earliest difference between primes
    public static (int, int) PrimeDiff(int targetDiff)
    {
        bool IsPrime(int n) {
            if (n < 2) return false;
            for (int i = 2; i <= Math.Sqrt(n); i++) if (n % i == 0) return false;
            return true;
        }
        int prevPrime = 2, current = 3;
        while (true) {
            if (IsPrime(current)) {
                if (current - prevPrime == targetDiff) return (prevPrime, current);
                prevPrime = current;
            }
            current += 2;
        }
    }

    // 16. Canny edge detector (Concept)
    public static double[][] CannyConcept(double[][] pixelGrid)
    {
        int rows = pixelGrid.Length, cols = pixelGrid[0].Length;
        double[][] edges = Enumerable.Range(0, rows).Select(_ => new double[cols]).ToArray();
        for (int y = 1; y < rows - 1; y++)
            for (int x = 1; x < cols - 1; x++) {
                double gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1];
                double gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x];
                edges[y][x] = Math.Sqrt(gradX * gradX + gradY * gradY);
            }
        return edges;
    }

    // 17. Death Star
    public static void DrawDeathStar(int r = 10)
    {
        for (int y = -r; y <= r; y++) {
            string line = "";
            for (int x = (int)(-2.0 * r); x <= (int)(2.0 * r); x++) {
                if (Math.Pow(x / 2.0, 2) + Math.Pow(y, 2) <= r * r) {
                    if (Math.Pow((x / 2.0) - r / 2.0, 2) + Math.Pow(y - r / 2.0, 2) <= Math.Pow(r / 3.0, 2)) line += " ";
                    else line += "#";
                } else line += " ";
            }
            Console.WriteLine(line);
        }
    }

    // 18. Chat server stub
    public static string ChatServerStub()
    {
        string host = "127.0.0.1"; int port = 65432;
        using var s = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        return $"Server configured for {host}:{port}";
    }

    // 19. Faulhaber's triangle (Using double for simplicity instead of Fraction class)
    public static List<List<double>> FaulhaberTriangle(int n)
    {
        double Bernoulli(int m) {
            double[] B = new double[m + 1];
            for (int i = 0; i <= m; i++) {
                B[i] = 1.0 / (i + 1);
                for (int j = i; j >= 1; j--) B[j - 1] = j * (B[j - 1] - B[j]);
            }
            return B[0];
        }
        long Comb(int n_c, int k_c) {
            long res = 1;
            for (int i = 1; i <= k_c; i++) res = res * (n_c - i + 1) / i;
            return res;
        }
        var triangle = new List<List<double>>();
        for (int p = 0; p < n; p++) {
            var row = new List<double>();
            for (int j = 0; j <= p; j++) row.Add((1.0 / (p + 1)) * Comb(p + 1, j) * Bernoulli(j));
            triangle.Add(row);
        }
        return triangle;
    }

    // 20. Execute a Markov algorithm
    public static string MarkovAlgorithm(List<(string Pattern, string Replace, bool Terminal)> rules, string text)
    {
        while (true) {
            bool applied = false;
            foreach (var (pattern, replace, terminal) in rules) {
                int index = text.IndexOf(pattern);
                if (index != -1) {
                    text = text.Substring(0, index) + replace + text.Substring(index + pattern.Length);
                    if (terminal) return text;
                    applied = true;
                    break;
                }
            }
            if (!applied) break;
        }
        return text;
    }
}