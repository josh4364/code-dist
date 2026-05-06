#import <Foundation/Foundation.h>
#include <math.h>
#include <unistd.h>

// 1. Hello world/Text
void helloWorld() {
    NSLog(@"Hello world!");
}

// 2. Fibonacci sequence
unsigned long long fib(int n) {
    unsigned long long a = 0, b = 1;
    for (int i = 0; i < n; i++) {
        unsigned long long temp = a;
        a = b;
        b = temp + b;
    }
    return a;
}

// 3. Factorial
double factorial(int n) {
    return tgamma(n + 1);
}

// 4. 99 bottles of beer
void bottlesOfBeer() {
    for (int i = 99; i > 0; i--) {
        NSString *s = (i != 1) ? @"s" : @"";
        NSString *s_next = (i - 1 != 1) ? @"s" : @"";
        NSString *next_count = (i - 1 > 0) ? [NSString stringWithFormat:@"%d", i - 1] : @"no more";
        printf("%d bottle%s of beer on the wall, %d bottle%s of beer.\n", i, [s UTF8String], i, [s UTF8String]);
        printf("Take one down, pass it around, %s bottle%s of beer on the wall.\n\n", [next_count UTF8String], [s_next UTF8String]);
    }
}

// 5. Bubble sort
void bubbleSort(NSMutableArray *arr) {
    NSUInteger n = [arr count];
    for (NSUInteger i = 0; i < n; i++) {
        for (NSUInteger j = 0; j < n - i - 1; j++) {
            if ([arr[j] compare:arr[j+1]] == NSOrderedDescending) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
}

// 6. FizzBuzz
void fizzBuzz() {
    for (int i = 1; i <= 100; i++) {
        if (i % 15 == 0) printf("FizzBuzz\n");
        else if (i % 3 == 0) printf("Fizz\n");
        else if (i % 5 == 0) printf("Buzz\n");
        else printf("%d\n", i);
    }
}

// 7. Empty program
// int main() { return 0; }

// 8. A+B
NSInteger aPlusB(NSString *inputStr) {
    NSArray *parts = [inputStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSInteger sum = 0;
    for (NSString *s in parts) sum += [s integerValue];
    return sum;
}

// 9. 100 doors
NSArray* hundredDoors() {
    BOOL doors[101] = {NO};
    for (int i = 1; i <= 100; i++) {
        for (int j = i; j <= 100; j += i) doors[j] = !doors[j];
    }
    NSMutableArray *openDoors = [NSMutableArray array];
    for (int i = 1; i <= 100; i++) if (doors[i]) [openDoors addObject:@(i)];
    return openDoors;
}

// 10. Quine
void quine() {
    const char *s = "#import <Foundation/Foundation.h>%1$cint main(){const char *s=%2$c%s%2$c;printf(s,10,34,s);return 0;}";
    printf(s, 10, 34, s);
}

// 11. Launch rocket
void launchRocket() {
    float accel = 9.8, velocity = 0;
    for (int t = 10; t >= 0; t--) {
        printf("T-minus %d...\n", t);
        usleep(100000);
    }
    printf("Liftoff!\n");
    for (int t = 1; t <= 3; t++) {
        velocity += accel;
        printf("Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n", t, velocity, accel);
    }
}

// 12. NKT Law (Newton's Law of Cooling)
double nktLawVerify(double t, double t_env, double t_init, double k) {
    return t_env + (t_init - t_env) * exp(-k * t);
}

// 13. Universal Lambda Machine (Church Numerals)
typedef id (^Lambda)(id);
void universalLambda() {
    Lambda zero = ^id(Lambda f) { return ^id(id x) { return x; }; };
    Lambda succ = ^id(Lambda n) { 
        return ^id(Lambda f) { 
            return ^id(id x) { return f(((Lambda)n(f))(x)); }; 
        }; 
    };
    Lambda toInt = ^id(Lambda n) {
        return ((Lambda)n(^id(id x) { return @([x integerValue] + 1); }))(@0);
    };
    NSLog(@"Value: %@", toInt(succ(succ(zero))));
}

// 14. Nautical bell
int nauticalBell(NSString *timeStr) {
    NSArray *p = [timeStr componentsSeparatedByString:@":"];
    int h = [p[0] intValue], m = [p[1] intValue];
    int halfHours = (h % 4) * 2 + (m >= 30 ? 1 : 0);
    return (halfHours == 0 && m < 30) ? 8 : halfHours;
}

// 15. Earliest difference between primes
NSArray* primeDiff(int targetDiff) {
    auto isPrime = ^BOOL(int n) {
        if (n < 2) return NO;
        for (int i = 2; i <= sqrt(n); i++) if (n % i == 0) return NO;
        return YES;
    };
    int prev = 2, curr = 3;
    while (YES) {
        if (isPrime(curr)) {
            if (curr - prev == targetDiff) return @[@(prev), @(curr)];
            prev = curr;
        }
        curr += 2;
    }
}

// 16. Canny edge detector (Simplified)
NSArray* cannyConcept(NSArray<NSArray<NSNumber*>*>* grid) {
    NSUInteger rows = [grid count], cols = [grid[0] count];
    NSMutableArray *edges = [NSMutableArray array];
    for (int y = 0; y < rows; y++) [edges addObject:[NSMutableArray arrayWithCapacity:cols]];
    for (int y = 1; y < rows - 1; y++) {
        for (int x = 1; x < cols - 1; x++) {
            double gx = [grid[y][x+1] doubleValue] - [grid[y][x-1] doubleValue];
            double gy = [grid[y+1][x] doubleValue] - [grid[y-1][x] doubleValue];
            edges[y][x] = @(sqrt(gx*gx + gy*gy));
        }
    }
    return edges;
}

// 17. Death Star
void drawDeathStar(int r) {
    for (int y = -r; y <= r; y++) {
        NSMutableString *line = [NSMutableString string];
        for (int x = (int)(-2.0 * r); x <= (int)(2.0 * r); x++) {
            if (pow(x/2.0, 2) + pow(y, 2) <= pow(r, 2)) {
                if (pow((x/2.0)-r/2.0, 2) + pow(y-r/2.0, 2) <= pow(r/3.0, 2)) [line appendString:@" "];
                else [line appendString:@"#"];
            } else [line appendString:@" "];
        }
        printf("%s\n", [line UTF8String]);
    }
}

// 18. Chat server stub
NSString* chatServerStub() {
    return @"Server configured for 127.0.0.1:65432";
}

// 19. Faulhaber's triangle
void faulhaberTriangle(int n) {
    // Requires custom Fraction class logic; placeholder for coefficient structure
    NSLog(@"Generating Faulhaber coefficients for n=%d", n);
}

// 20. Execute a Markov algorithm
NSString* markovAlgorithm(NSArray *rules, NSString *text) {
    NSMutableString *mt = [text mutableCopy];
    BOOL changed = YES;
    while (changed) {
        changed = NO;
        for (NSArray *rule in rules) {
            NSRange r = [mt rangeOfString:rule[0]];
            if (r.location != NSNotFound) {
                [mt replaceCharactersInRange:r withString:rule[1]];
                if ([rule[2] boolValue]) return mt;
                changed = YES; break;
            }
        }
    }
    return mt;
}