-- $ ghc --make fizz_buzz
-- $ ./fizz_buzz

fizzBuzz3 0 0 _ = "FizzBuzz"
fizzBuzz3 0 _ _ = "Fizz"
fizzBuzz3 _ 0 _ = "Buzz"
fizzBuzz3 _ _ n = show n

fizzBuzz n = fizzBuzz3 (n `mod` 3) (n `mod` 5) n

fizzBuzzeSeries = [ fizzBuzz n | n <- [1..20]]

main = putStrLn $ unlines fizzBuzzeSeries
