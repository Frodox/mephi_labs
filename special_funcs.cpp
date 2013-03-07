#include <special_funcs.h>
#include <iostream>

// numbers of cols and rows in matrix:
#define N 5

using namespace std;

void initialize_A (Matrix &A)
{
//    cout << "Inithialize A" << endl;
    if ((A.rows() != N) || (A.cols() != N))
    {
        cout << "ERROR: Попытка инициализация матрицы размера отличного " << endl
             << "от размера в варианте 1.7 (n=" << N << ")." << endl;
        exit(-1);
    }

    A.setVal(0, 0, 4.12 );
    A.setVal(0, 1, 0.05 );
    A.setVal(0, 2, 0.75 );
    A.setVal(0, 3, 0.89 );
    A.setVal(0, 4, -0.27);
    A.setVal(1, 0, -0.70);
    A.setVal(1, 1, 2.99 );
    A.setVal(1, 2, 0.72 );
    A.setVal(1, 3, 0.77 );
    A.setVal(1, 4, 0.36 );
    A.setVal(2, 0, 0.41 );
    A.setVal(2, 1, -0.53);
    A.setVal(2, 2, 3.03 );
    A.setVal(2, 3, 0.08 );
    A.setVal(2, 4, -0.61);
    A.setVal(3, 0, -0.85);
    A.setVal(3, 1, -0.72);
    A.setVal(3, 2, 0.75 );
    A.setVal(3, 3, 6.26 );
    A.setVal(3, 4, -0.61);
    A.setVal(4, 0, -0.89);
    A.setVal(4, 1, -0.52);
    A.setVal(4, 2, 0.93 );
    A.setVal(4, 3, -0.51);
    A.setVal(4, 4, 1.01 );

    double multiple_diag = 1;
    for (int i =0; i<A.rows(); ++i)
    {
        multiple_diag *= A.val(i, i);
    }
    if (multiple_diag == 0)
    {
        cout << "ERROR: На главной диагонали матирцы А содержатся нули."
             << endl << "Задача не может быть решена преложенными в варианте 1.7 способами"
             << endl << "(->Зейдель, 2-й ортогонализации)" << endl;
        exit(-1);
    }
}

void initialize_b (Matrix &B)
{
    if ((B.rows() != N) || (B.cols() != 1))
    {
        cout << "ERROR: Попытка инициализация вектора b (Ax = b) размера отличного " << endl
             << "от размера в варианте 1.7 (" << N << " x 1)." << endl;
        exit(-1);
    }

    B.setVal(0, 0, 2.10 );
    B.setVal(1, 0, 0.01 );
    B.setVal(2, 0, 0.78 );
    B.setVal(3, 0, 0.82 );
    B.setVal(4, 0, 0.11);
}


void initialize_x0(Matrix &x0)
{
    if ((x0.rows() != N) || (x0.cols() != 1))
    {
        cout << "ERROR: Попытка инициализация вектора x0 некорректного размера" << endl
             << "от размера в варианте 1.7 (" << N << " x 1)." << endl;
        exit(-1);
    }

    x0.setVal(0, 0, 0.00 );
    x0.setVal(1, 0, 0.00 );
    x0.setVal(2, 0, 0.20 );
    x0.setVal(3, 0, 0.55 );
    x0.setVal(4, 0, 0.95 );
}


