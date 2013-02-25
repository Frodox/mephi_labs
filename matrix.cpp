#include "matrix.h"
#include <iomanip>
//-------------------
#include <valarray>

#include <iostream>
using namespace std;

Matrix::Matrix(int row, int col)
{
    _rows = row;
    _cols = col;
    _data.resize(_rows * _cols, 0);     // initialize with xero value
}

//------------------ S E T // G E T --------------------------------------------

void Matrix::setVal(int row, int col, double val)
{
    if ((row >= _rows) || (col >= _cols))
    {
        cout << "ERROR: matrix hasn't such element: [" << row
             << ", " << col << "]" << endl;
        return;
    }

    _data[_cols*row + col] = val;
}

double Matrix::getVal(int row, int col) const
{
    if ((row >= _rows) || (col >= _cols))
    {
        cout << "ERROR: matrix hasn't such element: [" << row
             << ", " << col << "]" << endl;
        exit(-1);
    }
    return _data[_cols*row + col];
}


Matrix Matrix::getLeftUnderDiag()
{
    Matrix L(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        for (int j = 0; j < i; ++j)
            L.setVal(i, j, getVal(i, j));
    }
    return L;
}

Matrix Matrix::getRightAboveDiag()
{
    Matrix R(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        for (int j = i+1; j < _cols; ++j)
            R.setVal(i, j, getVal(i, j));
    }
    return R;
}

Matrix Matrix::getDiag()
{
    Matrix D(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        D.setVal(i, i, getVal(i, i));
    }
    return D;
}


// ---------------- O P E R A T O R S ------------------------------------------

void Matrix::operator =(int b)
{
    cout << "= with arg: " << b << endl;
}

ostream &operator <<(ostream &out, const Matrix &A)
{
    int rows = A.rows();
    int cols = A.cols();

    out.setf(ios_base::showpoint);
    out.setf(ios_base::fixed, ios_base::floatfield);

    for (int i=0; i < rows; ++i)
    {

        for (int j=0; j < cols; ++j)
            out << setw(7) << setprecision(2) << A.getVal(i, j);
        out << endl;
    }
    return out;
}


