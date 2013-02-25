#ifndef MATRIX_H
#define MATRIX_H

#include <iostream>
#include <valarray>
using namespace std;


class Matrix
{
public:
    Matrix(int row, int col);

    void setVal (int row, int col, double val);
    double getVal (int row, int col) const;

    void operator= (int b);
    friend ostream& operator<< (ostream& out, const Matrix &A);


    int rows() const {return _rows;}
    int cols() const {return _cols;}
private:
    valarray<double> _data;
    int _rows;
    int _cols;
};

#endif // MATRIX_H
