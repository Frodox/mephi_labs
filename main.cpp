/***************************************************************************
 *   Copyright (C) 2013 by Vitaly Rybnikov                                  *
 *   Vitaly.Rybnikov@gmail.com                                             *
 *                                                                          *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                          *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of       *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        *
 *   GNU General Public License for more details.                          *
 ***************************************************************************/

/******************************************************************************
 *                 НИЯУ МИФИ, февраль 2013. Численные методы.
 *
 *          Лабораторная работа №6::Прямые и итерационные методы решения систем
 *                                  линейных алгебраических уравнений
 *
 *  - цель: Изучение прямых и итерационных методов решения СЛАУ
 *
 *  - постановка задачи:
 *      вариант 1.7
 *      2-й метод ортогонализации
 *      метод Зейделя
 * ---------------------------------------------------------------------------*
 * Выполнил:
 *  - студент группы k6-361::Рыбников Виталий
 *  - date: 24-feb-2013
 ******************************************************************************/

#include <iostream>
#include <stdio.h>
#include <valarray>
//------------------------------------------------------------------------------
#include <matrix.h>
#include <special_funcs.h>

#define N 5


using namespace std;

int main()
{
    // ==== We must solve:  A*x = b
    //      We will get:    x = B*x + C

    // original A - matrix
    Matrix A(N, N);
    initialize_A(A); // init 'A' with data from my varian (look first comment)
    cout << A << endl;


    Matrix R1 = A.inverted();
    cout << "Обратная матрица:" << endl;
    cout << R1 << endl;

    Matrix b(N, 1); // init 'b'  with data from my varian
    initialize_b(b);
//    cout << b << endl;

    // ==== Use Zeidel's method first
    // method of iteration. Simplified. Not all calculated in programs ;]
    // A = L + D + R
    // x = - (L+D)^(-1) *R*x + (L+D)^(-1) *b = B*x + C
    // B = (L+D)^(-1) *R,      C = (L+D)^(-1) *b

    Matrix L(N, N);
    L = A.getLeftUnderDiag();
//    cout << "L:" << endl << L << endl;

    Matrix R(N, N);
    R = A.getRightAboveDiag();
//    cout << "R:" << endl << R << endl;

    Matrix D(N, N);
    D = A.getDiag();
//    cout << "D:" << endl << D << endl;





//    int rows = 2;
//    int cols = 4;
//    valarray<double> matrix( rows * cols );     // no more, no less, than a matrix
////    matrix[ slice( 1, rows, cols ) ] = 3.14;    // set third column to pi
////    matrix[ 1 ] = 25.0;    // set third column to pi
//    matrix[ std::slice( 1, 1, 1 ) ] = 2.17;



    return 0;
}
