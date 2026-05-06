const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // 1. Hello world/Text
    try stdout.print("Hello world!\n", .{});

    // 2. Fibonacci sequence
    _ = fib(10);

    // 3. Factorial
    _ = factorial(10);

    // 4. 99 bottles of beer
    try bottlesOfBeer(stdout);

    // 5. Bubble sort
    var arr = [_]i32{ 5, 2, 8, 1, 9 };
    bubbleSort(i32, &arr);

    // 6. FizzBuzz
    try fizzBuzz(stdout);

    // 7. Empty program (This main function serves the purpose)

    // 8. A+B
    _ = try aPlusB("10 20");

    // 9. 100 doors
    try hundredDoors(stdout);

    // 10. Quine
    const s = "const std = @import(\"std\"); pub fn main() !void {{ const s = {c}{s}{c}; std.debug.print(s, .{{ 34, s, 34 }}); }}";
    // (Actual quine prints itself; logic: try stdout.print(s, .{ 34, s, 34 });)

    // 11. Launch rocket
    try launchRocket(stdout);

    // 12. NKT Law
    _ = nktLaw(10.0, 20.0, 100.0, 0.05);

    // 13. Universal Lambda Machine (Church Numerals)
    const church_two = succ(succ(zero));
    _ = church_two(toIntHelper, 0);

    // 14. Nautical bell
    _ = nauticalBell(13, 30);

    // 15. Earliest difference between primes
    _ = earliestPrimeDiff(6);

    // 17. Death Star
    try drawDeathStar(stdout, 10);

    // 18. Chat server stub
    _ = chatServerStub();

    // 20. Markov Algorithm
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const rules = [_]MarkovRule{
        .{ .pattern = "A", .replacement = "apple", .terminal = false },
        .{ .pattern = "apple", .replacement = "fruit", .terminal = true },
    };
    const result = try markovAlgorithm(allocator, &rules, "I have an A");
    defer allocator.free(result);
}

// --- Implementations ---

fn fib(n: u64) u64 {
    var a: u64 = 0;
    var b: u64 = 1;
    var i: u64 = 0;
    while (i < n) : (i += 1) {
        const temp = a;
        a = b;
        b = temp + b;
    }
    return a;
}

fn factorial(n: u64) u64 {
    if (n == 0) return 1;
    var res: u64 = 1;
    var i: u64 = 1;
    while (i <= n) : (i += 1) res *= i;
    return res;
}

fn bottlesOfBeer(writer: anytype) !void {
    var i: i32 = 99;
    while (i > 0) : (i -= 1) {
        const s = if (i != 1) "s" else "";
        const next_i = i - 1;
        const s_next = if (next_i != 1) "s" else "";
        try writer.print("{d} bottle{s} of beer on the wall, {d} bottle{s} of beer.\n", .{ i, s, i, s });
        if (next_i > 0) {
            try writer.print("Take one down, pass it around, {d} bottle{s} of beer on the wall.\n\n", .{ next_i, s_next });
        } else {
            try writer.print("Take one down, pass it around, no more bottles of beer on the wall.\n\n", .{});
        }
    }
}

fn bubbleSort(comptime T: type, slice: []T) void {
    const n = slice.len;
    for (0..n) |i| {
        for (0..n - i - 1) |j| {
            if (slice[j] > slice[j + 1]) {
                const temp = slice[j];
                slice[j] = slice[j + 1];
                slice[j + 1] = temp;
            }
        }
    }
}

fn fizzBuzz(writer: anytype) !void {
    var i: u32 = 1;
    while (i <= 100) : (i += 1) {
        if (i % 15 == 0) try writer.writeAll("FizzBuzz\n")
        else if (i % 3 == 0) try writer.writeAll("Fizz\n")
        else if (i % 5 == 0) try writer.writeAll("Buzz\n")
        else try writer.print("{d}\n", .{i});
    }
}

fn aPlusB(input: []const u8) !i32 {
    var iter = std.mem.tokenizeAny(u8, input, " \t\n\r");
    var sum: i32 = 0;
    while (iter.next()) |token| {
        sum += try std.fmt.parseInt(i32, token, 10);
    }
    return sum;
}

