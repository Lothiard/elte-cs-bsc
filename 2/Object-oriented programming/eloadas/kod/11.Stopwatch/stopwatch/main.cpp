#include <iostream>
#include "stopwatch.h"

using namespace std;

int main()
{
    std::cout << "Choice option:" << std::endl;
	Stopwatch stopper;

    char o;

    do{

        std::cin >> o;
        if(o == 's')
        {
            stopper.send(click);
        }

    } while(o != 'q');
	stopper.send(quit);

    return 0;
}
