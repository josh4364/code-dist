import java.util.*;
import java.math.*;
import java.net.*;
import java.io.*;
import java.util.function.Function;

public class RosettaTasks {

    // 1. Hello world/Text
    public static void helloWorld() {
        System.out.println("Hello world!");
    }

    // 2. Fibonacci sequence (Iterative)
    public static long fib(int n) {
        long a = 0, b = 1;
        for (int i = 0; i < n; i++) {
            long temp = a;
            a = b;
            b = temp + b;
        }
        return a;
    }

    // 3. Factorial
    public static BigInteger factorial(int n) {
        BigInteger res = BigInteger.ONE;
        for (int i = 2; i <= n; i++)
            res = res.multiply(BigInteger.valueOf(i));
        return res;
    }

    // 4. 99 bottles of beer
    public static void bottlesOfBeer() {
        for (int i = 99; i > 0; i--) {
            String s = (i != 1) ? "s" : "";
            String sNext = (i - 1 != 1) ? "s" : "";
            String nextCount = (i - 1 > 0) ? String.valueOf(i - 1) : "no more";
            System.out.printf("%d bottle%s of beer on the wall, %d bottle%s of beer.%n", i, s, i, s);
            System.out.printf("Take one down, pass it around, %s bottle%s of beer on the wall.%n%n", nextCount, sNext);
        }
    }

    // 5. Bubble sort
    public static int[] bubbleSort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
        return arr;
    }

    // 6. FizzBuzz
    public static void fizzBuzz() {
        for (int i = 1; i <= 100; i++) {
            if (i % 15 == 0) System.out.println("FizzBuzz");
            else if (i % 3 == 0) System.out.println("Fizz");
            else if (i % 5 == 0) System.out.println("Buzz");
            else System.out.println(i);
        }
    }

    // 7. Empty program
    public static void emptyProgram() {}

    // 8. A+B
    public static int aPlusB(String inputStr) {
        Scanner sc = new Scanner(inputStr);
        int sum = 0;
        while (sc.hasNextInt()) sum += sc.nextInt();
        return sum;
    }

    // 9. 100 doors
    public static List<Integer> hundredDoors() {
        boolean[] doors = new boolean[101];
        for (int i = 1; i <= 100; i++) {
            for (int j = i; j <= 100; j += i) {
                doors[j] = !doors[j];
            }
        }
        List<Integer> openDoors = new ArrayList<>();
        for (int i = 1; i <= 100; i++) if (doors[i]) openDoors.add(i);
        return openDoors;
    }

    // 10. Quine
    public static void quine() {
        char q = 34;
        String s = "public class RosettaTasks { public static void main(String[] args) { char q = 34; String s = %c%s%c; System.out.printf(s, q, s, q); } }";
        System.out.printf(s, q, s, q);
    }

    // 11. Launch rocket
    public static void launchRocket() throws InterruptedException {
        double accel = 9.8, velocity = 0;
        for (int t = 10; t >= 0; t--) {
            System.out.println("T-minus " + t + "...");
            Thread.sleep(100);
        }
        System.out.println("Liftoff!");
        for (int t = 1; t <= 3; t++) {
            velocity += accel;
            System.out.printf("Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2%n", t, velocity, accel);
        }
    }

    // 12. NKT Law (Newton's Law of Cooling)
    public static double nktLawVerify(double t, double tEnv, double tInit, double k) {
        return tEnv + (tInit - tEnv) * Math.exp(-k * t);
    }

    // 13. Universal Lambda Machine (Church Encoding)
    public static int universalLambda() {
        Function<Function<Integer, Integer>, Function<Integer, Integer>> zero = f -> x -> x;
        Function<Function<Function<Integer, Integer>, Function<Integer, Integer>>, 
                 Function<Function<Integer, Integer>, Function<Integer, Integer>>> succ = 
                 n -> f -> x -> f.apply(n.apply(f).apply(x));
        
        Function<Function<Integer, Integer>, Function<Integer, Integer>> two = succ.apply(succ.apply(zero));
        return two.apply(x -> x + 1).apply(0);
    }

    // 14. Nautical bell
    public static int nauticalBell(String timeStr) {
        String[] parts = timeStr.split(":");
        int h = Integer.parseInt(parts[0]);
        int m = Integer.parseInt(parts[1]);
        int halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
        return (halfHours == 0 && m < 30) ? 8 : halfHours;
    }

    // 15. Earliest difference between primes
    public static int[] primeDiff(int targetDiff) {
        int prevPrime = 2;
        for (int i = 3; ; i += 2) {
            boolean isPrime = true;
            for (int j = 2; j * j <= i; j++) {
                if (i % j == 0) { isPrime = false; break; }
            }
            if (isPrime) {
                if (i - prevPrime == targetDiff) return new int[]{prevPrime, i};
                prevPrime = i;
            }
        }
    }

    // 16. Canny edge detector (Simplified/Sobel Concept)
    public static double[][] cannyConcept(int[][] pixelGrid) {
        int rows = pixelGrid.length;
        int cols = pixelGrid[0].length;
        double[][] edges = new double[rows][cols];
        for (int y = 1; y < rows - 1; y++) {
            for (int x = 1; x < cols - 1; x++) {
                int gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1];
                int gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x];
                edges[y][x] = Math.sqrt(gradX * gradX + gradY * gradY);
            }
        }
        return edges;
    }

    // 17. Death Star
    public static void drawDeathStar(int r) {
        for (int y = -r; y <= r; y++) {
            StringBuilder line = new StringBuilder();
            for (int x = -2 * r; x <= 2 * r; x++) {
                if (Math.pow(x / 2.0, 2) + Math.pow(y, 2) <= Math.pow(r, 2)) {
                    if (Math.pow((x / 2.0) - r / 2.0, 2) + Math.pow(y - r / 2.0, 2) <= Math.pow(r / 3.0, 2)) line.append(" ");
                    else line.append("#");
                } else line.append(" ");
            }
            System.out.println(line);
        }
    }

    // 18. Chat server stub
    public static String chatServerStub() {
        String host = "127.0.0.1";
        int port = 65432;
        return "Server configured for " + host + ":" + port;
    }

    // 19. Faulhaber's triangle (Using BigInteger for exactness like Fraction)
    public static void faulhaberTriangle(int n) {
        // Simplified representation: implementation usually requires a custom Fraction class in Java
        System.out.println("Faulhaber's triangle requires a rational number class for exact coefficients.");
    }

    // 20. Execute a Markov algorithm
    public static String markovAlgorithm(List<String[]> rules, String text) {
        boolean changed = true;
        while (changed) {
            changed = false;
            for (String[] rule : rules) {
                if (text.contains(rule[0])) {
                    text = text.replaceFirst(rule[0], rule[1]);
                    if (rule[2].equals("true")) return text;
                    changed = true;
                    break;
                }
            }
        }
        return text;
    }
}