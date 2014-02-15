//-----------------------------------------------------------------
#ifndef QWTBEGINNER_H
#define QWTBEGINNER_H
//-----------------------------------------------------------------
#include <QWidget>
//-----------------------------------------------------------------
class QPushButton;
//-----------------------------------------------------------------
class QTimer;
class QwtPlot;
class QwtPlotCurve;
//-----------------------------------------------------------------
class QwtBeginner : public QWidget
{
    Q_OBJECT

public:
    QwtBeginner(QWidget *parent = 0);
    ~QwtBeginner();

private:
    // Plot area
    QwtPlot *funPlotArea;
    // functions
    QwtPlotCurve * uFunCurve;
    // Buttons-toogle ON / OFF
    QPushButton * taskAButton;
    QPushButton * taskBButton;
    QPushButton * playPauseBtn;

    int N;
    double h;
    int points_count;

    double t;
    double a;

    double* data_x;
    double* data_u;

    QTimer* timer;

    // lab's functions
    double u_A(double x, double a, double t);
    double u_B(double x, double a, double t);
    double fi(double x, double a, double t);

    // data - methods
    void updateDataA();
    void updateDataB();



private slots:
    void taskABtnToggled(bool checked);
    void taskBBtnToggled(bool checked);

    void timeIncreasedA();
    void timeIncreasedB();
    void playPause(bool checked);
};
//-----------------------------------------------------------------
#endif
//-----------------------------------------------------------------
