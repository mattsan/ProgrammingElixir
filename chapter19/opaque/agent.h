#ifndef __AGENT_H__
#define __AGENT_H__

struct agent_t;

agent_t* agent_start(int (*fun)());
void agent_update(agent_t* agent, int (*fun)(int));
int agent_get(const agent_t* agent, int (*fun)(int));
void agent_end(agent_t* agent);

#endif//__AGENT_H__
