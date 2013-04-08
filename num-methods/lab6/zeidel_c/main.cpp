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

/*******************************************************************************
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
 * ----------------------------------------------------------------------------*
 * Выполнил:
 *  - студент группы k6-361::Рыбников Виталий
 *  - date: 24-feb-2013
 ******************************************************************************/

#include <iostream>
#include <cstdio>
#include <valarray>
//------------------------------------------------------------------------------
#include <matrix.h>
#include <special_funcs.h>

#define N 5
#define EPS 0.0002

using namespace std;

int main()
{
    // ==== We must solve:  A*x = b
    //      We will get:    x = B*x + C

    // init 'A' with data from my lab's varian
    Matrix A(N, N);
    initialize_A(A);

    Matrix A1 = A.inverted();
//        cout << "Обратная матрица:" << endl << A1 << endl;

    // init 'b'  with data from my varian
    Matrix b(N, 1);
    initialize_b(b);


    // Debug info
    printf("\t%s\n\n",  "== Входные параметры ==");
    printf("%s : %d\n", "n", N);
    cout << "A :" << endl << A;
    cout << "b: " << endl << b << endl;


    /* ==== Use Zeidel's method.
     * first method of iteration. Simplified. //Not all calculated in programs ;]
     * A = L + D + R
     * x = - (L+D)^(-1) *R*x + (L+D)^(-1) *b = B*x + C
     * B = - (L+D)^(-1) *R;C = (L+D)^(-1) *b
     **/
    Matrix L(A.rows(), A.cols());
    L = A.getLeftUnderDiag();
//    cout << "L:" << endl << L << endl;

    Matrix R(A.rows(), A.cols());
    R = A.getRightAboveDiag();
//    cout << "R:" << endl << R << endl;

    Matrix D = A.getDiag();
//    D =
//    cout << "D:" << endl << D << endl;

    Matrix B = (L + D).inverted();
    Matrix C = B;
    B = B*(-1);
    B = B*R;
//    cout << "B :" << endl << B << endl;
//    printf("%s%f\n", "Норма матрицы В : ", B.norm());

    C = C*b;
//    cout << "C :" << endl << C << endl;


    // == start zeidel's algorithm
    Matrix x_k(N, 1);   // x0   - start point for iteration method
    int iterations_count;

    initialize_x0(x_k);
    Matrix x0 = x_k;
    iterations_count = 0;


    Matrix x_new = zeidel_multiply(B, x_k, C);
    ++iterations_count;
//        cout << "x_new: " << endl << x_new << endl;

    cout << "------------" << endl;
    printf("%d : %f\n", iterations_count, (x_new - x_k).norm());

    double norma = 0;
    while ( (norma = fabs( (x_k - x_new).norm() )) > EPS)
    {
//        printf("%2.4f   ", norma);
//        cout << "Norm: " << norma << endl;
        x_k = x_new;
        x_new = zeidel_multiply(B, x_k, C);
        ++iterations_count;

        printf("%d : %f\n", iterations_count, (x_new - x_k).norm());

    }

//    Matrix x = A1 * b;
//        cout << "A^(-1)  * b :"   << endl << x << endl;

    // считаем невязку
    Matrix r(x_new.rows(), x_new.cols());
    r = b - A * x_new;
//    double error = (b - A*x_new).norm();



    // Output
    printf("\t%s\n\n", "== Выходные параметры ==");

    printf("%s\n", "Начальный вектор \nx0:");
    cout << x0 << endl;

    printf("%s :\n", "Вектор решения системы \nx");
    cout << x_new << endl;

    printf("%s\n", "Вектор невязки решения \nr = b - A*x");
    cout << r << endl;

    printf("%s : %f\n", "Норма вектора невязки", r.norm());

    printf("%s : %f\n", "Заданная точность", EPS);

    printf("%s : %f\n",
           "Величина ||x_(k) - x_(k-1)|| для последней итерации",
           norma);

    printf("%s : %d\n", "Число итераций", iterations_count);

    return 0;
}
