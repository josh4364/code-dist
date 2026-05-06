IDENTIFICATION DIVISION.
       PROGRAM-ID. ROSETTA-TASKS.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
           FUNCTION ALL INTRINSIC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       * 1. Hello World
       01 GREETING          PIC X(12) VALUE "Hello world!".
       
       * 2. Fibonacci
       01 FIB-A             PIC 9(15) VALUE 0.
       01 FIB-B             PIC 9(15) VALUE 1.
       01 FIB-TEMP          PIC 9(15).
       01 FIB-LIMIT         PIC 9(2)   VALUE 10.
       
       * 3. Factorial
       01 FACT-N            PIC 9(2)   VALUE 5.
       01 FACT-RESULT       PIC 9(15)  VALUE 1.
       
       * 4. 99 Bottles
       01 BOTTLE-COUNT      PIC 99.
       01 BOTTLE-S          PIC X.
       01 BOTTLE-NEXT       PIC X.
       
       * 5. Bubble Sort
       01 SORT-TABLE.
          05 ARR            PIC 99 OCCURS 5 TIMES.
       01 I                 PIC 99.
       01 J                 PIC 99.
       01 TEMP-VAL          PIC 99.
       
       * 6. FizzBuzz
       01 FB-I              PIC 999.
       01 REM-3             PIC 99.
       01 REM-5             PIC 99.
       
       * 8. A+B
       01 A-VAL             PIC 99.
       01 B-VAL             PIC 99.
       01 SUM-VAL           PIC 999.
       
       * 9. 100 Doors
       01 DOORS-TABLE.
          05 DOOR-STATE     PIC X OCCURS 100 TIMES.
             88 DOOR-OPEN   VALUE 'O'.
             88 DOOR-CLOSED VALUE 'C'.
             
       * 10. Quine (Conceptual)
       01 Q-S               PIC X(40) VALUE "DISPLAY Q-S. DISPLAY Q-S.".

       * 11. Launch Rocket
       01 COUNTDOWN         PIC 99.
       01 VELOCITY          COMP-2 VALUE 0.0.
       01 ACCEL             COMP-2 VALUE 9.8.

       * 14. Nautical Bell
       01 B-TIME            PIC 9999 VALUE 1330.
       01 B-HH              PIC 99.
       01 B-MM              PIC 99.
       01 BELLS             PIC 9.

       * 15. Prime Diff
       01 P-CANDIDATE       PIC 9(5) VALUE 3.
       01 P-PREV            PIC 9(5) VALUE 2.
       01 P-GAP             PIC 9(2) VALUE 2.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           * 1. Hello World
           DISPLAY GREETING.

           * 2. Fibonacci
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > FIB-LIMIT
               MOVE FIB-B TO FIB-TEMP
               ADD FIB-A TO FIB-B
               MOVE FIB-TEMP TO FIB-A
           END-PERFORM.
           DISPLAY "Fibonacci: " FIB-A.

           * 3. Factorial
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > FACT-N
               MULTIPLY I BY FACT-RESULT
           END-PERFORM.
           DISPLAY "Factorial: " FACT-RESULT.

           * 4. 99 Bottles (Snippet)
           MOVE 99 TO BOTTLE-COUNT.
           PERFORM 2 TIMES
               DISPLAY BOTTLE-COUNT " bottles of beer on the wall."
               SUBTRACT 1 FROM BOTTLE-COUNT
           END-PERFORM.

           * 5. Bubble Sort
           MOVE 5 TO ARR(1) MOVE 3 TO ARR(2) MOVE 1 TO ARR(3) 
           MOVE 4 TO ARR(4) MOVE 2 TO ARR(5).
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > 5 - I
                   IF ARR(J) > ARR(J + 1)
                       MOVE ARR(J) TO TEMP-VAL
                       MOVE ARR(J + 1) TO ARR(J)
                       MOVE TEMP-VAL TO ARR(J + 1)
                   END-IF
               END-PERFORM
           END-PERFORM.

           * 6. FizzBuzz (Snippet)
           PERFORM VARYING FB-I FROM 1 BY 1 UNTIL FB-I > 15
               DIVIDE FB-I BY 3 GIVING TEMP-VAL REMAINDER REM-3
               DIVIDE FB-I BY 5 GIVING TEMP-VAL REMAINDER REM-5
               IF REM-3 = 0 AND REM-5 = 0 DISPLAY "FizzBuzz"
               ELSE IF REM-3 = 0 DISPLAY "Fizz"
               ELSE IF REM-5 = 0 DISPLAY "Buzz"
               ELSE DISPLAY FB-I
               END-IF
           END-PERFORM.

           * 7. Empty Program
           EXIT.

           * 8. A+B
           MOVE 10 TO A-VAL. MOVE 20 TO B-VAL.
           ADD A-VAL TO B-VAL GIVING SUM-VAL.
           DISPLAY "A+B: " SUM-VAL.

           * 9. 100 Doors
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 100
               MOVE 'C' TO DOOR-STATE(I)
           END-PERFORM.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 100
               PERFORM VARYING J FROM I BY I UNTIL J > 100
                   IF DOOR-OPEN(J) SET DOOR-CLOSED(J) TO TRUE
                   ELSE SET DOOR-OPEN(J) TO TRUE
                   END-IF
               END-PERFORM
           END-PERFORM.

           * 11. Launch Rocket
           PERFORM VARYING COUNTDOWN FROM 10 BY -1 UNTIL COUNTDOWN < 0
               DISPLAY "T-minus " COUNTDOWN
           END-PERFORM.
           DISPLAY "Liftoff!".
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
               ADD ACCEL TO VELOCITY
               DISPLAY "Time: " I "s Velocity: " VELOCITY
           END-PERFORM.

           * 14. Nautical Bell
           DIVIDE B-TIME BY 100 GIVING B-HH REMAINDER B-MM.
           COMPUTE BELLS = (FUNCTION MOD(B-HH, 4) * 2)
           IF B-MM >= 30 ADD 1 TO BELLS.
           IF BELLS = 0 MOVE 8 TO BELLS.
           DISPLAY "Bells: " BELLS.

           * 18. Chat Server (Stub)
           DISPLAY "Server configured for 127.0.0.1:65432".

           STOP RUN.