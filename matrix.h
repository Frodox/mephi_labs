#ifndef MATRIX_H
#define MATRIX_H

#include <iostream>
#include <valarray>
using namespace std;

// Class provides typical Mathematical matrix, N x M
class Matrix
{
public:
    Matrix(int row, int col);

    void setVal (int row, int col, double val);
    double val  (int row, int col) const;
    int rows() const {return _rows;}
    int cols() const {return _cols;}

    Matrix getLeftUnderDiag();
    Matrix getRightAboveDiag();
    Matrix getDiag();

    double determinant();


    void operator= (int b);
    friend ostream& operator<< (ostream& out, const Matrix &A);
private:
    valarray<double> _data;
    int _rows;
    int _cols;

    void cont_if_square();
};

#endif // MATRIX_H
