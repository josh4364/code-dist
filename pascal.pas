program RosettaTasks;

{$mode objfpc}{$H+}

uses
  SysUtils, Math, Sockets, DateUtils, Classes;

// 1. Hello world/Text
procedure HelloWorld;
begin
  WriteLn('Hello world!');
end;

// 2. Fibonacci sequence
function Fib(n: Integer): Int64;
var
  a, b, temp: Int64;
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
function Factorial(n: Integer): Int64;
var
  i: Integer;
begin
  Result := 1;
  for i := 2 to n do Result := Result * i;
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
    
    WriteLn(Format('%d bottle%s of beer on the wall, %d bottle%s of beer.', [i, s, i, s]));
    WriteLn(Format('Take one down, pass it around, %s bottle%s of beer on the wall.', [nextCount, sNext]));
    WriteLn;
  end;
end;

// 5. Bubble sort
type TIntArray = array of Integer;
procedure BubbleSort(var arr: TIntArray);
var
  i, j, temp, n: Integer;
begin
  n := Length(arr);
  for i := 0 to n - 1 do
    for j := 0 to n - i - 2 do
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
    if i mod 15 = 0 then WriteLn('FizzBuzz')
    else if i mod 3 = 0 then WriteLn('Fizz')
    else if i mod 5 = 0 then WriteLn('Buzz')
    else WriteLn(i);
  end;
end;

// 7. Empty program
procedure EmptyProgram;
begin
  // pass
end;

// 8. A+B
function APlusB(inputStr: string): Integer;
var
  list: TStringList;
  i: Integer;
begin
  Result := 0;
  list := TStringList.Create;
  list.Delimiter := ' ';
  list.DelimitedText := inputStr;
  for i := 0 to list.Count - 1 do
    Result := Result + StrToIntDef(list[i], 0);
  list.Free;
end;

// 9. 100 doors
procedure HundredDoors;
var
  doors: array[1..100] of Boolean;
  i, j: Integer;
begin
  FillChar(doors, SizeOf(doors), False);
  for i := 1 to 100 do
    for j := 1 to 100 do
      if j mod i = 0 then doors[j] := not doors[j];
  for i := 1 to 100 do
    if doors[i] then Write(i, ' ');
  WriteLn;
end;

// 10. Quine
procedure Quine;
const s = 'const s = %r; begin Write(Format(s, [s])); end.';
begin
  // Standard Pascal Quine is usually done via a const string or file read
  Write(Format('program Quine; const s = %s%s%s; begin Write(Format(s, [QuotedStr(s)])); end.', [#39, s, #39]));
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
    WriteLn('T-minus ', t, '...');
    Sleep(100);
  end;
  WriteLn('Liftoff!');
  for t := 1 to 3 do
  begin
    velocity := velocity + accel;
    WriteLn(Format('Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2', [t, velocity, accel]));
  end;
end;

// 12. NKT Law
function NKTLawVerify(t, tEnv, tInit, k: Double): Double;
begin
  Result := tEnv + (tInit - tEnv) * Exp(-k * t);
end;

// 13. Universal Lambda Machine
type TLambda = function(f: Pointer): Pointer; // Simplified placeholder for conceptual match
function UniversalLambdaStub: Integer;
begin
  // Pascal is statically typed; Church encoding requires complex generics or variant types.
  Result := 2; 
end;

// 14. Nautical bell
function NauticalBell(timeStr: string): Integer;
var
  h, m, halfHours: Integer;
begin
  h := StrToInt(Copy(timeStr, 1, 2));
  m := StrToInt(Copy(timeStr, 4, 2));
  halfHours := (h mod 4) * 2 + (IfThen(m >= 30, 1, 0));
  if (halfHours = 0) and (m < 30) then Result := 8 else Result := halfHours;
end;

// 15. Earliest difference between primes
function IsPrime(n: Integer): Boolean;
var i: Integer;
begin
  if n < 2 then Exit(False);
  for i := 2 to Trunc(Sqrt(n)) do if n mod i = 0 then Exit(False);
  Result := True;
end;

procedure PrimeDiff(target: Integer);
var prev, curr: Integer;
begin
  prev := 2; curr := 3;
  while True do begin
    if IsPrime(curr) then begin
      if curr - prev = target then begin
        WriteLn('Pair: ', prev, ', ', curr);
        Break;
      end;
      prev := curr;
    end;
    curr := curr + 2;
  end;
end;

// 16. Canny edge detector (Mock)
procedure CannyConcept(grid: array of array of Double);
var x, y: Integer; gradX, gradY: Double;
begin
  // Concept only
  for y := 1 to High(grid)-1 do
    for x := 1 to High(grid[0])-1 do begin
      gradX := grid[y][x+1] - grid[y][x-1];
      gradY := grid[y+1][x] - grid[y-1][x];
      // Store Sqrt(gradX**2 + gradY**2)
    end;
end;

// 17. Death Star
procedure DrawDeathStar(r: Integer);
var x, y: Integer; line: string;
begin
  for y := -r to r do begin
    line := '';
    for x := Round(-2.0 * r) to Round(2.0 * r) do begin
      if Sqr(x/2) + Sqr(y) <= Sqr(r) then begin
        if Sqr((x/2)-r/2) + Sqr(y-r/2) <= Sqr(r/3) then line := line + ' '
        else line := line + '#';
      end else line := line + ' ';
    end;
    WriteLn(line);
  end;
end;

// 18. Chat server
procedure ChatServerStub;
var host: string; port: Word;
begin
  host := '127.0.0.1'; port := 65432;
  WriteLn('Server configured for ', host, ':', port);
end;

// 19. Faulhaber's triangle
procedure FaulhaberStub;
begin
  // Requires BigInt/Fractions for precision; stubbing logic
  WriteLn('Faulhaber triangle logic initialized.');
end;

// 20. Markov algorithm
function MarkovAlgorithm(rules: TStringList; text: string): string;
var i: Integer; applied: Boolean; line, pat, rep: string;
begin
  while True do begin
    applied := False;
    for i := 0 to rules.Count - 1 do begin
      line := rules[i]; // Assuming format "pat->rep"
      pat := Copy(line, 1, Pos('->', line)-1);
      rep := Copy(line, Pos('->', line)+2, MaxInt);
      if Pos(pat, text) > 0 then begin
        text := StringReplace(text, pat, rep, []);
        applied := True; Break;
      end;
    end;
    if not applied then Break;
  end;
  Result := text;
end;

begin
  HelloWorld;
end.