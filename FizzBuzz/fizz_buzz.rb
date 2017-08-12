# $ ruby fizz_buzz.rb

def fizz_buzz3(n3, n5, n)
  case [n3, n5, n]
  when [0,  0,  n] then 'FizzBuzz'
  when [0,  n5, n] then 'Fizz'
  when [n3, 0,  n] then 'Buzz'
  else                "#{n}"
  end
end

def fizz_buzz(n)
  fizz_buzz3(n % 3, n % 5, n)
end

def fizz_buzz_series(first, last)
  (first..last).map {|n| fizz_buzz(n) }
end

puts fizz_buzz_series(1, 20).join("\n")
