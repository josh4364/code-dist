;; 1. Hello world/Text
(defun hello-world ()
  (format t "Hello world!~%"))

;; 2. Fibonacci sequence (Iterative)
(defun fib (n)
  (loop repeat n
        for a = 0 then b
        and b = 1 then (+ a b)
        finally (return a)))

;; 3. Factorial
(defun factorial (n)
  (if (= n 0) 1
      (loop for i from 1 to n collect i into nums
            finally (return (reduce #'* nums)))))

;; 4. 99 bottles of beer
(defun bottles-of-beer ()
  (loop for i from 99 downto 1
        for s = (if (= i 1) "" "s")
        for next-i = (1- i)
        for s-next = (if (= next-i 1) "" "s")
        for next-count = (if (> next-i 0) next-i "no more")
        do (format t "~A bottle~A of beer on the wall, ~A bottle~A of beer.~%" i s i s)
           (format t "Take one down, pass it around, ~A bottle~A of beer on the wall.~%~%" next-count s-next)))

;; 5. Bubble sort
(defun bubble-sort (arr)
  (let ((n (length arr)))
    (loop for i from 0 to (1- n) do
      (loop for j from 0 to (- n i 2) do
        (when (> (elt arr j) (elt arr (1+ j)))
          (rotatef (elt arr j) (elt arr (1+ j))))))
    arr))

;; 6. FizzBuzz
(defun fizzbuzz ()
  (loop for i from 1 to 100 do
    (cond ((zerop (mod i 15)) (format t "FizzBuzz~%"))
          ((zerop (mod i 3))  (format t "Fizz~%"))
          ((zerop (mod i 5))  (format t "Buzz~%"))
          (t (format t "~A~%" i)))))

;; 7. Empty program
;; (Empty file is a valid Common Lisp program)

;; 8. A+B
(defun a-plus-b (input-str)
  (with-input-from-string (s input-str)
    (loop for val = (read s nil nil)
          while val sum val)))

;; 9. 100 doors
(defun hundred-doors ()
  (let ((doors (make-array 101 :initial-element nil)))
    (loop for i from 1 to 100 do
      (loop for j from i to 100 by i do
        (setf (aref doors j) (not (aref doors j)))))
    (loop for i from 1 to 100 when (aref doors i) collect i)))

;; 10. Quine
(let ((s "(let ((s ~S)) (format t s s))")) (format t s s))

;; 11. Launch rocket
(defun launch-rocket ()
  (let ((accel 9.8)
        (velocity 0.0))
    (loop for t-count from 10 downto 0 do
      (format t "T-minus ~A...~%" t-count)
      (sleep 0.1))
    (format t "Liftoff!~%")
    (loop for time from 1 to 3 do
      (incf velocity accel)
      (format t "Time: ~As, Velocity: ~,1fm/s, Accel: ~Am/s^2~%" time velocity accel))))

;; 12. Experimental Verification of the NKT Law
(defun nkt-law-verify (time t-env t-init k)
  (+ t-env (* (- t-init t-env) (exp (* (- k) time)))))

;; 13. Universal Lambda Machine (Church Numerals)
(defun universal-lambda ()
  (let* ((zero (lambda (f) (lambda (x) x)))
         (succ (lambda (n) (lambda (f) (lambda (x) (funcall f (funcall (funcall n f) x))))))
         (to-int (lambda (n) (funcall (funcall n (lambda (x) (1+ x))) 0))))
    (funcall to-int (funcall succ (funcall succ zero)))))

;; 14. Nautical bell
(defun nautical-bell (time-str)
  (let* ((h (parse-integer (subseq time-str 0 2)))
         (m (parse-integer (subseq time-str 3 5)))
         (half-hours (+ (* (mod h 4) 2) (if (>= m 30) 1 0))))
    (if (and (zerop half-hours) (< m 30)) 8 half-hours)))

;; 15. Earliest difference between primes
(defun prime-diff (target-diff)
  (labels ((is-prime (n)
             (if (< n 2) nil
                 (loop for i from 2 to (floor (sqrt n))
                       never (zerop (mod n i))))))
    (loop with prev-prime = 2
          for current from 3 by 2
          when (is-prime current)
          do (if (= (- current prev-prime) target-diff)
                 (return (list prev-prime current))
                 (setf prev-prime current)))))

;; 16. Canny edge detector (Simplified concept)
(defun canny-concept (pixel-grid)
  (let* ((rows (length pixel-grid))
         (cols (length (first pixel-grid)))
         (edges (loop repeat rows collect (make-array cols :initial-element 0.0))))
    (loop for y from 1 to (- rows 2) do
      (loop for x from 1 to (- cols 2) do
        (let* ((grad-x (- (nth (1+ x) (nth y pixel-grid)) (nth (1- x) (nth y pixel-grid))))
               (grad-y (- (nth x (nth (1+ y) pixel-grid)) (nth x (nth (1- y) pixel-grid)))))
          (setf (elt (nth y edges) x) (sqrt (+ (expt grad-x 2) (expt grad-y 2)))))))
    edges))

;; 17. Death Star
(defun draw-death-star (&optional (r 10))
  (loop for y from (- r) to r do
    (loop for x from (floor (* -2.0 r)) to (floor (* 2.0 r)) do
      (cond ((<= (+ (expt (/ x 2.0) 2) (expt y 2)) (expt r 2))
             (if (<= (+ (expt (- (/ x 2.0) (/ r 2.0)) 2) (expt (- y (/ r 2.0)) 2)) (expt (/ r 3.0) 2))
                 (format t " ")
                 (format t "#")))
            (t (format t " "))))
    (format t "~%")))

;; 18. Chat server stub
(defun chat-server-stub ()
  (let ((host "127.0.0.1")
        (port 65432))
    (format nil "Server configured for ~A:~A" host port)))

;; 19. Faulhaber's triangle
(defun faulhaber-triangle (n)
  (labels ((comb (n k)
             (if (or (zerop k) (= n k)) 1
                 (/ (factorial n) (* (factorial k) (factorial (- n k))))))
           (bernoulli (m)
             (let ((B (make-array (1+ m))))
               (loop for i from 0 to m do
                 (setf (aref B i) (/ 1 (1+ i)))
                 (loop for j from i downto 1 do
                   (setf (aref B (1- j)) (* j (- (aref B (1- j)) (aref B j))))))
               (aref B 0))))
    (loop for p from 0 to (1- n) collect
      (loop for j from 0 to p collect
        (* (/ 1 (1+ p)) (comb (1+ p) j) (bernoulli j))))))

;; 20. Execute a Markov algorithm
(defun markov-algorithm (rules text)
  (loop
    (let ((applied nil))
      (loop for (pattern replacement terminal) in rules do
        (let ((pos (search pattern text)))
          (when pos
            (setf text (concatenate 'string (subseq text 0 pos) replacement (subseq text (+ pos (length pattern)))))
            (if terminal (return-from markov-algorithm text))
            (setf applied t)
            (return))))
      (unless applied (return text)))))