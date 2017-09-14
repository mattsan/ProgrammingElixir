#include "agent.h"

struct agent_t {
    int value;
};

agent_t* agent_start(int (*fun)()) {
    agent_t* agent = new agent_t();
    agent->value = fun();
    return agent;
}

void agent_update(agent_t* agent, int (*fun)(int)) {
    agent->value = fun(agent->value);
}

int agent_get(const agent_t* agent, int (*fun)(int)) {
    return fun(agent->value);
}

void agent_end(agent_t* agent) {
    delete agent;
}
