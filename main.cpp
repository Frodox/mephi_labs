#include <iostream>
#include <stdio.h>
#include <valarray>
#include <matrix.h>
#include <special_funcs.h>

using namespace std;

int main()
{
    Matrix A(2, 4);
    A.setVal(1, 1 , 20.22);
    A.setVal(0, 3 , 55.22);

    cout << A;

    int rows = 2;
    int cols = 4;

    valarray<double> matrix( rows * cols );     // no more, no less, than a matrix

    valarray<double> *matrix2;
    matrix2 = new valarray<double> ( rows * cols );     // no more, no less, than a matrix

//    matrix[ slice( 1, rows, cols ) ] = 3.14;    // set third column to pi
//    matrix[ 1 ] = 25.0;    // set third column to pi
    matrix[ std::slice( 1, 1, 1 ) ] = 2.17;



    return 0;
}
