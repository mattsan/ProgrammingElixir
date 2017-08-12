# $ elixir fizz_buzz.exs

fizzBuzz3 = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, n -> "#{n}"
end

fizzBuzz = fn n -> fizzBuzz3.(rem(n, 3), rem(n, 5), n) end

fizzBuzzSeries = fn first, last -> first..last |> Enum.map(fizzBuzz) end

fizzBuzzSeries.(1, 20) |> Enum.join("\n") |> IO.puts
