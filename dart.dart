import 'dart:math' as math;
import 'dart:io';
import 'dart:async';

// 1. Hello world/Text
void helloWorld() {
  print("Hello world!");
}

// 2. Fibonacci sequence
int fib(int n) {
  int a = 0, b = 1;
  for (int i = 0; i < n; i++) {
    int temp = a;
    a = b;
    b = temp + b;
  }
  return a;
}

// 3. Factorial
BigInt factorial(int n) {
  BigInt res = BigInt.one;
  for (int i = 2; i <= n; i++) res *= BigInt.from(i);
  return res;
}

// 4. 99 bottles of beer
void bottlesOfBeer() {
  for (int i = 99; i > 0; i--) {
    String s = i != 1 ? "s" : "";
    String sNext = (i - 1) != 1 ? "s" : "";
    String nextCount = (i - 1) > 0 ? "${i - 1}" : "no more";
    print("$i bottle$s of beer on the wall, $i bottle$s of beer.");
    print("Take one down, pass it around, $nextCount bottle$sNext of beer on the wall.\n");
  }
}

// 5. Bubble sort
List<num> bubbleSort(List<num> arr) {
  int n = arr.length;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        num temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
  return arr;
}

// 6. FizzBuzz
void fizzBuzz() {
  for (int i = 1; i <= 101; i++) {
    if (i % 15 == 0) print("FizzBuzz");
    else if (i % 3 == 0) print("Fizz");
    else if (i % 5 == 0) print("Buzz");
    else print(i);
  }
}

// 7. Empty program
void main() {}

// 8. A+B
int aPlusB(String inputStr) {
  return inputStr.split(RegExp(r'\s+')).map(int.parse).reduce((a, b) => a + b);
}

// 9. 100 doors
List<int> hundredDoors() {
  List<bool> doors = List.filled(101, false);
  for (int i = 1; i <= 100; i++) {
    for (int j = i; j <= 100; j += i) {
      doors[j] = !doors[j];
    }
  }
  List<int> openDoors = [];
  for (int i = 1; i <= 100; i++) {
    if (doors[i]) openDoors.add(i);
  }
  return openDoors;
}

// 10. Quine
void quine() {
  String s = "void main() { String s = %c%s%c; print(s.replaceAll(String.fromCharCode(37)+String.fromCharCode(99), String.fromCharCode(34)).replaceAll(String.fromCharCode(37)+String.fromCharCode(115), s)); }";
  // Dart's closest equivalent to Python's %r approach:
  var q = '"';
  var code = 'void main(){var s=%s%s%s;print(s.replaceFirst(%s%s%s,s).replaceFirst(%s%s%s,s).replaceFirst(%s%s%s,s));}';
  print(code.replaceFirst('%s', q).replaceFirst('%s', code).replaceFirst('%s', q));
}

// 11. Launch rocket
Future<void> launchRocket() async {
  double accel = 9.8;
  double velocity = 0;
  for (int t = 10; t >= 0; t--) {
    print("T-minus $t...");
    await Future.delayed(Duration(milliseconds: 100));
  }
  print("Liftoff!");
  for (int t = 1; t <= 3; t++) {
    velocity += accel;
    print("Time: ${t}s, Velocity: ${velocity.toStringAsFixed(1)}m/s, Accel: ${accel}m/s^2");
  }
}

// 12. Experimental Verification of the NKT Law
double nktLawVerify(double t, double tEnv, double tInit, double k) {
  return tEnv + (tInit - tEnv) * math.exp(-k * t);
}

// 13. Universal Lambda Machine
dynamic universalLambda() {
  var zero = (f) => (x) => x;
  var succ = (n) => (f) => (x) => f(n(f)(x));
  var toInt = (n) => n((int x) => x + 1)(0);
  return toInt(succ(succ(zero)));
}

