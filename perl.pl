use strict;
use warnings;
use utf8;
use POSIX qw(floor);
use Time::HiRes qw(sleep);
use IO::Socket::INET;

# 1. Hello world/Text
sub hello_world {
    print "Hello world!\n";
}

# 2. Fibonacci sequence
sub fib {
    my $n = shift;
    my ($a, $b) = (0, 1);
    for (1..$n) {
        ($a, $b) = ($b, $a + $b);
    }
    return $a;
}

# 3. Factorial
sub factorial {
    my $n = shift;
    my $res = 1;
    $res *= $_ for 1..$n;
    return $res;
}

# 4. 99 bottles of beer
sub bottles_of_beer {
    for (reverse 1..99) {
        my $s = $_ != 1 ? "s" : "";
        my $next = $_ - 1;
        my $s_next = $next != 1 ? "s" : "";
        my $next_count = $next > 0 ? $next : "no more";
        printf "%d bottle%s of beer on the wall, %d bottle%s of beer.\n", $_, $s, $_, $s;
        printf "Take one down, pass it around, %s bottle%s of beer on the wall.\n\n", $next_count, $s_next;
    }
}

# 5. Bubble sort
sub bubble_sort {
    my @arr = @_;
    my $n = scalar @arr;
    for my $i (0..$n-1) {
        for my $j (0..$n-$i-2) {
            if ($arr[$j] > $arr[$j+1]) {
                @arr[$j, $j+1] = @arr[$j+1, $j];
            }
        }
    }
    return @arr;
}

# 6. FizzBuzz
sub fizzbuzz {
    for my $i (1..100) {
        if    ($i % 15 == 0) { print "FizzBuzz\n" }
        elsif ($i % 3  == 0) { print "Fizz\n" }
        elsif ($i % 5  == 0) { print "Buzz\n" }
        else                 { print "$i\n" }
    }
}

# 7. Empty program
# (Valid empty file)

# 8. A+B
sub a_plus_b {
    my $input_str = shift;
    my $sum = 0;
    $sum += $_ for split ' ', $input_str;
    return $sum;
}

# 9. 100 doors
sub hundred_doors {
    my @doors = (0) x 101;
    for my $i (1..100) {
        for (my $j = $i; $j <= 100; $j += $i) {
            $doors[$j] = !$doors[$j];
        }
    }
    return grep { $doors[$_] } 1..100;
}

# 10. Quine
sub quine {
    my $s = 'my $s = %c%s%c; printf $s, 39, $s, 39, 10;';
    printf $s, 39, $s, 39, 10;
}

# 11. Launch rocket
sub launch_rocket {
    my $accel = 9.8;
    my $velocity = 0;
    for (reverse 0..10) {
        print "T-minus $_...\n";
        sleep 0.1;
    }
    print "Liftoff!\n";
    for my $t (1..3) {
        $velocity += $accel;
        printf "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n", $t, $velocity, $accel;
    }
}

# 12. Experimental Verification of the NKT Law
sub nkt_law_verify {
    my ($t, $t_env, $t_init, $k) = @_;
    return $t_env + ($t_init - $t_env) * exp(-$k * $t);
}

# 13. Universal Lambda Machine
sub universal_lambda {
    my $zero = sub { my $f = shift; sub { my $x = shift; $x } };
    my $succ = sub { my $n = shift; sub { my $f = shift; sub { my $x = shift; $f->($n->($f)->($x)) } } };
    my $to_int = sub { my $n = shift; $n->(sub { shift() + 1 })->(0) };
    return $to_int->($succ->($succ->($zero)));
}

# 14. Nautical bell
sub nautical_bell {
    my $time_str = shift;
    my ($h, $m) = split ':', $time_str;
    my $half_hours = ($h % 4) * 2 + ($m >= 30 ? 1 : 0);
    return ($half_hours == 0 && $m < 30) ? 8 : $half_hours;
}

# 15. Earliest difference between primes
sub prime_diff {
    my $target = shift;
    my $is_prime = sub {
        my $n = shift;
        return 0 if $n < 2;
        for (my $i = 2; $i*$i <= $n; $i++) { return 0 if $n % $i == 0 }
        return 1;
    };
    my ($prev, $curr) = (2, 3);
    while (1) {
        if ($is_prime->($curr)) {
            return ($prev, $curr) if $curr - $prev == $target;
            $prev = $curr;
        }
        $curr += 2;
    }
}

# 16. Canny edge detector (Mock)
sub canny_concept {
    my $grid = shift;
    my @edges;
    for my $y (1 .. $#$grid - 1) {
        for my $x (1 .. $#{$grid->[0]} - 1) {
            my $gx = $grid->[$y][$x+1] - $grid->[$y][$x-1];
            my $gy = $grid->[$y+1][$x] - $grid->[$y-1][$x];
            $edges[$y][$x] = sqrt($gx**2 + $gy**2);
        }
    }
    return \@edges;
}

# 17. Death Star
sub draw_death_star {
    my $r = shift // 10;
    for (my $y = -$r; $y <= $r; $y++) {
        my $line = "";
        for (my $x = -2*$r; $x <= 2*$r; $x++) {
            if (($x/2)**2 + $y**2 <= $r**2) {
                if ((($x/2)-$r/2)**2 + ($y-$r/2)**2 <= ($r/3)**2) { $line .= " " }
                else { $line .= "#" }
            } else { $line .= " " }
        }
        print "$line\n";
    }
}

# 18. Chat server stub
sub chat_server_stub {
    my ($host, $port) = ('127.0.0.1', 65432);
    # my $s = IO::Socket::INET->new(LocalAddr => $host, LocalPort => $port, Proto => 'tcp', Listen => 5, Reuse => 1);
    return "Server configured for $host:$port";
}

# 19. Faulhaber's triangle (Using Math::BigRat or simple logic)
sub faulhaber_triangle {
    my $n = shift;
    # Simplified: Returns structure; Perl often uses Math::BigRat for exact fractions.
    return "See Rosetta Code Perl for Math::BigRat Faulhaber implementation";
}

# 20. Execute a Markov algorithm
sub markov_algorithm {
    my ($rules, $text) = @_;
    my $applied = 1;
    while ($applied) {
        $applied = 0;
        for my $rule (@$rules) {
            my ($pat, $rep, $term) = @$rule;
            if ($text =~ /\Q$pat\E/) {
                $text =~ s/\Q$pat\E/$rep/;
                return $text if $term;
                $applied = 1;
                last;
            }
        }
    }
    return $text;
}