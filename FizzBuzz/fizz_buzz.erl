% $ erlc fizz_buzz.erl
% $ erl -run fizz_buzz main

-module(fizz_buzz).
-export([main/0]).

fizz_buzz(0, 0, _) -> "FizzBuzz";
fizz_buzz(0, _, _) -> "Fizz";
fizz_buzz(_, 0, _) -> "Buzz";
fizz_buzz(_, _, N) -> integer_to_list(N).

fizz_buzz(N) -> fizz_buzz(N rem 3, N rem 5, N).

fizz_buzz_series(First, Last) -> [fizz_buzz(N) || N <- lists:seq(First, Last)].

main() ->
  lists:map(fun(S) -> io:format("~s~n", [S]) end, fizz_buzz_series(1, 20)),
  erlang:halt(0).