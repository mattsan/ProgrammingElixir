// $ g++ --std=c++11 -o fizz_buzz fizz_buzz.cpp
// $ ./fizz_buzz

#include <string>
#include <iostream>
#include <algorithm>

template<int N1, int N2, int N3> struct FizzBuzz3 { static const std::string value; };
template<int N3>                 struct FizzBuzz3<0, 0, N3> { static const std::string value; };
template<int N2, int N3>         struct FizzBuzz3<0, N2, N3> { static const std::string value; };
template<int N1, int N3>         struct FizzBuzz3<N1, 0, N3> { static const std::string value; };

template<int N1, int N2, int N3> const std::string FizzBuzz3<N1, N2, N3>::value = std::to_string(N3);
template<int N3>                 const std::string FizzBuzz3<0, 0, N3>::value = "FizzBuzz";
template<int N2, int N3>         const std::string FizzBuzz3<0, N2, N3>::value = "Fizz";
template<int N1, int N3>         const std::string FizzBuzz3<N1, 0, N3>::value = "Buzz";

template<int N> struct FizzBuzz { static const std::string value; };

template<int N> const std::string FizzBuzz<N>::value = FizzBuzz3<N % 3, N % 5, N>::value;

struct Nil;

template<template<int> class T, int First, int Last>
struct Range
{
    typedef T<First>                  Head;
    typedef Range<T, First + 1, Last> Tail;
};

template<template<int> class T, int Last>
struct Range<T, Last, Last>
{
    typedef T<Last> Head;
    typedef Nil     Tail;
};

template<int First, int Last>
using FizzBuzzSeries = Range<FizzBuzz, First, Last>;

template<typename R>
void puts_range()
{
    std::cout << R::Head::value << std::endl;
    puts_range<typename R::Tail>();
}

template<> void puts_range<Nil>() {};

int main(int, char* [])
{
    puts_range<FizzBuzzSeries<1, 20> >();

    return 0;
}
