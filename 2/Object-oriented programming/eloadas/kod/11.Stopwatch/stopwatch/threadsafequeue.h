#ifndef THREADSAFEQUEUE_H
#define THREADSAFEQUEUE_H

#include <queue>
#include <mutex>
#include <condition_variable>

template<typename Item>
class ThreadSafeQueue
{
public:
	ThreadSafeQueue() { _active = false; }

	void enqueue(const Item& e);
	void dequeue(Item& e);

    void startQueue()
    {
		_active = true;
    }

    void stopQueue()
    {
		_active = false;
        _cond.notify_all();
    }

    bool empty() const
    {
        return _queue.empty();
    }

private:
    std::queue<Item> _queue;
    bool _active;

	std::mutex _mu;
    std::condition_variable _cond;
};

template<typename Item>
void ThreadSafeQueue<Item>::enqueue(const Item& e)
{
	std::unique_lock<std::mutex> lock(_mu);
	_queue.push(e);
	_cond.notify_one();
}

template<typename Item>
void ThreadSafeQueue<Item>::dequeue(Item& e)
{
	std::unique_lock<std::mutex> lock(_mu);
	while (empty() && _active)
	{
		_cond.wait(lock);
	}

	if (_active)
	{
		e = _queue.front();
		_queue.pop();
	}
}

#endif
