#include "matrix.h"
#include <iomanip>
#include <cmath>
//-------------------
#include <valarray>
#include <iostream>


using namespace std;

// Constructors
Matrix::Matrix(int row, int col)
{
    _rows = row;
    _cols = col;
    _data.resize(_rows * _cols, 0.0);     // initialize with zero value
}
//---
Matrix::Matrix(const Matrix *other_matrix)
{
    _rows = other_matrix->rows();
    _cols = other_matrix->cols();
    _data.resize(_rows * _cols);     // initialize with zero value
    for (int i=0; i < N*N; ++i)
        setVal(i, other_matrix->val(i));
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

//    setVal(_cols*row + col, val);
    _data[_cols*row + col] = val;
}

void Matrix::setVal(int position, double val)
{
    if (position < N*N) {
        _data[position] = val;
    } else {
        cerr << "Try to set value out of range!" << endl;
        exit(-1);
    }
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

double Matrix::val(int position) const
{
    if (position < N*N) {
        return _data[position];
    } else {
        cerr << "Try to get value out of range!" << endl;
        exit(-1);
    }
}



// Get Left and under diagonal part of matrix
Matrix Matrix::getLeftUnderDiag()
{
    cont_if_square();
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
    cont_if_square();
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
    cont_if_square();
    Matrix D(_rows, _cols);

    for (int i = 0; i < _rows; ++i)
    {
        D.setVal(i, i, val(i, i));
    }
    return D;
}


// --------------- Matrix specific funcs ---------------------------------------

// Get A^(-1) - inverse of matrix A;        A * A^(-1) = E = diag(1)
Matrix Matrix::inverse()
{
    /* Алгоритм основан на методе Гаусса
     * (вернее на его модификации - метода Гаусса-Жордана - т.н.
     * методе полного исключения неизвестных).
     * Мы просто-напросто с помощью элементарных преобразований приводим
     * начальную матрицу к единичной. А вся фишка в том, что если те же
     * преобразования в том же порядке применить к единичной матрице -
     * получим матрицу, обратную для начальной.
     **/

    cont_if_square();
    // this - original matrix - NxN
    // R - result matrix      - NxN
    Matrix R(N, N);


            int size;
            double **result;
            double **matrix;

    // Изначально результирующая матрица является единичной
    // Заполняем единичную матрицу
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
            R.setVal(i, j, (i==j) ? 1.0 : 0.0);
    }

    // Копия исходной матрицы
    Matrix *copy_orig = new Matrix(this);
    cout << "Скопированная: \n" << endl << *(copy_orig) << endl;

    delete copy_orig;

        return R;
        exit(0);


    double **copy = new double *[size]();

    // Заполняем копию исходной матрицы
    for (int i = 0; i < size; ++i)
    {
        copy[i] = new double [size];

        for (int j = 0; j < size; ++j)
            copy[i][j] = matrix[i][j];
    }

    // Проходим по строкам матрицы (назовём их исходными)
    // сверху вниз. На данном этапе происходит прямой ход
    // и исходная матрица превращается в верхнюю треугольную
    for (int k = 0; k < size; ++k)
    {
        // Если элемент на главной диагонали в исходной
        // строке - нуль, то ищем строку, где элемент
        // того же столбца не нулевой, и меняем строки
        // местами
        if (fabs(copy[k][k]) < 1e-8)
        {
            // Ключ, говорязий о том, что был произведён обмен строк
            bool changed = false;

            // Идём по строкам, расположенным ниже исходной
            for (int i = k + 1; i < size; ++i)
            {
                // Если нашли строку, где в том же столбце
                // имеется ненулевой элемент
                if (fabs(copy[i][k]) > 1e-8)
                {
                    // Меняем найденную и исходную строки местами
                    // как в исходной матрице, так и в единичной
                    std::swap(copy[k],   copy[i]);
                    std::swap(result[k], result[i]);

                    // Взводим ключ - сообщаем о произведённом обмене строк
                    changed = true;

                    break;
                }
            }

            // Если обмен строк произведён не был - матрица не может быть
            // обращена
            if (!changed)
            {
                // Чистим память
                for (int i = 0; i < size; ++i)
                    delete [] copy[i];

                delete [] copy;

                // Сообщаем о неудаче обращения
//                return false;
            }
        }

        // Запоминаем делитель - диагональный элемент
        double div = copy[k][k];

        // Все элементы исходной строки делим на диагональный
        // элемент как в исходной матрице, так и в единичной
        for (int j = 0; j < size; ++j)
        {
            copy[k][j]   /= div;
            result[k][j] /= div;
        }

        // Идём по строкам, которые расположены ниже исходной
        for (int i = k + 1; i < size; ++i)
        {
            // Запоминаем множитель - элемент очередной строки,
            // расположенный под диагональным элементом исходной
            // строки
            double multi = copy[i][k];

            // Отнимаем от очередной строки исходную, умноженную
            // на сохранённый ранее множитель как в исходной,
            // так и в единичной матрице
            for (int j = 0; j < size; ++j)
            {
                copy[i][j]   -= multi * copy[k][j];
                result[i][j] -= multi * result[k][j];
            }
        }
    }

    // Проходим по вернхней треугольной матрице, полученной
    // на прямом ходе, снизу вверх
    // На данном этапе происходит обратный ход, и из исходной
    // матрицы окончательно формируется единичная, а из единичной -
    // обратная
    for (int k = size - 1; k > 0; --k)
    {
        // Идём по строкам, которые расположены выше исходной
        for (int i = k - 1; i + 1 > 0; --i)
        {
            // Запоминаем множитель - элемент очередной строки,
            // расположенный над диагональным элементом исходной
            // строки
            double multi = copy[i][k];

            // Отнимаем от очередной строки исходную, умноженную
            // на сохранённый ранее множитель как в исходной,
            // так и в единичной матрице
            for (int j = 0; j < size; ++j)
            {
                copy[i][j]   -= multi * copy[k][j];
                result[i][j] -= multi * result[k][j];
            }
        }
    }

    // Чистим память
    for (int i = 0; i < size; ++i)
        delete [] copy[i];

    delete [] copy;

    // Сообщаем об успехе обращения
//    return true;
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
