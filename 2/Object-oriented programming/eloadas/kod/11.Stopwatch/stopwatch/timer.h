#ifndef TIMER_H
#define TIMER_H

#include <chrono>
#include <thread>
#include "event.h"

class Stopwatch;

class Timer
{
	typedef std::chrono::milliseconds milliseconds;
public:
	Timer(Stopwatch *t) : _owner(t), _active(false) {  }
	void start();
	void stop();

private:
	void stateMachine();

    Stopwatch *_owner;
    bool _active;

	std::thread  _thread;
};

#endif // TIMER_H