// 14. Nautical bell
int nauticalBell(String timeStr) {
  var parts = timeStr.split(':');
  int h = int.parse(parts[0]);
  int m = int.parse(parts[1]);
  int halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
  return (halfHours == 0 && m < 30) ? 8 : halfHours;
}

// 15. Earliest difference between primes
List<int>? primeDiff(int targetDiff) {
  bool isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= math.sqrt(n); i++) {
      if (n % i == 0) return false;
    }
    return true;
  }
  int prevPrime = 2;
  int current = 3;
  while (true) {
    if (isPrime(current)) {
      if (current - prevPrime == targetDiff) return [prevPrime, current];
      prevPrime = current;
    }
    current += 2;
  }
}

// 16. Canny edge detector (Simplified concept)
List<List<double>> cannyConcept(List<List<int>> pixelGrid) {
  int rows = pixelGrid.length;
  int cols = pixelGrid[0].length;
  var edges = List.generate(rows, (_) => List.filled(cols, 0.0));
  for (int y = 1; y < rows - 1; y++) {
    for (int x = 1; x < cols - 1; x++) {
      int gradX = pixelGrid[y][x + 1] - pixelGrid[y][x - 1];
      int gradY = pixelGrid[y + 1][x] - pixelGrid[y - 1][x];
      edges[y][x] = math.sqrt(math.pow(gradX, 2) + math.pow(gradY, 2));
    }
  }
  return edges;
}

// 17. Death Star
void drawDeathStar({int r = 10}) {
  for (int y = -r; y <= r; y++) {
    var line = StringBuffer();
    for (int x = (-2.0 * r).toInt(); x <= (2.0 * r).toInt(); x++) {
      if (math.pow(x / 2, 2) + math.pow(y, 2) <= math.pow(r, 2)) {
        if (math.pow((x / 2) - r / 2, 2) + math.pow(y - r / 2, 2) <= math.pow(r / 3, 2)) {
          line.write(" ");
        } else {
          line.write("#");
        }
      } else {
        line.write(" ");
      }
    }
    print(line.toString());
  }
}

// 18. Chat server (Stub)
String chatServerStub() {
  String host = '127.0.0.1';
  int port = 65432;
  // In a real scenario: ServerSocket.bind(host, port).then((server) {...});
  return "Server configured for $host:$port";
}

// 19. Faulhaber's triangle (Requires custom Fraction logic or double approximation)
// Using simplified double representation as Dart lacks built-in Fractions
List<List<double>> faulhaberTriangle(int n) {
  double bernoulli(int m) {
    List<double> B = List.filled(m + 1, 0.0);
    for (int i = 0; i <= m; i++) {
      B[i] = 1.0 / (i + 1);
      for (int j = i; j > 0; j--) {
        B[j - 1] = j * (B[j - 1] - B[j]);
      }
    }
    return B[0];
  }
  int nCr(int n, int r) {
    if (r < 0 || r > n) return 0;
    if (r == 0 || r == n) return 1;
    if (r > n / 2) r = n - r;
    int res = 1;
    for (int i = 1; i <= r; i++) res = res * (n - i + 1) ~/ i;
    return res;
  }
  List<List<double>> triangle = [];
  for (int p = 0; p < n; p++) {
    List<double> row = [];
    for (int j = 0; j <= p; j++) {
      double val = (1.0 / (p + 1)) * nCr(p + 1, j) * bernoulli(j);
      row.add(val);
    }
    triangle.add(row);
  }
  return triangle;
}

// 20. Execute a Markov algorithm
String markovAlgorithm(List<List<dynamic>> rules, String text) {
  while (true) {
    bool applied = false;
    for (var rule in rules) {
      String pattern = rule[0];
      String replacement = rule[1];
      bool isTerminal = rule[2];
      if (text.contains(pattern)) {
        text = text.replaceFirst(pattern, replacement);
        if (isTerminal) return text;
        applied = true;
        break;
      }
    }
    if (!applied) break;
  }
  return text;
}