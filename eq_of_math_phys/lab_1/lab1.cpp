//-----------------------------------------------------------------
#include <QWidget>
#include <QPushButton>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QDebug>
#include <QtGui>
//-----------------------------------------------------------------
#include <qwt/qwt_plot.h>
#include <qwt/qwt_plot_curve.h>
#include <qwt/qwt_plot_grid.h>
//-----------------------------------------------------------------
#include <cmath>
//-----------------------------------------------------------------
#include "lab1.h"
//------------------------------------------------------------------------------
QwtBeginner::QwtBeginner(QWidget *parent)
    : QWidget(parent)
{
    setWindowTitle(tr("Профиль полубесконечной струны в различные моменты времени"));
    // Create plots
    funPlotArea = new QwtPlot;
    funPlotArea->setAxisScale(QwtPlot::xBottom, 0, 10, 1);
    funPlotArea->setAxisScale(QwtPlot::yLeft,    -1,  1,  0.25);
    funPlotArea->setAxisTitle(QwtPlot::xBottom, "x");
    funPlotArea->setAxisTitle(QwtPlot::yLeft,   "u(x,t)");
    funPlotArea->setTitle(tr(" "));
    QColor bg(Qt::white);
    funPlotArea->setCanvasBackground(bg);

    // Create "Brushes" for drawing and attach them to plots
    QPen uPen = QPen(Qt::red);
    QPen gridPen = QPen(Qt::gray, 1, Qt::DotLine);

    uFunCurve = new QwtPlotCurve("u(x, t)");
    uFunCurve->setRenderHint(QwtPlotItem::RenderAntialiased);
    uFunCurve->setPen(uPen);
    uFunCurve->attach(funPlotArea);

    QwtPlotGrid* grid = new QwtPlotGrid;
    grid->attach(funPlotArea);
    grid->setPen(gridPen);

    // Set data ----------------------------------------------------------------
    N = 10;
    h = 0.01;
    a = 2;
    points_count = int(N/h) + 1;

    data_x = new double[points_count];
    data_u = new double[points_count];

    timer = new QTimer(this);
    timer->setInterval(50);

    qDebug()<< "count: " << points_count;


    // Hide curves
    uFunCurve->setVisible(false);

    // Create buttons
    taskAButton = new QPushButton(tr("Пункт A"));
    taskAButton->setCheckable(true);

    playPauseBtn = new QPushButton(tr("Play / Pause"));
    playPauseBtn->setCheckable(true);
    playPauseBtn->setEnabled(0);

    taskBButton = new QPushButton(tr("Пункт B"));
    taskBButton->setCheckable(true);

    // Connect signals
    connect(taskAButton, SIGNAL(toggled(bool)), this,   SLOT(taskABtnToggled(bool)));
    connect(taskBButton, SIGNAL(toggled(bool)), this,   SLOT(taskBBtnToggled(bool)));
    connect(playPauseBtn, SIGNAL(toggled(bool)),this,   SLOT(playPause(bool)));



    // Set layouts
    QHBoxLayout *plotsLayout = new QHBoxLayout;
    plotsLayout->setSpacing(10);
    plotsLayout->addWidget(funPlotArea);

    QHBoxLayout *buttonsLayout = new QHBoxLayout ;
    buttonsLayout->addWidget(taskAButton);
    buttonsLayout->addWidget(playPauseBtn);
    buttonsLayout->addWidget(taskBButton);

    QVBoxLayout *widgetLayout = new QVBoxLayout;
    widgetLayout->addLayout(plotsLayout);
    widgetLayout->addLayout(buttonsLayout);

    setLayout(widgetLayout);
    showMaximized();
}

QwtBeginner::~QwtBeginner()
{
    delete [] data_x;
    delete [] data_u;
}


//------------------------------------------------------------------------------
// Our Main function of Task 1.. like u = f(x+at) + fi(x-at) etc
double QwtBeginner::u_A(double x, double a, double t)
{
    if(x >= a*t)
    {
//        qDebug() << "1";
        return (fi(x, a, t) + fi(x, -a, t))/2;
    }
    else
    {
//        qDebug() << "2";
        return (fi(x, a, t) - fi(-x, a, t))/2;
    }

}
//------------------------------------------------------------------------------
// For task B
double QwtBeginner::u_B(double x, double a, double t)
{
    if(x >= a*t)
    {
//        qDebug() << "1";
        return (fi(x, a, t) + fi(x, -a, t))/2;
    }
    else
    {
//        qDebug() << "2";
        return (fi(x, a, t) + fi(-x, a, t))/2;
    }
}

