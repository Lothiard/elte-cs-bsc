#include "stopwatch.h"
#include <QTimer>
#include <QLCDNumber>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>

Stopwatch::Stopwatch(QWidget *parent) : QWidget(parent)
{
    setWindowTitle("Stopwatch");
    resize(300, 160);

    _timer = new QTimer;
    _lcd = new QLCDNumber;
    _clickButton = new QPushButton("Start/Stop");
    _zeroButton = new QPushButton("Reset");

    // setObjectName(QString::fromUtf8("lcd"));

    QVBoxLayout *mainLayout = new QVBoxLayout;
    mainLayout->addWidget(_lcd);
    QHBoxLayout *buttonLayout = new QHBoxLayout;
    buttonLayout->addWidget(_clickButton);
    buttonLayout->addWidget(_zeroButton);
    buttonLayout->setSpacing(6);
    mainLayout->addLayout(buttonLayout);
    mainLayout->setMargin(11);
    mainLayout->setSpacing(6);
    setLayout(mainLayout);

    _currentState = stopped;
    _seconds = 0;

    _lcd->display(format(_seconds));
    _timer->start(1000);

    connect(_timer,  SIGNAL(timeout()), this, SLOT(oneSecondPass()));
    connect(_clickButton, SIGNAL(clicked()), this, SLOT(clickButtonPressed()));
    connect(_zeroButton, SIGNAL(clicked()), this, SLOT(zeroButtonPressed()));
}

void Stopwatch::closeEvent(QCloseEvent * )
{
    _timer->stop();
}

void Stopwatch::oneSecondPass()
{
    switch (_currentState){
        case operate: _lcd->display(format(++_seconds)); break;
        case stopped: break;
    }
}

void Stopwatch::clickButtonPressed()
{
    switch (_currentState){
        case operate: _currentState = stopped; break;
        case stopped: _currentState = operate; break;
    }
}

void Stopwatch::zeroButtonPressed()
{
    switch (_currentState){
        case operate: _currentState = stopped; break;
        case stopped: break;
    }
    _seconds = 0;
    _lcd->display(format(_seconds));
}

QString Stopwatch::format(int n) const
{
    return extend((n % 3600) / 60) + ":" + extend((n % 3600) % 60);
}

QString Stopwatch::extend(int n) const
{
    return (n < 10 ? "0" : "") + QString::number(n);
}

Stopwatch::~Stopwatch()
{

}
