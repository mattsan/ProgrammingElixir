#if 0
`g++ --std=c++11 -o agent_sample agent.cpp agent_sample.cpp`
__END__
#endif

#include <iostream>

#include "agent.h"

int main(int, char* []) {
    // {:ok, agent} = Agent.start(fn -> 0 end)
    agent_t* agent = agent_start([](){ return 0; });

    // IO.puts Agent.get(agent, &(&1))
    std::cout << agent_get(agent, [](int value) { return value; }) << std::endl;

    // Agent.update(agent, &(&1 + 1))
    agent_update(agent, [](int value) { return value + 1; });

    // Agent.update(agent, &(&1 + 1))
    agent_update(agent, [](int value) { return value + 1; });

    // IO.puts Agent.get(agent, &(&1))
    std::cout << agent_get(agent, [](int value) { return value; }) << std::endl;

    // Agent.update(agent, &(&1 + 99))
    agent_update(agent, [](int value) { return value + 99; });

    // IO.puts Agent.get(agent, &(&1))
    std::cout << agent_get(agent, [](int value) { return value; }) << std::endl;

    agent_end(agent);

    return 0;
}
