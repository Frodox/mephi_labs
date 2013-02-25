#include <iostream>
#include <stdio.h>
#include <valarray>

using namespace std;

int main()
{
    int rows = 2;
    int cols = 4;

    valarray<double> matrix( rows * cols );     // no more, no less, than a matrix
//    matrix[ slice( 1, rows, cols ) ] = 3.14;    // set third column to pi
//    matrix[ 1 ] = 25.0;    // set third column to pi
    matrix[ std::slice( 1, 1, 1 ) ] = 2.17;

    int i = 0;
    for ( int j=0; j < cols*rows; ++j )
    {
        printf("%3.3f (%i)   ", matrix[j], j );
//        cout << matrix[i, j] << "   ";

//        if( 1 == (cols - j) )
//        {
//            cout << endl;
//            j = -1;
//            ++i;
//        }

//        if( i == rows )
//            break;
    }

    return 0;
}
