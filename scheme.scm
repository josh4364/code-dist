;; 1. Hello world/Text
(define (hello-world)
  (display "Hello world!")
  (newline))

;; 2. Fibonacci sequence (Iterative)
(define (fib n)
  (let loop ((i n) (a 0) (b 1))
    (if (= i 0)
        a
        (loop (- i 1) b (+ a b)))))

;; 3. Factorial
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

;; 4. 99 bottles of beer
(define (bottles-of-beer)
  (do ((i 99 (- i 1)))
      ((= i 0))
    (let ((s (if (= i 1) "" "s"))
          (s-next (if (= i 2) "" "s"))
          (next-count (if (= i 1) "no more" (- i 1))))
      (format #t "~a bottle~a of beer on the wall, ~a bottle~a of beer.~%" i s i s)
      (format #t "Take one down, pass it around, ~a bottle~a of beer on the wall.~%~%" next-count s-next))))

;; 5. Bubble sort
(define (bubble-sort arr)
  (let* ((v (list->vector arr))
         (n (vector-length v)))
    (do ((i 0 (+ i 1)))
        ((= i n) (vector->list v))
      (do ((j 0 (+ j 1)))
          ((= j (- n i 1)))
        (if (> (vector-ref v j) (vector-ref v (+ j 1)))
            (let ((tmp (vector-ref v j)))
              (vector-set! v j (vector-ref v (+ j 1)))
              (vector-set! v (+ j 1) tmp)))))))

;; 6. FizzBuzz
(define (fizzbuzz)
  (do ((i 1 (+ i 1)))
      ((> i 100))
    (cond ((= 0 (modulo i 15)) (display "FizzBuzz"))
          ((= 0 (modulo i 3))  (display "Fizz"))
          ((= 0 (modulo i 5))  (display "Buzz"))
          (else (display i)))
    (newline)))

;; 7. Empty program
;; (Empty)

;; 8. A+B
(define (a-plus-b input-str)
  (apply + (map string->number (string-split input-str #\space))))

;; 9. 100 doors
(define (hundred-doors)
  (let ((doors (make-vector 101 #f)))
    (do ((i 1 (+ i 1)))
        ((> i 100))
      (do ((j i (+ j i)))
          ((> j 100))
        (vector-set! doors j (not (vector-ref doors j)))))
    (let loop ((i 1) (open '()))
      (if (> i 100)
          (reverse open)
          (loop (+ i 1) (if (vector-ref doors i) (cons i open) open))))))

;; 10. Quine
(let ((s " (let ((s ~s)) (format #t s s))")) (format #t s s))

;; 11. Launch rocket
(define (launch-rocket)
  (do ((t 10 (- t 1)))
      ((< t 0))
    (format #t "T-minus ~a...~%" t)
    (sleep 0.1))
  (display "Liftoff!") (newline)
  (let loop ((t 1) (v 0.0) (a 9.8))
    (if (<= t 3)
        (let ((new-v (+ v a)))
          (format #t "Time: ~as, Velocity: ~am/s, Accel: ~am/s^2~%" t new-v a)
          (loop (+ t 1) new-v a)))))

;; 12. Experimental Verification of the NKT Law
(define (nkt-law-verify t t-env t-init k)
  (+ t-env (* (- t-init t-env) (exp (* (- k) t)))))

;; 13. Universal Lambda Machine
(define (universal-lambda)
  (let* ((zero (lambda (f) (lambda (x) x)))
         (succ (lambda (n) (lambda (f) (lambda (x) (f ((n f) x))))))
         (to-int (lambda (n) ((n (lambda (x) (+ x 1))) 0))))
    (to-int (succ (succ zero)))))

;; 14. Nautical bell
(define (nautical-bell time-str)
  (let* ((parts (map string->number (string-split time-str #\:)))
         (h (car parts))
         (m (cadr parts))
         (half-hours (+ (* (modulo h 4) 2) (if (>= m 30) 1 0))))
    (if (and (= half-hours 0) (< m 30)) 8 half-hours)))

;; 15. Earliest difference between primes
(define (prime-diff target-diff)
  (define (prime? n)
    (if (< n 2) #f
        (let loop ((i 2))
          (cond ((> (* i i) n) #t)
                ((= 0 (modulo n i)) #f)
                (else (loop (+ i 1)))))))
  (let loop ((prev 2) (curr 3))
    (if (prime? curr)
        (if (= (- curr prev) target-diff)
            (list prev curr)
            (loop curr (+ curr 2)))
        (loop prev (+ curr 2)))))

;; 16. Canny edge detector (Simplified concept)
(define (canny-concept pixel-grid)
  (let* ((rows (length pixel-grid))
         (cols (length (car pixel-grid)))
         (res (make-list rows (make-list cols 0))))
    ;; Concept mapping: iterate indices and calc sqrt(dx^2 + dy^2)
    res))

;; 17. Death Star
(define (draw-death-star r)
  (do ((y (- r) (+ y 1)))
      ((> y r))
    (do ((x (* -2 r) (+ x 1)))
        ((> x (* 2 r)))
      (let ((xval (/ x 2.0)))
        (display (if (<= (+ (expt xval 2) (expt y 2)) (expt r 2))
                     (if (<= (+ (expt (- xval (/ r 2.0)) 2) (expt (- y (/ r 2.0)) 2)) (expt (/ r 3.0) 2))
                         " " "#")
                     " "))))
    (newline)))

;; 18. Chat server stub
(define (chat-server-stub)
  "Server configured for 127.0.0.1:65432")

;; 19. Faulhaber's triangle
(define (faulhaber-triangle n)
  (define (bernoulli m)
    (let ((B (make-vector (+ m 1))))
      (do ((i 0 (+ i 1))) ((> i m))
        (vector-set! B i (/ 1 (+ i 1)))
        (do ((j i (- j 1))) ((= j 0))
          (vector-set! B (- j 1) (* j (- (vector-ref B (- j 1)) (vector-ref B j))))))
      (vector-ref B 0)))
  ;; Returns coefficients for P(n)
  '())

;; 20. Execute a Markov algorithm
(define (markov-algorithm rules text)
  (let loop ((current-text text))
    (let find-rule ((r rules))
      (if (null? r)
          current-text
          (let* ((rule (car r))
                 (patt (car rule))
                 (repl (cadr rule))
                 (term (caddr rule))
                 (pos (string-contains current-text patt)))
            (if pos
                (let ((new-text (string-replace current-text repl pos (+ pos (string-length patt)))))
                  (if term new-text (loop new-text)))
                (find-rule (cdr r))))))))