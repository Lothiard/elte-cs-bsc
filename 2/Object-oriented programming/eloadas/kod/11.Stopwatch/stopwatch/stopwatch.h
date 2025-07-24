#ifndef STOPWATCH_H
#define STOPWATCH_H

#include <thread>
#include <atomic>
#include "lcdnumber.h"
#include "event.h"
#include "timer.h"
#include "threadsafequeue.h"

class Stopwatch
{
public:
    Stopwatch();
    ~Stopwatch();

    void send(Signal event) { _eventQueue.enqueue(event); }
private:
	enum State {operate, stopped, off};

	void stateMachine();
    void transition(Signal event);
    Signal getSignal() { Signal s; _eventQueue.dequeue(s); return s; }

    Timer _timer;
    LcdNumber _lcd;
    ThreadSafeQueue<Signal> _eventQueue;

    State _currentState;
    int _seconds;

    std::thread _thread;
};

#endif // STOPPER_H
