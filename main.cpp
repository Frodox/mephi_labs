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
 *
 *
 * ---------------------------------------------------------------------------*
 * Выполнил:
 *  - студент группы k6-361::Рыбников Виталий
 *  - date: 24-feb-2013
 ******************************************************************************/


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
