#ifndef MATRIX_H
#define MATRIX_H

#include <iostream>
#include <valarray>

using namespace std;
// by my varian in lab(j+i)%(razm)
#define N 5

// Class provides typical Mathematical matrix, N x M
class Matrix
{
public:
    Matrix(int row, int col);
    Matrix(const Matrix *other_matrix);

    void setVal (int row, int col, double val);
    void setVal (int position, double val);
    double val  (int row, int col) const;
    double val  (int position) const;
    int rows() const {return _rows;}
    int cols() const {return _cols;}
    void swap(int i, int j);

    Matrix getLeftUnderDiag();
    Matrix getRightAboveDiag();
    Matrix getDiag();

    Matrix inverted();


    void operator= (int b);
    friend ostream& operator<< (ostream& out, const Matrix &A);
private:
    valarray<double> _data;
    int _rows;
    int _cols;

    void cont_if_square();
};

#endif // MATRIX_H