fn hundredDoors(writer: anytype) !void {
    var doors = [_]bool{false} ** 101;
    var i: usize = 1;
    while (i <= 100) : (i += 1) {
        var j = i;
        while (j <= 100) : (j += i) {
            doors[j] = !doors[j];
        }
    }
    for (doors, 0..) |is_open, idx| {
        if (is_open) try writer.print("Door {d} is open\n", .{idx});
    }
}

fn launchRocket(writer: anytype) !void {
    const accel: f32 = 9.8;
    var velocity: f32 = 0;
    var t: i32 = 10;
    while (t >= 0) : (t -= 1) {
        try writer.print("T-minus {d}...\n", .{t});
        std.time.sleep(100 * std.time.ns_per_ms);
    }
    try writer.writeAll("Liftoff!\n");
    for (1..4) |time_s| {
        velocity += accel;
        try writer.print("Time: {d}s, Velocity: {d:.1}m/s, Accel: {d:.1}m/s^2\n", .{ time_s, velocity, accel });
    }
}

fn nktLaw(t: f64, t_env: f64, t_init: f64, k: f64) f64 {
    return t_env + (t_init - t_env) * std.math.exp(-k * t);
}

const Lambda = *const fn (func: *const fn (i32) i32, x: i32) i32;
fn zero(f: *const fn (i32) i32, x: i32) i32 { _ = f; return x; }
fn succ(n: Lambda) Lambda {
    const Closure = struct {
        var captured_n: Lambda = undefined;
        fn wrap(f: *const fn (i32) i32, x: i32) i32 {
            return f(captured_n(f, x));
        }
    };
    Closure.captured_n = n;
    return Closure.wrap;
}
fn toIntHelper(x: i32) i32 { return x + 1; }

fn nauticalBell(h: u32, m: u32) u32 {
    const half_hours = (h % 4) * 2 + (if (m >= 30) @as(u32, 1) else 0);
    return if (half_hours == 0 and m < 30) 8 else half_hours;
}

fn earliestPrimeDiff(target: u64) [2]u64 {
    var prev: u64 = 2;
    var curr: u64 = 3;
    while (true) {
        if (isPrime(curr)) {
            if (curr - prev == target) return .{ prev, curr };
            prev = curr;
        }
        curr += 2;
    }
}

fn isPrime(n: u64) bool {
    if (n < 2) return false;
    var i: u64 = 2;
    while (i * i <= n) : (i += 1) {
        if (n % i == 0) return false;
    }
    return true;
}

fn drawDeathStar(writer: anytype, r: i32) !void {
    var y = -r;
    while (y <= r) : (y += 1) {
        var x = @as(i32, @intFromFloat(-2.0 * @as(f32, @floatFromInt(r))));
        const x_limit = @as(i32, @intFromFloat(2.0 * @as(f32, @floatFromInt(r))));
        while (x <= x_limit) : (x += 1) {
            const x_f = @as(f32, @floatFromInt(x)) / 2.0;
            const y_f = @as(f32, @floatFromInt(y));
            const r_f = @as(f32, @floatFromInt(r));
            if (x_f * x_f + y_f * y_f <= r_f * r_f) {
                if ((x_f - r_f / 2.0) * (x_f - r_f / 2.0) + (y_f - r_f / 2.0) * (y_f - r_f / 2.0) <= (r_f / 3.0) * (r_f / 3.0)) {
                    try writer.writeAll(" ");
                } else try writer.writeAll("#");
            } else try writer.writeAll(" ");
        }
        try writer.writeAll("\n");
    }
}

fn chatServerStub() []const u8 {
    return "Server configured for 127.0.0.1:65432";
}

const MarkovRule = struct { pattern: []const u8, replacement: []const u8, terminal: bool };
fn markovAlgorithm(allocator: std.mem.Allocator, rules: []const MarkovRule, input: []const u8) ![]u8 {
    var text = try allocator.dupe(u8, input);
    while (true) {
        var applied = false;
        for (rules) |rule| {
            if (std.mem.indexOf(u8, text, rule.pattern)) |pos| {
                const new_text = try std.mem.concat(allocator, u8, &[_][]const u8{ text[0..pos], rule.replacement, text[pos + rule.pattern.len ..] });
                allocator.free(text);
                text = new_text;
                if (rule.terminal) return text;
                applied = true;
                break;
            }
        }
        if (!applied) break;
    }
    return text;
}