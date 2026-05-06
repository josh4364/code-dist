Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Net
Imports System.Net.Sockets
Imports System.Threading

Module RosettaTasks
    ' 1. Hello world/Text
    Sub HelloWorld()
        Console.WriteLine("Hello world!")
    End Sub

    ' 2. Fibonacci sequence
    Function Fib(n As Integer) As Long
        Dim a As Long = 0, b As Long = 1
        For i As Integer = 1 To n
            Dim temp As Long = a
            a = b
            b = temp + b
        Next
        Return a
    End Function

    ' 3. Factorial
    Function Factorial(n As Integer) As Long
        If n <= 1 Then Return 1
        Dim result As Long = 1
        For i As Integer = 2 To n
            result *= i
        Next
        Return result
    End Function

    ' 4. 99 bottles of beer
    Sub BottlesOfBeer()
        For i As Integer = 99 To 1 Step -1
            Dim s As String = If(i <> 1, "s", "")
            Dim s_next As String = If(i - 1 <> 1, "s", "")
            Dim next_count As String = If(i - 1 > 0, (i - 1).ToString(), "no more")
            Console.WriteLine($"{i} bottle{s} of beer on the wall, {i} bottle{s} of beer.")
            Console.WriteLine($"Take one down, pass it around, {next_count} bottle{s_next} of beer on the wall." & vbCrLf)
        Next
    End Sub

    ' 5. Bubble sort
    Function BubbleSort(arr As Integer()) As Integer()
        Dim n As Integer = arr.Length
        For i As Integer = 0 To n - 1
            For j As Integer = 0 To n - i - 2
                If arr(j) > arr(j + 1) Then
                    Dim temp As Integer = arr(j)
                    arr(j) = arr(j + 1)
                    arr(j + 1) = temp
                End If
            Next
        Next
        Return arr
    End Function

    ' 6. FizzBuzz
    Sub FizzBuzz()
        For i As Integer = 1 To 100
            If i Mod 15 = 0 Then Console.WriteLine("FizzBuzz") _
            Else If i Mod 3 = 0 Then Console.WriteLine("Fizz") _
            Else If i Mod 5 = 0 Then Console.WriteLine("Buzz") _
            Else Console.WriteLine(i)
        Next
    End Sub

    ' 7. Empty program
    Sub Main()
        ' Entry point
    End Sub

    ' 8. A+B
    Function APlusB(inputStr As String) As Integer
        Return inputStr.Split(New Char() {" "c, ControlChars.Tab}, StringSplitOptions.RemoveEmptyEntries).Sum(Function(x) Integer.Parse(x))
    End Function

    ' 9. 100 doors
    Function HundredDoors() As List(Of Integer)
        Dim doors(100) As Boolean
        For i As Integer = 1 To 100
            For j As Integer = i To 100 Step i
                doors(j) = Not doors(j)
            Next
        Next
        Dim openDoors As New List(Of Integer)
        For i As Integer = 1 To 100
            If doors(i) Then openDoors.Add(i)
        Next
        Return openDoors
    End Function

    ' 10. Quine
    Sub Quine()
        Dim s As String = "Module Quine{0}    Sub Main(){0}        Dim s As String = {1}{2}{1}{0}        Console.Write(s, vbCrLf, Chr(34), s){0}    End Sub{0}End Module"
        Console.Write(s, vbCrLf, Chr(34), s)
    End Sub

    ' 11. Launch rocket
    Sub LaunchRocket()
        Dim accel As Double = 9.8
        Dim velocity As Double = 0
        For t As Integer = 10 To 0 Step -1
            Console.WriteLine($"T-minus {t}...")
            Thread.Sleep(100)
        Next
        Console.WriteLine("Liftoff!")
        For t As Integer = 1 To 3
            velocity += accel
            Console.WriteLine($"Time: {t}s, Velocity: {velocity:F1}m/s, Accel: {accel}m/s^2")
        Next
    End Sub

    ' 12. Experimental Verification of the NKT Law
    Function NktLawVerify(t As Double, tEnv As Double, tInit As Double, k As Double) As Double
        Return tEnv + (tInit - tEnv) * Math.Exp(-k * t)
    End Function

    ' 13. Universal Lambda Machine
    Delegate Function Lambda(f As Func(Of Object, Object)) As Func(Of Object, Object)
    Function UniversalLambda() As Integer
        Dim zero As Lambda = Function(f) Function(x) x
        Dim succ As Func(Of Lambda, Lambda) = Function(n) Function(f) Function(x) f(n(f)(x))
        Dim toInt As Func(Of Lambda, Integer) = Function(n) CInt(n(Function(x) CInt(x) + 1)(0))
        Return toInt(succ(succ(zero)))
    End Function

    ' 14. Nautical bell
    Function NauticalBell(timeStr As String) As Integer
        Dim parts = timeStr.Split(":"c)
        Dim h As Integer = Integer.Parse(parts(0))
        Dim m As Integer = Integer.Parse(parts(1))
        Dim halfHours As Integer = (h Mod 4) * 2 + If(m >= 30, 1, 0)
        Return If(halfHours = 0 And m < 30, 8, halfHours)
    End Function

    ' 15. Earliest difference between primes
    Function PrimeDiff(targetDiff As Integer) As Integer()
        Dim IsPrime = Function(n As Integer) As Boolean
                          If n < 2 Then Return False
                          For i As Integer = 2 To CInt(Math.Sqrt(n))
                              If n Mod i = 0 Then Return False
                          Next
                          Return True
                      End Function
        Dim prevPrime As Integer = 2
        Dim current As Integer = 3
        While True
            If IsPrime(current) Then
                If current - prevPrime = targetDiff Then Return New Integer() {prevPrime, current}
                prevPrime = current
            End If
            current += 2
        End While
    End Function

    ' 16. Canny edge detector (Simplified concept)
    Function CannyConcept(pixelGrid As Double(,)) As Double(,)
        Dim rows As Integer = pixelGrid.GetLength(0)
        Dim cols As Integer = pixelGrid.GetLength(1)
        Dim edges(rows - 1, cols - 1) As Double
        For y As Integer = 1 To rows - 2
            For x As Integer = 1 To cols - 2
                Dim gradX As Double = pixelGrid(y, x + 1) - pixelGrid(y, x - 1)
                Dim gradY As Double = pixelGrid(y + 1, x) - pixelGrid(y - 1, x)
                edges(y, x) = Math.Sqrt(gradX ^ 2 + gradY ^ 2)
            Next
        Next
        Return edges
    End Function

    ' 17. Death Star
    Sub DrawDeathStar(Optional r As Integer = 10)
        For y As Integer = -r To r
            Dim line As String = ""
            For x As Integer = CInt(-2.0 * r) To CInt(2.0 * r)
                If (x / 2.0) ^ 2 + y ^ 2 <= r ^ 2 Then
                    If ((x / 2.0) - r / 2.0) ^ 2 + (y - r / 2.0) ^ 2 <= (r / 3.0) ^ 2 Then
                        line &= " "
                    Else
                        line &= "#"
                    End If
                Else
                    line &= " "
                End If
            Next
            Console.WriteLine(line)
        Next
    End Sub

    ' 18. Chat server
    Function ChatServerStub() As String
        Dim host As String = "127.0.0.1"
        Dim port As Integer = 65432
        ' Stub logic: Visual Basic uses TcpListener for this pattern
        Dim server As New TcpListener(IPAddress.Parse(host), port)
        Return $"Server configured for {host}:{port}"
    End Function

    ' 19. Faulhaber's triangle
    Function FaulhaberTriangle(n As Integer) As List(Of List(Of Double))
        ' Bernoulli using basic double for simplicity (equivalent to generic fraction logic)
        Dim Bernoulli = Function(m As Integer) As Double
                            Dim B(m) As Double
                            For i As Integer = 0 To m
                                B(i) = 1.0 / (i + 1)
                                For j As Integer = i To 1 Step -1
                                    B(j - 1) = j * (B(j - 1) - B(j))
                                Next
                            Next
                            Return B(0)
                        End Function
        Dim Comb = Function(nk As Integer, k As Integer) As Double
                       Dim res As Double = 1
                       For i As Integer = 1 To k
                           res = res * (nk - k + i) / i
                       Next
                       Return res
                   End Function
        Dim triangle As New List(Of List(Of Double))
        For p As Integer = 0 To n - 1
            Dim row As New List(Of Double)
            For j As Integer = 0 To p
                Dim val As Double = (1.0 / (p + 1)) * Comb(p + 1, j) * Bernoulli(j)
                row.Add(val)
            Next
            triangle.Add(row)
        Next
        Return triangle
    End Function

    ' 20. Execute a Markov algorithm
    Function MarkovAlgorithm(rules As List(Of Tuple(Of String, String, Boolean)), text As String) As String
        Do
            Dim applied As Boolean = False
            For Each rule In rules
                If text.Contains(rule.Item1) Then
                    Dim index As Integer = text.IndexOf(rule.Item1)
                    text = text.Remove(index, rule.Item1.Length).Insert(index, rule.Item2)
                    If rule.Item3 Then Return text
                    applied = True
                    Exit For
                End If
            Next
            If Not applied Then Exit Do
        Loop
        Return text
    End Function
End Module