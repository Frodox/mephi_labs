#include "matrix.h"
#include <iomanip>
//-------------------
#include <valarray>
#include <iostream>

using namespace std;

// Constructor
Matrix::Matrix(int row, int col)
{
    _rows = row;
    _cols = col;
    _data.resize(_rows * _cols, 0);     // initialize with zero value
}


//------------------ S E T // G E T --------------------------------------------
// Set value 'val' in certain matrix's cell - [row, col]
void Matrix::setVal(int row, int col, double val)
{
    if ((row >= _rows) || (col >= _cols))
    {
        cout << "ERROR: matrix hasn't such element: [" << row
             << ", " << col << "]" << endl;
        exit(-1);   // because it's error in the code - we can't go next
    }

    _data[_cols*row + col] = val;
}

// Get value of certain matrix's cell - [row, col]
double Matrix::val(int row, int col) const
{
    if ((row >= _rows) || (col >= _cols))
    {
        cout << "ERROR: matrix hasn't such element: [" << row
             << ", " << col << "]" << endl;
        exit(-1);
    }
    return _data[_cols*row + col];
}


// Get Left and under diagonal part of matrix
Matrix Matrix::getLeftUnderDiag()
{
    if (_rows != _cols)
    {
        cout << "ERROR: Операция допустима лишь для квадратных матриц." << endl;
        exit(-1);
    }
    Matrix L(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        for (int j = 0; j < i; ++j)
            L.setVal(i, j, val(i, j));
    }
    return L;
}

// Get Right and above diagonal part of matrix
Matrix Matrix::getRightAboveDiag()
{
    if (_rows != _cols)
    {
        cout << "ERROR: Операция допустима лишь для квадратных матриц." << endl;
        exit(-1);
    }
    Matrix R(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        for (int j = i+1; j < _cols; ++j)
            R.setVal(i, j, val(i, j));
    }
    return R;
}

// Get Diagonal part of matrix
Matrix Matrix::getDiag()
{
    if (_rows != _cols)
    {
        cout << "ERROR: Операция допустима лишь для квадратных матриц." << endl;
        exit(-1);
    }
    Matrix D(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        D.setVal(i, i, val(i, i));
    }
    return D;
}

// --------------- Matrix specific funcs ---------------------------------------
// Get det A - determinant of matrix A
double Matrix::determinant()
{

}


// ---------------- O P E R A T O R S ------------------------------------------

void Matrix::operator =(int b)
{
    cout << "= with arg: " << b << endl;
}

// Print matrix in ostream with operator '<<'. Like `cout << A`
ostream &operator <<(ostream &out, const Matrix &A)
{
    int rows = A.rows();
    int cols = A.cols();

    // print correctly double value
    out.setf(ios_base::showpoint);
    out.setf(ios_base::fixed, ios_base::floatfield);

    for (int i=0; i < rows; ++i)
    {
        for (int j=0; j < cols; ++j)
            out << setw(7) << setprecision(2) << A.val(i, j);
        out << endl;
    }
    return out;
}



// Check - if matrix is Square (row == cols). If not - exit
void Matrix::cont_if_square()
{
    if (_rows != _cols)
    {
        cout << "ERROR: Операция допустима лишь для квадратных матриц." << endl;
        exit(-1);
    }
}
