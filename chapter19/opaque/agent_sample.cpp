#if 0
`g++ --std=c++11 -o agent_sample agent.cpp agent_sample.cpp`
__END__
#endif

#include <iostream>

#include "agent.h"

int main(int, char* []) {
    agent_t* agent = agent_start([](){ return 0; });

    std::cout << agent_get(agent, [](int value) { return value; }) << std::endl;

    agent_update(agent, [](int value) { return value + 1; });

    agent_update(agent, [](int value) { return value + 1; });

    std::cout << agent_get(agent, [](int value) { return value; }) << std::endl;

    agent_update(agent, [](int value) { return value + 99; });

    std::cout << agent_get(agent, [](int value) { return value; }) << std::endl;

    agent_end(agent);

    return 0;
}
