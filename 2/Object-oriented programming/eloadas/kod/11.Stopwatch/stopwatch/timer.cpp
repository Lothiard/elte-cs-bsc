#include "timer.h"
#include "stopwatch.h"
#include <condition_variable>
#include <mutex>

void Timer::start() {
	_active = true;
	_thread = std::thread(&Timer::stateMachine, this);
}

void Timer::stop() {
	_active = false;
	_thread.join();
}

void Timer::stateMachine()
{
	std::condition_variable cond;
    std::mutex mu;
	while (_active){
	    std::unique_lock<std::mutex> lock(mu);
		cond.wait_for(lock, milliseconds(1000));
		_owner->send(tick);
	}
}
