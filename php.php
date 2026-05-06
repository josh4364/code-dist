<?php

// ==========================================
// PART 1: TOP 10 MOST IMPLEMENTED TASKS
// ==========================================

// 1. Hello world/Text
function hello_world() {
    echo "Hello world!\n";
}

// 2. Fibonacci sequence
function fib($n) {
    $a = 0;
    $b = 1;
    for ($i = 0; $i < $n; $i++) {
        $temp = $a;
        $a = $b;
        $b = $temp + $b;
    }
    return $a;
}

// 3. Factorial
function factorial($n) {
    if ($n === 0) return 1;
    return array_product(range(1, $n));
}

// 4. 99 bottles of beer
function bottles_of_beer() {
    for ($i = 99; $i > 0; $i--) {
        $s = ($i !== 1) ? "s" : "";
        $next_count = ($i - 1 > 0) ? ($i - 1) : "no more";
        $s_next = ($next_count !== 1) ? "s" : "";
        
        printf("%d bottle%s of beer on the wall, %d bottle%s of beer.\n", $i, $s, $i, $s);
        printf("Take one down, pass it around, %s bottle%s of beer on the wall.\n\n", $next_count, $s_next);
    }
}

// 5. Bubble sort
function bubble_sort($arr) {
    $n = count($arr);
    for ($i = 0; $i < $n; $i++) {
        for ($j = 0; $j < $n - $i - 1; $j++) {
            if ($arr[$j] > $arr[$j + 1]) {
                $temp = $arr[$j];
                $arr[$j] = $arr[$j + 1];
                $arr[$j + 1] = $temp;
            }
        }
    }
    return $arr;
}

// 6. FizzBuzz
function fizzbuzz() {
    for ($i = 1; $i <= 100; $i++) {
        if ($i % 15 === 0) echo "FizzBuzz\n";
        elseif ($i % 3 === 0) echo "Fizz\n";
        elseif ($i % 5 === 0) echo "Buzz\n";
        else echo $i . "\n";
    }
}

// 7. Empty program
// A file containing only the PHP opening tag or a semicolon is valid.
;

// 8. A+B
function a_plus_b($input_str) {
    return array_sum(explode(' ', $input_str));
}

// 9. 100 doors
function hundred_doors() {
    $doors = array_fill(1, 100, false);
    for ($i = 1; $i <= 100; $i++) {
        for ($j = $i; $j <= 100; $j += $i) {
            $doors[$j] = !$doors[$j];
        }
    }
    return array_keys(array_filter($doors));
}

// 10. Quine
function quine() {
    $s = 'echo "<?php\n\$s = " . var_export($s, true) . ";\n" . $s;';
    echo "<?php\n\$s = " . var_export($s, true) . ";\n" . $s;
}

// ==========================================
// PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
// ==========================================

// 11. Launch rocket with countdown and acceleration
function launch_rocket() {
    $accel = 9.8;
    $velocity = 0;
    for ($t = 10; $t >= 0; $t--) {
        echo "T-minus $t...\n";
        usleep(100000); // 0.1 seconds
    }
    echo "Liftoff!\n";
    for ($t = 1; $t <= 3; $t++) {
        $velocity += $accel;
        printf("Time: %ds, Velocity: %.1fm/s, Accel: %sm/s^2\n", $t, $velocity, $accel);
    }
}

// 12. Experimental Verification of the NKT Law
function nkt_law_verify($t, $t_env, $t_init, $k) {
    return $t_env + ($t_init - $t_env) * exp(-$k * $t);
}

// 13. Universal Lambda Machine
function universal_lambda() {
    $zero = fn($f) => fn($x) => $x;
    $succ = fn($n) => fn($f) => fn($x) => $f($n($f)($x));
    $to_int = fn($n) => $n(fn($x) => $x + 1)(0);
    
    return $to_int($succ($succ($zero)));
}

