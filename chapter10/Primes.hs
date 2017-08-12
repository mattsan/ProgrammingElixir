module Primes(prime_numbers) where

prime_numbers u =
  prime_numbers' [2..u] []

prime_numbers' [] acc =
  reverse acc
prime_numbers' (p:rest) acc =
  prime_numbers' [r | r <- rest, r `mod` p /= 0] (p:acc)
