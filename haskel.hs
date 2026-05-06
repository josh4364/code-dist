import Data.List (foldl', sort, isInfixOf)
import Data.Time.Clock
import Control.Concurrent (threadDelay)
import Text.Printf (printf)
import Data.Ratio (Ratio, (%))
import Control.Monad (forM_)

-- 1. Hello world/Text
helloWorld :: IO ()
helloWorld = putStrLn "Hello world!"

-- 2. Fibonacci sequence (Iterative-style via zipWith)
fib :: Int -> Integer
fib n = fibs !! n
  where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- 3. Factorial
factorial :: Integer -> Integer
factorial n = product [1..n]

-- 4. 99 bottles of beer
bottlesOfBeer :: IO ()
bottlesOfBeer = mapM_ (putStr . verse) [99, 98 .. 1]
  where
    verse i = printf "%d bottle%s of beer on the wall, %d bottle%s of beer.\n\
                     \Take one down, pass it around, %s bottle%s of beer on the wall.\n\n"
                     i (s i) i (s i) (next i) (s (i-1))
    s n = if n == 1 then "" else "s"
    next n = if n - 1 > 0 then show (n - 1) else "no more"

-- 5. Bubble sort
bubbleSort :: (Ord a) => [a] -> [a]
bubbleSort [] = []
bubbleSort xs = iterate bubbleStep xs !! length xs
  where
    bubbleStep (x:y:zs)
      | x > y     = y : bubbleStep (x:zs)
      | otherwise = x : bubbleStep (y:zs)
    bubbleStep xs = xs

-- 6. FizzBuzz
fizzBuzz :: IO ()
fizzBuzz = mapM_ (putStrLn . check) [1..100]
  where
    check n | n `mod` 15 == 0 = "FizzBuzz"
            | n `mod` 3 == 0  = "Fizz"
            | n `mod` 5 == 0  = "Buzz"
            | otherwise       = show n

-- 7. Empty program
-- main = return ()

-- 8. A+B
aPlusB :: String -> Int
aPlusB = sum . map read . words

-- 9. 100 doors
hundredDoors :: [Int]
hundredDoors = [i | i <- [1..100], (floor . sqrt . fromIntegral) i ^ 2 == i]

-- 10. Quine
quine :: IO ()
quine = let s = "let s = %c%s%c in printf s (toEnum 34) s (toEnum 34)" in printf s (toEnum 34) s (toEnum 34)

-- 11. Launch rocket
launchRocket :: IO ()
launchRocket = do
    let accel = 9.8
    forM_ [10, 9 .. 0] $ \t -> do
        printf "T-minus %d...\n" t
        threadDelay 100000
    putStrLn "Liftoff!"
    forM_ [1..3] $ \t -> do
        let velocity = accel * fromIntegral t
        printf "Time: %ds, Velocity: %.1fm/s, Accel: %.1fm/s^2\n" t velocity accel

-- 12. Experimental Verification of the NKT Law
nktLawVerify :: Double -> Double -> Double -> Double -> Double
nktLawVerify t tEnv tInit k = tEnv + (tInit - tEnv) * exp (-k * t)

-- 13. Universal Lambda Machine
universalLambda :: Int
universalLambda = toInt (succ_ (succ_ zero))
  where
    zero f x = x
    succ_ n f x = f (n f x)
    toInt n = n (+1) 0

-- 14. Nautical bell
nauticalBell :: String -> Int
nauticalBell timeStr = 
    let (h, _:m1:m2:[]) = break (==':') timeStr
        hour = read h :: Int
        min = read [m1,m2] :: Int
        halfHours = (hour `mod` 4) * 2 + (if min >= 30 then 1 else 0)
    in if halfHours == 0 && min < 30 then 8 else halfHours

-- 15. Earliest difference between primes
primeDiff :: Int -> (Int, Int)
primeDiff target = findPair primes
  where
    primes = filter isPrime [2..]
    isPrime n = n > 1 && all (\d -> n `mod` d /= 0) (takeWhile (\d -> d*d <= n) [2..])
    findPair (p1:p2:ps)
        | p2 - p1 == target = (p1, p2)
        | otherwise = findPair (p2:ps)

-- 16. Canny edge detector (Simplified concept)
cannyConcept :: [[Double]] -> [[Double]]
cannyConcept grid = 
    [[ grad y x | x <- [1..cols-2]] | y <- [1..rows-2]]
  where
    rows = length grid
    cols = length (head grid)
    grad y x = sqrt $ (grid!!y!!(x+1) - grid!!y!!(x-1))**2 + (grid!!(y+1)!!x - grid!!(y-1)!!x)**2

-- 17. Death Star
drawDeathStar :: Int -> IO ()
drawDeathStar r = mapM_ putStrLn 
    [[if inSphere x y then (if inDish x y then ' ' else '#') else ' ' 
     | x <- [(-2*r).. (2*r)]] 
     | y <- [-r .. r]]
  where
    inSphere x y = (fromIntegral x / 2)**2 + (fromIntegral y)**2 <= (fromIntegral r)**2
    inDish x y = (fromIntegral x / 2 - r' / 2)**2 + (fromIntegral y - r' / 2)**2 <= (r' / 3)**2
    r' = fromIntegral r

-- 18. Chat server stub
chatServerStub :: String
chatServerStub = "Server configured for 127.0.0.1:65432"

-- 19. Faulhaber's triangle
faulhaberTriangle :: Int -> [[Rational]]
faulhaberTriangle n = [ [ (1 % (fromIntegral p + 1)) * (comb (p+1) j) * (bernoulli !! j) 
                        | j <- [0..p]] 
                      | p <- [0..n-1]]
  where
    comb n k = product [n-k+1..n] `div` product [1..k]
    bernoulli = map head $ iterate nextRow [1%1]
    nextRow rs = let m = length rs 
                 in (1%1 - sum [ comb (m+1) k % 1 * (rs !! (m-k)) | k <- [2..m+1]]) : rs -- Simplified recurrence

-- 20. Execute a Markov algorithm
markovAlgorithm :: [(String, String, Bool)] -> String -> String
markovAlgorithm rules text = case apply rules text of
    Just (newText, True)  -> newText
    Just (newText, False) -> markovAlgorithm rules newText
    Nothing               -> text
  where
    apply [] _ = Nothing
    apply ((p, r, t):rs) s
        | p `isInfixOf` s = Just (replaceFirst p r s, t)
        | otherwise       = apply rs s
    replaceFirst p r s = let (prefix, rest) = breakStr p s 
                         in prefix ++ r ++ drop (length p) rest
    breakStr p s = head [(pre, suf) | i <- [0..length s], let (pre, suf) = splitAt i s, p `Data.List.isPrefixOf` suf]