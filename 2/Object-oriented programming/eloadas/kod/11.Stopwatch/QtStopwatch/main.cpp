#include "stopwatch.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    Stopwatch stop;
    stop.show();

    return app.exec();
}
