% ==========================================
% PART 1: TOP 10 MOST IMPLEMENTED TASKS
% ==========================================

% 1. Hello world/Text
function hello_world()
    fprintf('Hello world!\n');
end

% 2. Fibonacci sequence (Iterative)
function val = fib(n)
    a = 0; b = 1;
    for i = 1:n
        temp = a;
        a = b;
        b = temp + b;
    end
    val = a;
end

% 3. Factorial
function val = factorial_task(n)
    val = factorial(n);
end

% 4. 99 bottles of beer
function bottles_of_beer()
    for i = 99:-1:1
        s = 's'; if i == 1, s = ''; end
        next_i = i - 1;
        s_next = 's'; if next_i == 1, s_next = ''; end
        
        if next_i > 0
            next_count = num2str(next_i);
        else
            next_count = 'no more';
        end
        
        fprintf('%d bottle%s of beer on the wall, %d bottle%s of beer.\n', i, s, i, s);
        fprintf('Take one down, pass it around, %s bottle%s of beer on the wall.\n\n', next_count, s_next);
    end
end

% 5. Bubble sort
function arr = bubble_sort(arr)
    n = length(arr);
    for i = 1:n
        for j = 1:(n - i)
            if arr(j) > arr(j + 1)
                temp = arr(j);
                arr(j) = arr(j + 1);
                arr(j + 1) = temp;
            end
        end
    end
end

% 6. FizzBuzz
function fizzbuzz()
    for i = 1:100
        if mod(i, 15) == 0, fprintf('FizzBuzz\n');
        elseif mod(i, 3) == 0, fprintf('Fizz\n');
        elseif mod(i, 5) == 0, fprintf('Buzz\n');
        else, fprintf('%d\n', i);
        end
    end
end

% 7. Empty program
% (An empty .m file or a file with only comments serves as an empty program)

% 8. A+B
function res = a_plus_b(input_str)
    nums = sscanf(input_str, '%f');
    res = sum(nums);
end

% 9. 100 doors
function open_doors = hundred_doors()
    doors = false(1, 100);
    for i = 1:100
        doors(i:i:100) = ~doors(i:i:100);
    end
    open_doors = find(doors);
end

% 10. Quine
function quine()
    s = 's = %c%s%c; fprintf(s, 39, s, 39);';
    fprintf(s, 39, s, 39);
end


% ==========================================
% PART 2: 10 LEAST IMPLEMENTED / NICHE TASKS
% ==========================================

% 11. Launch rocket with countdown and acceleration
function launch_rocket()
    accel = 9.8;
    velocity = 0;
    for t = 10:-1:0
        fprintf('T-minus %d...\n', t);
        pause(0.1);
    end
    fprintf('Liftoff!\n');
    for t = 1:3
        velocity = velocity + accel;
        fprintf('Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n', t, velocity, accel);
    end
end

% 12. Experimental Verification of the NKT Law
function T = nkt_law_verify(t, t_env, t_init, k)
    T = t_env + (t_init - t_env) * exp(-k * t);
end

% 13. Universal Lambda Machine (Church Encoding)
function val = universal_lambda()
    zero = @(f) @(x) x;
    succ = @(n) @(f) @(x) f(n(f)(x));
    to_int = @(n) n(@(x) x + 1)(0);
    val = to_int(succ(succ(zero)));
end

% 14. Nautical bell
function bells = nautical_bell(time_str)
    t = datetime(time_str, 'Format', 'HH:mm');
    h = t.Hour; m = t.Minute;
    half_hours = mod(h, 4) * 2 + (m >= 30);
    if half_hours == 0 && m < 30, bells = 8; else, bells = half_hours; end
end

% 15. Earliest difference between primes
function pair = prime_diff(target_diff)
    prev_prime = 2;
    current = 3;
    while true
        if isprime(current)
            if (current - prev_prime) == target_diff
                pair = [prev_prime, current];
                return;
            end
            prev_prime = current;
        end
        current = current + 2;
    end
end

% 16. Canny edge detector (Sobel core)
function edges = canny_concept(pixel_grid)
    [rows, cols] = size(pixel_grid);
    edges = zeros(rows, cols);
    for y = 2:rows-1
        for x = 2:cols-1
            grad_x = pixel_grid(y, x+1) - pixel_grid(y, x-1);
            grad_y = pixel_grid(y+1, x) - pixel_grid(y-1, x);
            edges(y, x) = sqrt(grad_x^2 + grad_y^2);
        end
    end
end

% 17. Death Star
function draw_death_star(r)
    if nargin < 1, r = 10; end
    for y = -r:r
        line = '';
        for x = floor(-2.0*r):floor(2.0*r)
            if (x/2)^2 + y^2 <= r^2
                if ((x/2)-r/2)^2 + (y-r/2)^2 <= (r/3)^2
                    line = [line ' '];
                else
                    line = [line '#'];
                end
            else
                line = [line ' '];
            end
        end
        fprintf('%s\n', line);
    end
end

% 18. Chat server stub
function msg = chat_server_stub()
    host = '127.0.0.1'; port = 65432;
    % MATLAB uses tcpserver for basic socket listening
    % s = tcpserver(host, port); 
    msg = sprintf('Server configured for %s:%d', host, port);
end

% 19. Faulhaber's triangle
function triangle = faulhaber_triangle(n)
    triangle = cell(n, 1);
    for p = 0:n-1
        row = sym(zeros(1, p + 1)); % Use symbolic for exact fractions
        for j = 0:p
            % Bernoulli numbers B_j+ in MATLAB
            row(j+1) = (1/(p+1)) * nchoosek(p+1, j) * bernoulli(j);
        end
        triangle{p+1} = row;
    end
end

% 20. Execute a Markov algorithm
function text = markov_algorithm(rules, text)
    % rules is a cell array of {pattern, replacement, is_terminal}
    while true
        applied = false;
        for i = 1:length(rules)
            pattern = rules{i}{1};
            replacement = rules{i}{2};
            terminal = rules{i}{3};
            
            pos = strfind(text, pattern);
            if ~isempty(pos)
                text = [text(1:pos(1)-1), replacement, text(pos(1)+length(pattern):end)];
                if terminal, return; end
                applied = true;
                break;
            end
        end
        if ~applied, break; end
    end
end

function b = bernoulli(n)
    % Simple Akiyama-Tanigawa algorithm for Bernoulli numbers
    A = cell(1, n+1);
    for m = 0:n
        A{m+1} = sym(1) / (m + 1);
        for j = m:-1:1
            A{j} = j * (A{j} - A{j+1});
        end
    end
    b = A{1};
end