//------------------------------------------------------------------------------
// example: fi(x + at)...
double QwtBeginner::fi(double x, double a, double t)
{
    double start = 2.0;

    if (( x > (start - a*t)) && ( x <= (start - a*t + 1.0)))
    {
        return (x - (start - a*t));
    } else
        if (( x >= (start - a*t + 1.0)) && ( x < (start - a*t + 2.0)))
    {
            return (-x + (start - a*t + 2.0));
    }

    return 0;
}
//------------------------------------------------------------------------------
// update data fo task A coz of increase time
void QwtBeginner::updateDataA()
{
    int i = 0;
    double x_cur = 0;
    while(x_cur < N)
    {
//        x[i] = x_cur;
        data_x[i] = x_cur;
        data_u[i]= u_A(x_cur, a, t);
//        qDebug() << "x=  " << x[i] << " == " << x_cur;
//        uFunData[i] = u(x_cur, 3, 1.0/2.0);
//        qDebug() << "fi= " << uFunData[i];

//        qDebug() << "";

        x_cur += h;
        i++;
    }

    uFunCurve->setData(data_x, data_u, points_count);
}
//------------------------------------------------------------------------------
// update data for task B coz of increase time
void QwtBeginner::updateDataB()
{
    int i = 0;
    double x_cur = 0;
    while(x_cur < N)
    {
        data_x[i] = x_cur;
        data_u[i]= u_B(x_cur, a, t);

        x_cur += h;
        i++;
    }

    uFunCurve->setData(data_x, data_u, points_count);
}
//------------------------------------------------------------------------------
void QwtBeginner::taskABtnToggled(bool checked)
{
    t = 0;
    if (checked)
    {
        funPlotArea->setTitle(tr("Пункт А: t = 0"));
        updateDataA();

        connect(timer, SIGNAL(timeout()) , this, SLOT(timeIncreasedA()));
        timer->start();

        qDebug() << "Show A";
        taskBButton->setEnabled(0);
        playPauseBtn->setEnabled(1);
    }
    else
    {
        disconnect(timer, SIGNAL(timeout()) ,
                   this,  SLOT(timeIncreasedA()) );
        timer->stop();

        funPlotArea->setTitle(tr(" "));
        taskBButton->setEnabled(1);
        playPauseBtn->setChecked(0);
        playPauseBtn->setEnabled(0);
    }

    uFunCurve->setVisible(checked);
    funPlotArea->replot();
}
//------------------------------------------------------------------------------
void QwtBeginner::taskBBtnToggled(bool checked)
{
    t = 0;
    if (checked)
    {
        funPlotArea->setTitle(tr("Пункт B: t = 0"));
        updateDataB();

        connect(timer, SIGNAL(timeout()) , this, SLOT(timeIncreasedB()));
        timer->start();

        taskAButton->setEnabled(0);
        playPauseBtn->setEnabled(1);
        qDebug() << "Show B";
    }
    else
    {
        disconnect(timer, SIGNAL(timeout()) ,
                   this,  SLOT(timeIncreasedB()) );
        timer->stop();

        funPlotArea->setTitle(tr(" "));
        taskAButton->setEnabled(1);
        playPauseBtn->setChecked(0);
        playPauseBtn->setEnabled(0);
    }

    uFunCurve->setVisible(checked);
    funPlotArea->replot();
}
//------------------------------------------------------------------------------
// Play Pause graphic animation
void QwtBeginner::playPause(bool checked)
{
    if (checked) {
        timer->stop();
        qDebug() << "Pressed";
    }
    else {
        if (t) {
            timer->start();
            qDebug() << "Unpressed";
        }
    }
}
//------------------------------------------------------------------------------
// Called by timer to replot graphic, every 40 msec
void QwtBeginner::timeIncreasedA()
{
//    qDebug() << "Need to replot" << t;

    funPlotArea->setTitle(tr("Пункт А: t = ") + QString::number(t).leftJustified(5, '0', false));
    updateDataA();
    funPlotArea->replot();

    t += 0.005;
}
//------------------------------------------------------------------------------
void QwtBeginner::timeIncreasedB()
{
    funPlotArea->setTitle(tr("Пункт B: t = ") + QString::number(t).leftJustified(5, '0', false));
    updateDataB();
    funPlotArea->replot();

    t += 0.005;
}

//------------------------------------------------------------------------------
