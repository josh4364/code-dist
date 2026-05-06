(ns rosetta-tasks
  (:require [clojure.string :as str]
            [clojure.java.io :as io])
  (:import [java.net ServerSocket Socket]
           [java.util Scanner]))

;; 1. Hello world/Text
(defn hello-world []
  (println "Hello world!"))

;; 2. Fibonacci sequence (Iterative/Recur)
(defn fib [n]
  (loop [i n a 0 b 1]
    (if (zero? i) a (recur (dec i) b (+ a b)))))

;; 3. Factorial
(defn factorial [n]
  (reduce * (range 1 (inc n))))

;; 4. 99 bottles of beer
(defn bottles-of-beer []
  (doseq [i (range 99 0 -1)]
    (let [s (if (= i 1) "" "s")
          next-i (dec i)
          s-next (if (= next-i 1) "" "s")
          next-count (if (pos? next-i) next-i "no more")]
      (printf "%d bottle%s of beer on the wall, %d bottle%s of beer.\n" i s i s)
      (printf "Take one down, pass it around, %s bottle%s of beer on the wall.\n\n" next-count s-next))))

;; 5. Bubble sort
(defn bubble-sort [arr]
  (let [n (count arr)]
    (loop [a (vec arr) i 0]
      (if (= i n)
        a
        (recur (loop [b a j 0]
                 (if (>= j (- n i 1))
                   b
                   (let [v1 (get b j) v2 (get b (inc j))]
                     (recur (if (> v1 v2) (assoc b j v2 (inc j) v1) b) (inc j)))))
               (inc i))))))

;; 6. FizzBuzz
(defn fizzbuzz []
  (doseq [i (range 1 101)]
    (println (cond (zero? (mod i 15)) "FizzBuzz"
                   (zero? (mod i 3))  "Fizz"
                   (zero? (mod i 5))  "Buzz"
                   :else i))))

;; 7. Empty program
;; (Empty file or empty namespace is valid)

;; 8. A+B
(defn a-plus-b [input-str]
  (reduce + (map #(Long/parseLong %) (str/split (str/trim input-str) #"\s+"))))

;; 9. 100 doors
(defn hundred-doors []
  (let [doors (boolean-array 101 false)]
    (doseq [i (range 1 101)
            j (range i 101 i)]
      (aset doors j (not (aget doors j))))
    (keep-indexed #(if %2 %1) (vec doors))))

;; 10. Quine
(defn quine []
  (let [s " (let [s %s] (printf s (pr-str s)))"] (printf s (pr-str s))))

;; 11. Launch rocket
(defn launch-rocket []
  (let [accel 9.8]
    (doseq [t (range 10 -1 -1)]
      (printf "T-minus %d...\n" t)
      (Thread/sleep 100))
    (println "Liftoff!")
    (loop [t 1 velocity 0.0]
      (when (<= t 3)
        (let [v (+ velocity accel)]
          (printf "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n" t v accel)
          (recur (inc t) v))))))

;; 12. Experimental Verification of the NKT Law
(defn nkt-law-verify [t t-env t-init k]
  (+ t-env (* (- t-init t-env) (Math/exp (* -1 k t)))))

;; 13. Universal Lambda Machine
(defn universal-lambda []
  (let [zero (fn [f] (fn [x] x))
        succ (fn [n] (fn [f] (fn [x] (f ((n f) x)))))
        to-int (fn [n] ((n (fn [x] (inc x))) 0))]
    (to-int (succ (succ zero)))))

;; 14. Nautical bell
(defn nautical-bell [time-str]
  (let [[h m] (map #(Integer/parseInt %) (str/split time-str #":"))
        half-hours (+ (* (mod h 4) 2) (if (>= m 30) 1 0))]
    (if (and (zero? half-hours) (< m 30)) 8 half-hours)))

;; 15. Earliest difference between primes
(defn prime-diff [target-diff]
  (let [prime? (fn [n] (and (> n 1) (not-any? #(zero? (mod n %)) (range 2 (inc (int (Math/sqrt n)))))))]
    (loop [prev-prime 2 current 3]
      (if (prime? current)
        (if (= (- current prev-prime) target-diff)
          [prev-prime current]
          (recur current (+ current 2)))
        (recur prev-prime (+ current 2))))))

;; 16. Canny edge detector (Simplified concept)
(defn canny-concept [pixel-grid]
  (let [h (count pixel-grid) w (count (first pixel-grid))]
    (for [y (range 1 (dec h))]
      (for [x (range 1 (dec w))]
        (let [gx (- (get-in pixel-grid [y (inc x)]) (get-in pixel-grid [y (dec x)]))
              gy (- (get-in pixel-grid [(inc y) x]) (get-in pixel-grid [(dec y) x]))]
          (Math/sqrt (+ (* gx gx) (* gy gy))))))))

;; 17. Death Star
(defn draw-death-star [r]
  (doseq [y (range (- r) (inc r))]
    (let [line (for [x (range (* -2 r) (inc (* 2 r)))]
                 (if (<= (+ (Math/pow (/ x 2.0) 2) (Math/pow y 2)) (Math/pow r 2))
                   (if (<= (+ (Math/pow (- (/ x 2.0) (/ r 2.0)) 2) (Math/pow (- y (/ r 2.0)) 2)) (Math/pow (/ r 3.0) 2))
                     " " "#")
                   " "))]
      (println (str/join line)))))

;; 18. Chat server stub
(defn chat-server-stub []
  (let [host "127.0.0.1" port 65432]
    (str "Server configured for " host ":" port)))

;; 19. Faulhaber's triangle
(defn combinations [n k]
  (let [fact (fn [x] (reduce * (range 1 (inc x))))]
    (/ (fact n) (* (fact k) (fact (- n k))))))

(defn bernoulli [m]
  (let [b (atom (vec (for [i (range (inc m))] (/ 1 (inc i)))))]
    (doseq [i (range (inc m)) j (range i 0 -1)]
      (swap! b assoc (dec j) (* j (- (get @b (dec j)) (get @b j)))))
    (first @b)))

(defn faulhaber-triangle [n]
  (for [p (range n)]
    (for [j (range (inc p))]
      (* (/ 1 (inc p)) (combinations (inc p) j) (bernoulli j)))))

;; 20. Execute a Markov algorithm
(defn markov-algorithm [rules text]
  (loop [s text]
    (if-let [[pat repl term] (first (filter #(str/includes? s (first %)) rules))]
      (let [new-s (str/replace-first s pat repl)]
        (if term new-s (recur new-s)))
      s)))