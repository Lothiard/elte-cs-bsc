#include "stopwatch.h"

Stopwatch::Stopwatch() :  _timer(this)
{
    _eventQueue.startQueue();
    _thread = std::thread(&Stopwatch::stateMachine, this);
}

//a destruktorban termináljuk az esemény feldolgozó szálat
Stopwatch::~Stopwatch()
{
    _thread.join();
	_eventQueue.stopQueue();
}

void Stopwatch::stateMachine()
{
    _seconds = 0;
	_lcd.display(_seconds);
	_timer.start();
	_currentState = stopped;
    while( _currentState != off ) { //amíg nincs terminálás
        transition(getSignal()); //kiveszünk egy eseményt a sorból és feldolgozzuk
    }
    _timer.stop();
}

void Stopwatch::transition(Signal signal)
{
    switch (_currentState) { // milyen állapotban vagyunk
        case stopped:
            switch (signal) { // mi a szignál
                case click: _currentState = operate; break;
                case tick : break;
                case quit : _currentState = off; break;
            }
            break;
        case operate:
            switch (signal) { // mi a szignál
                case click: _currentState = stopped; break;
                case tick : _lcd.display(++_seconds); break;
                case quit : _currentState = off; break;
            }
            break;
        case off : ;
    }
}
