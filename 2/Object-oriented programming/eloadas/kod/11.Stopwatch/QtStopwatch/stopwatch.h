#ifndef STOPWATCH_H
#define STOPWATCH_H

#include <QWidget>

class QTimer;
class QLCDNumber;
class QPushButton;

enum State { stopped, operate };

class Stopwatch: public QWidget
{
    Q_OBJECT
public:
    Stopwatch(QWidget *parent=nullptr);
    ~Stopwatch();
protected:
    void closeEvent(QCloseEvent * );

private:
    QTimer      *_timer;
    QLCDNumber  *_lcd;
    QPushButton *_clickButton;
    QPushButton *_zeroButton;

    State _currentState;
    int _seconds;

    QString format(int n) const;
    QString extend(int n) const;
private slots:
    void oneSecondPass();
    void clickButtonPressed();
    void zeroButtonPressed();
};


#endif // STOPWATCH_H
