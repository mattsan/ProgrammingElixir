% $ gprolog --consult-file fizz_buzz.pro --entry-goal main

fizz_buzz(0, 0, _, "FizzBuzz") :- !.
fizz_buzz(0, _, _, "Fizz") :- !.
fizz_buzz(_, 0, _, "Buzz") :- !.
fizz_buzz(_, _, N, S) :- number_codes(N, S), !.

fizz_buzz(N, S) :- N3 is N rem 3, N5 is N rem 5, fizz_buzz(N3, N5, N, S).

fizz_buzz_series(First, Last, FBS) :- findall(FB, (between(First, Last, N), fizz_buzz(N, FB)), FBS).

puts(S) :- format("~s~n", [S]).

main :- fizz_buzz_series(1, 20, FBS), maplist(puts, FBS), halt.
