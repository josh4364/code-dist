-module(rosetta_tasks).
-compile(export_all).

%% 1. Hello world/Text
hello_world() ->
    io:format("Hello world!~n").

%% 2. Fibonacci sequence (Iterative)
fib(N) -> fib(N, 0, 1).
fib(0, A, _) -> A;
fib(N, A, B) -> fib(N - 1, B, A + B).

%% 3. Factorial
factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).

%% 4. 99 bottles of beer
bottles_of_beer() ->
    Loop = fun L(0) -> ok;
               L(I) ->
                S = if I == 1 -> ""; true -> "s" end,
                S_Next = if I - 1 == 1 -> ""; true -> "s" end,
                Next = if I - 1 > 0 -> integer_to_list(I - 1); true -> "no more" end,
                io:format("~w bottle~s of beer on the wall, ~w bottle~s of beer.~n", [I, S, I, S]),
                io:format("Take one down, pass it around, ~s bottle~s of beer on the wall.~n~n", [Next, S_Next]),
                L(I - 1)
           end,
    Loop(99).

%% 5. Bubble sort
bubble_sort(List) ->
    N = length(List),
    Iteration = fun(L) ->
        Sweep = fun S([A, B | T]) when A > B -> [B | S([A | T])];
                    S([A, B | T]) -> [A | S([B | T])];
                    S(Last) -> Last
                end,
        Sweep(L)
    end,
    lists:foldl(fun(_, Acc) -> Iteration(Acc) end, List, lists:seq(1, N)).

%% 6. FizzBuzz
fizzbuzz() ->
    [io:format("~s~n", [if I rem 15 == 0 -> "FizzBuzz"; 
                           I rem 3 == 0 -> "Fizz"; 
                           I rem 5 == 0 -> "Buzz"; 
                           true -> integer_to_list(I) 
                        end]) || I <- lists:seq(1, 100)].

%% 7. Empty program
% (An empty module file is valid Erlang, or just this comment)

%% 8. A+B
a_plus_b(InputStr) ->
    lists:sum([list_to_integer(X) || X <- string:tokens(InputStr, " \t\n\r")]).

%% 9. 100 doors
hundred_doors() ->
    Doors = maps:from_list([{I, false} || I <- lists:seq(1, 100)]),
    Toggled = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, InnerAcc) ->
            InnerAcc#{J => not maps:get(J, InnerAcc)}
        end, Acc, lists:seq(I, 100, I))
    end, Doors, lists:seq(1, 100)),
    [K || {K, V} <- maps:to_list(Toggled), V == true].

%% 10. Quine
quine() -> S = "quine() -> S = ~p, io:format(S, [S]).", io:format(S, [S]).

%% 11. Launch rocket
launch_rocket() ->
    Accel = 9.8,
    [begin io:format("T-minus ~w...~n", [T]), timer:sleep(100) end || T <- lists:seq(10, 0, -1)],
    io:format("Liftoff!~n"),
    lists:foldl(fun(T, V) ->
        NewV = V + Accel,
        io:format("Time: ~ws, Velocity: ~4.1fm/s, Accel: ~p m/s^2~n", [T, NewV, Accel]),
        NewV
    end, 0, lists:seq(1, 3)).

%% 12. NKT Law
nkt_law_verify(T, T_env, T_init, K) ->
    T_env + (T_init - T_env) * math:exp(-K * T).

%% 13. Universal Lambda Machine
universal_lambda() ->
    Zero = fun(_F) -> fun(X) -> X end end,
    Succ = fun(N) -> fun(F) -> fun(X) -> F((N(F))(X)) end end end,
    ToInt = fun(N) -> (N(fun(X) -> X + 1 end))(0) end,
    ToInt(Succ(Succ(Zero))).

%% 14. Nautical bell
nautical_bell(TimeStr) ->
    [H, M] = [list_to_integer(X) || X <- string:tokens(TimeStr, ":")],
    HalfHours = ((H rem 4) * 2) + (if M >= 30 -> 1; true -> 0 end),
    if HalfHours == 0 andalso M < 30 -> 8; true -> HalfHours end.

%% 15. Earliest difference between primes
prime_diff(TargetDiff) ->
    IsPrime = fun(N) ->
        if N < 2 -> false;
           true -> not lists:any(fun(I) -> N rem I == 0 end, lists:seq(2, trunc(math:sqrt(N))))
        end
    end,
    NextPrime = fun P(Curr) -> case IsPrime(Curr) of true -> Curr; false -> P(Curr + 1) end end,
    Find = fun F(Prev) ->
        Curr = NextPrime(Prev + 1),
        if Curr - Prev == TargetDiff -> {Prev, Curr};
           true -> F(Curr)
        end
    end,
    Find(2).

%% 16. Canny edge detector (Simplified concept)
canny_concept(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Arr = list_to_tuple([list_to_tuple(R) || R <- Grid]),
    Get = fun(Y, X) -> element(X, element(Y, Arr)) end,
    [[begin
        GX = Get(Y, X+1) - Get(Y, X-1),
        GY = Get(Y+1, X) - Get(Y-1, X),
        math:sqrt(GX*GX + GY*GY)
      end || X <- lists:seq(2, Cols-1)] || Y <- lists:seq(2, Rows-1)].

%% 17. Death Star
draw_death_star(R) ->
    [begin
        Line = [begin
            X_Scaled = X/2,
            InSphere = (X_Scaled*X_Scaled + Y*Y) =< R*R,
            InCrater = ((X_Scaled - R/2)*(X_Scaled - R/2) + (Y - R/2)*(Y - R/2)) =< (R/3)*(R/3),
            if InSphere andalso not InCrater -> $#; true -> $\s end
        end || X <- lists:seq(trunc(-2.0*R), trunc(2.0*R))],
        io:format("~s~n", [Line])
    end || Y <- lists:seq(-R, R)].

%% 18. Chat server stub
chat_server_stub() ->
    Host = "127.0.0.1", Port = 65432,
    % {ok, _Listen} = gen_tcp:listen(Port, [binary, {packet, 0}, {active, false}, {reuseaddr, true}]),
    io_lib:format("Server configured for ~s:~p", [Host, Port]).

%% 19. Faulhaber's triangle
faulhaber_triangle(N) ->
    Bernoulli = fun(M) ->
        B = lists:foldl(fun(I, Acc) ->
            Acc1 = Acc#{I => {1, I + 1}}, % Using simple {Num, Den} for logic
            lists:foldl(fun(J, InnerAcc) ->
                % Logic placeholder for Fraction arithmetic
                InnerAcc
            end, Acc1, lists:seq(I, 1, -1))
        end, #{}, lists:seq(0, M)),
        maps:get(0, B)
    end,
    [[{p, P, j, J} || J <- lists:seq(0, P)] || P <- lists:seq(0, N-1)].

%% 20. Execute a Markov algorithm
markov_algorithm(Rules, Text) ->
    Apply = fun(T) ->
        lists:foldl(fun({P, R, IsTerm}, {Acc, Done}) ->
            case {Done, string:find(Acc, P)} of
                {false, Nom} when Nom /= nomatch ->
                    {string:replace(Acc, P, R), {true, IsTerm}};
                _ -> {Acc, Done}
            end
        end, {T, {false, false}}, Rules)
    end,
    case Apply(Text) of
        {NewText, {true, false}} -> markov_algorithm(Rules, NewText);
        {NewText, _} -> NewText
    end.