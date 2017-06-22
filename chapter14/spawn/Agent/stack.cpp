// usage:
//
// $ g++ --std=c++11 -o stack stack.cpp
// $ ./stack
// 3
// 2
// 1

#include <iostream>
#include <forward_list>

struct Stack
{
    Stack() : values() {}
    Stack(const std::forward_list<int>& values) : values(values) {}
    const std::forward_list<int> values;
};

const Stack start()
{
    return Stack();
}

const Stack push(const Stack& stack, int value)
{
    std::forward_list<int> next_values(stack.values);
    next_values.push_front(value);
    return next_values;
}

std::pair<const Stack, int> pop(const Stack& stack)
{
    std::forward_list<int> next_values(stack.values);
    int value = next_values.front();
    next_values.pop_front();
    return std::make_pair(Stack(next_values), value);
}

int main(int, char* [])
{
    auto stack0 = start();
    auto stack1 = push(stack0, 1);
    auto stack2 = push(stack1, 2);
    auto stack3 = push(stack2, 3);

    auto pair3 = pop(stack3);
    std::cout << pair3.second << std::endl;
    auto pair2 = pop(pair3.first);
    std::cout << pair2.second << std::endl;
    auto pair1 = pop(pair2.first);
    std::cout << pair1.second << std::endl;

    return 0;
};