// 14. Nautical bell
function nautical_bell($time_str) {
    list($h, $m) = explode(':', $time_str);
    $half_hours = ($h % 4) * 2 + ($m >= 30 ? 1 : 0);
    return ($half_hours == 0 && $m < 30) ? 8 : $half_hours;
}

// 15. Earliest difference between primes
function prime_diff($target_diff) {
    $is_prime = function($n) {
        if ($n < 2) return false;
        for ($i = 2; $i <= sqrt($n); $i++) {
            if ($n % $i === 0) return false;
        }
        return true;
    };
    
    $prev_prime = 2;
    $current = 3;
    while (true) {
        if ($is_prime($current)) {
            if ($current - $prev_prime === $target_diff) {
                return [$prev_prime, $current];
            }
            $prev_prime = $current;
        }
        $current += 2;
    }
}

// 16. Canny edge detector (Simplified concept)
function canny_concept($pixel_grid) {
    $height = count($pixel_grid);
    $width = count($pixel_grid[0]);
    $edges = array_fill(0, $height, array_fill(0, $width, 0));
    
    for ($y = 1; $y < $height - 1; $y++) {
        for ($x = 1; $x < $width - 1; $x++) {
            $grad_x = $pixel_grid[$y][$x+1] - $pixel_grid[$y][$x-1];
            $grad_y = $pixel_grid[$y+1][$x] - $pixel_grid[$y-1][$x];
            $edges[$y][$x] = sqrt($grad_x**2 + $grad_y**2);
        }
    }
    return $edges;
}

// 17. Death Star
function draw_death_star($r = 10) {
    for ($y = -$r; $y <= $r; $y++) {
        $line = "";
        for ($x = (int)(-2.0 * $r); $x <= (int)(2.0 * $r); $x++) {
            if (pow($x/2, 2) + pow($y, 2) <= pow($r, 2)) {
                if (pow(($x/2) - $r/2, 2) + pow($y - $r/2, 2) <= pow($r/3, 2)) {
                    $line .= " ";
                } else {
                    $line .= "#";
                }
            } else {
                $line .= " ";
            }
        }
        echo $line . "\n";
    }
}

// 18. Chat server stub
function chat_server_stub() {
    $host = '127.0.0.1';
    $port = 65432;
    // socket_create, socket_bind, socket_listen would happen here
    return "Server configured for $host:$port";
}

// 19. Faulhaber's triangle (Requires BCMath or a Fraction class for precision, 
// using floats here to mirror basic Python structure without external libs)
function nCr($n, $r) {
    if ($r < 0 || $r > $n) return 0;
    if ($r == 0 || $r == $n) return 1;
    if ($r > $n / 2) $r = $n - $r;
    $res = 1;
    for ($i = 1; $i <= $r; $i++) {
        $res = $res * ($n - $i + 1) / $i;
    }
    return $res;
}

function faulhaber_triangle($n) {
    $bernoulli = function($m) {
        $B = [];
        for ($i = 0; $i <= $m; $i++) {
            $B[$i] = 1 / ($i + 1);
            for ($j = $i; $j > 0; $j--) {
                $B[$j-1] = $j * ($B[$j-1] - $B[$j]);
            }
        }
        return $B[0];
    };

    $triangle = [];
    for ($p = 0; $p < $n; $p++) {
        $row = [];
        for ($j = 0; $j <= $p; $j++) {
            $val = (1 / ($p + 1)) * nCr($p + 1, $j) * $bernoulli($j);
            $row[] = $val;
        }
        $triangle[] = $row;
    }
    return $triangle;
}

// 20. Execute a Markov algorithm
function markov_algorithm($rules, $text) {
    while (true) {
        $applied = false;
        foreach ($rules as $rule) {
            list($pattern, $replacement, $terminal) = $rule;
            if (strpos($text, $pattern) !== false) {
                $text = preg_replace('/' . preg_quote($pattern, '/') . '/', $replacement, $text, 1);
                if ($terminal) return $text;
                $applied = true;
                break;
            }
        }
        if (!$applied) break;
    }
    return $text;
}