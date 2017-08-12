-module(primes).
-export([prime_numbers/1]).

prime_numbers(UpperLimit) ->
  prime_numbers(lists:seq(2, UpperLimit), []).

prime_numbers([], Acc) ->
  lists:reverse(Acc);
prime_numbers([P|Rest], Acc) ->
  prime_numbers([R || R <- Rest, R rem P /= 0], [P|Acc]).
