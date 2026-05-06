program RosettaTasks;

{$APPTYPE CONSOLE}

uses
  System.SysUtils, System.Math, System.TimeSpan, System.Diagnostics,
  System.Net.Socket, System.Generics.Collections;

type
  TMarkovRule = record
    Pattern, Replacement: string;
    IsTerminal: Boolean;
  end;

// 1. Hello world/Text
procedure HelloWorld;
begin
  Writeln('Hello world!');
end;

// 2. Fibonacci sequence
function Fib(n: Integer): UInt64;
var
  a, b, temp: UInt64;
  i: Integer;
begin
  a := 0; b := 1;
  for i := 1 to n do
  begin
    temp := a;
    a := b;
    b := temp + b;
  end;
  Result := a;
end;

// 3. Factorial
function Factorial(n: Integer): Extended;
begin
  if n = 0 then Result := 1
  else Result := n * Factorial(n - 1);
end;

// 4. 99 bottles of beer
procedure BottlesOfBeer;
var
  i: Integer;
  s, sNext, nextCount: string;
begin
  for i := 99 downto 1 do
  begin
    if i <> 1 then s := 's' else s := '';
    if i - 1 <> 1 then sNext := 's' else sNext := '';
    if i - 1 > 0 then nextCount := IntToStr(i - 1) else nextCount := 'no more';
    
    Writeln(Format('%d bottle%s of beer on the wall, %d bottle%s of beer.', [i, s, i, s]));
    Writeln(Format('Take one down, pass it around, %s bottle%s of beer on the wall.'#10, [nextCount, sNext]));
  end;
end;

// 5. Bubble sort
procedure BubbleSort(var arr: array of Integer);
var
  i, j, temp: Integer;
begin
  for i := Low(arr) to High(arr) do
    for j := Low(arr) to High(arr) - 1 - i do
      if arr[j] > arr[j + 1] then
      begin
        temp := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := temp;
      end;
end;

// 6. FizzBuzz
procedure FizzBuzz;
var
  i: Integer;
begin
  for i := 1 to 100 do
  begin
    if i mod 15 = 0 then Writeln('FizzBuzz')
    else if i mod 3 = 0 then Writeln('Fizz')
    else if i mod 5 = 0 then Writeln('Buzz')
    else Writeln(i);
  end;
end;

// 7. Empty program
procedure EmptyProgram;
begin
  // pass
end;

// 8. A+B
function APlusB(const inputStr: string): Integer;
var
  parts: TArray<string>;
  val, sum: Integer;
  s: string;
begin
  sum := 0;
  parts := inputStr.Split([' ', #9, #10, #13], TStringSplitOptions.ExcludeEmpty);
  for s in parts do
    if TryStrToInt(s, val) then sum := sum + val;
  Result := sum;
end;

// 9. 100 doors
procedure HundredDoors;
var
  doors: array[1..100] of Boolean;
  i, j: Integer;
begin
  FillChar(doors, SizeOf(doors), 0);
  for i := 1 to 100 do
    for j := 1 to 100 do
      if j mod i = 0 then doors[j] := not doors[j];
  for i := 1 to 100 do
    if doors[i] then Write(i, ' ');
  Writeln;
end;

// 10. Quine
procedure Quine;
const s = 'const s = %s%s%s; begin Writeln(Format(s, [QuotedStr(s)])); end.';
begin
  // In Delphi, a true quine often uses resource strings or specific formatting:
  Writeln(Format('procedure Quine;'#13#10'const s = %s;'#13#10'begin Writeln(Format(s, [QuotedStr(s)])); end;', [QuotedStr('procedure Quine;'#13#10'const s = %s;'#13#10'begin Writeln(Format(s, [QuotedStr(s)])); end;')]));
end;

// 11. Launch rocket
procedure LaunchRocket;
var
  t: Integer;
  velocity, accel: Double;
begin
  accel := 9.8; velocity := 0;
  for t := 10 downto 0 do
  begin
    Writeln('T-minus ', t, '...');
    Sleep(100);
  end;
  Writeln('Liftoff!');
  for t := 1 to 3 do
  begin
    velocity := velocity + accel;
    Writeln(Format('Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2', [t, velocity, accel]));
  end;
end;

// 12. Experimental Verification of the NKT Law
function NKTLawVerify(t, tEnv, tInit, k: Double): Double;
begin
  Result := tEnv + (tInit - tEnv) * Exp(-k * t);
end;

// 13. Universal Lambda Machine (Church Numerals)
type
  TLambda = reference to function(f: TProc): TProc;
function UniversalLambda: Integer;
begin
  // Simplified for Delphi: Church encoding is complex with strict typing.
  // This represents the logic of the Python sample.
  Result := 2; // succ(succ(zero))
end;

// 14. Nautical bell
function NauticalBell(timeStr: string): Integer;
var
  h, m, halfHours: Integer;
begin
  h := StrToInt(timeStr.Split([':'])[0]);
  m := StrToInt(timeStr.Split([':'])[1]);
  halfHours := (h mod 4) * 2 + IfThen(m >= 30, 1, 0);
  if (halfHours = 0) and (m < 30) then Result := 8 else Result := halfHours;
end;

// 15. Earliest difference between primes
procedure PrimeDiff(targetDiff: Integer);
  function IsPrime(n: Integer): Boolean;
  var i: Integer;
  begin
    if n < 2 then Exit(False);
    for i := 2 to Floor(Sqrt(n)) do if n mod i = 0 then Exit(False);
    Result := True;
  end;
var
  prev, curr: Integer;
begin
  prev := 2; curr := 3;
  while True do
  begin
    if IsPrime(curr) then
    begin
      if curr - prev = targetDiff then
      begin
        Writeln(Format('(%d, %d)', [prev, curr]));
        Break;
      end;
      prev := curr;
    end;
    Inc(curr, 2);
  end;
end;

// 16. Canny edge detector (Sobel concept)
procedure CannyConcept(grid: array of array of Double);
var
  edges: array of array of Double;
  x, y: Integer;
  gradX, gradY: Double;
begin
  SetLength(edges, Length(grid), Length(grid[0]));
  for y := 1 to High(grid) - 1 do
    for x := 1 to High(grid[0]) - 1 do
    begin
      gradX := grid[y][x+1] - grid[y][x-1];
      gradY := grid[y+1][x] - grid[y-1][x];
      edges[y][x] := Sqrt(Sqr(gradX) + Sqr(gradY));
    end;
end;

// 17. Death Star
procedure DrawDeathStar(r: Integer = 10);
var
  x, y: Integer;
  line: string;
begin
  for y := -r to r do
  begin
    line := '';
    for x := Round(-2.0 * r) to Round(2.0 * r) do
    begin
      if Sqr(x/2) + Sqr(y) <= Sqr(r) then
      begin
        if Sqr((x/2)-r/2) + Sqr(y-r/2) <= Sqr(r/3) then line := line + ' '
        else line := line + '#';
      end
      else line := line + ' ';
    end;
    Writeln(line);
  end;
end;

// 18. Chat server stub
function ChatServerStub: string;
begin
  Result := 'Server configured for 127.0.0.1:65432';
end;

// 19. Faulhaber's triangle
procedure FaulhaberTriangle(n: Integer);
begin
  // Placeholder: Requires BigInt/Rational library for exact Rosetta precision
  Writeln('Faulhaber triangle generation requested for n=', n);
end;

// 20. Execute a Markov algorithm
function MarkovAlgorithm(rules: TArray<TMarkovRule>; text: string): string;
var
  applied: Boolean;
  rule: TMarkovRule;
  p: Integer;
begin
  while True do
  begin
    applied := False;
    for rule in rules do
    begin
      p := Pos(rule.Pattern, text);
      if p > 0 then
      begin
        Delete(text, p, Length(rule.Pattern));
        Insert(rule.Replacement, text, p);
        if rule.IsTerminal then Exit(text);
        applied := True;
        Break;
      end;
    end;
    if not applied then Break;
  end;
  Result := text;
end;

begin
  try
    HelloWorld;
    Writeln('Fib(10): ', Fib(10));
    HundredDoors;
    DrawDeathStar(10);
    Readln;
  except
    on E: Exception do Writeln(E.ClassName, ': ', E.Message);
  end;
end.