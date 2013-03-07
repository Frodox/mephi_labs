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
//-------------
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

// Swap i and j rows
void Matrix::swap(int i, int j)
{
//    if ((i < 0 || i >= _cols)  ||  (l < 0 || j >= _cols))
//    {
//        cerr << "EROOR: try to get element out of range";
//        exit(-1);
//    }
    double buff;
    for (int k=0; k < _cols; ++k)
    {
        buff = val(i, k);
        setVal(i, k, val(j, k));
        setVal(j, k, buff);
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
Matrix Matrix::inverted()
{
    /* Алгоритм основан на методе Гаусса
     * (вернее на его модификации - метода Гаусса-Жордана - т.н.
     * методе полного исключения неизвестных).
     * Мы просто-напросто с помощью элементарных преобразований приводим
     * начальную матрицу к единичной. А вся фишка в том, что если те же
     * преобразования в том же порядке применить к единичной матрице -
     * получим матрицу, обратную для начальной.
     * http://www.cyberforum.ru/cpp-beginners/thread188159-page2.html
     **/

    // this - original matrix - NxN
    // R - result matrix      - NxN

    cont_if_square();

    Matrix R(N, N);
    // Изначально результирующая матрица является единичной
    for (int i = 0; i < N; ++i)
    {
        for (int j = 0; j < N; ++j)
            R.setVal(i, j, (i==j) ? 1.0 : 0.0);
    }

    // Копия исходной матрицы
    Matrix *copy_orig = new Matrix(this);
//    cout << "Скопированная: \n" << endl << *(copy_orig) << endl;

    // Проходим по строкам матрицы (назовём их исходными)
    // сверху вниз. На данном этапе происходит прямой ход
    // и исходная матрица превращается в верхнюю треугольную
    for (int k = 0; k < N; ++k)
    {
        // Если элемент на главной диагонали в исходной
        // строке - нуль, то ищем строку, где элемент
        // того же столбца не нулевой, и меняем строки
        // местами
        if ( fabs(copy_orig->val(k, k)) < 1e-8 )
        {
            // Ключ, говорязий о том, что был произведён обмен строк
            bool changed = false;

            // Идём по строкам, расположенным ниже исходной
            for (int i = k+1; i < N; ++i)
            {
                // Если нашли строку, где в том же столбце
                // имеется ненулевой элемент
                if ( fabs(copy_orig->val(i, k)) > 1e-8)
                {
                    // Меняем найденную и исходную строки местами
                    // как в исходной матрице, так и в единичной
                    copy_orig->swap(k, i);
                    R.swap(k, i);
//                    std::swap(copy[k],   copy[i]);
//                    std::swap(result[k], result[i]);

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
                delete copy_orig;
                // Сообщаем о неудаче обращения
                cerr << "Матрица не может быть обращена!";
                exit(-1);
            }
        }

        // Запоминаем делитель - диагональный элемент
        double div = copy_orig->val(k, k);

        // Все элементы исходной строки делим на диагональный
        // элемент как в исходной матрице, так и в единичной
        for (int j = 0; j < N; ++j)
        {
            copy_orig->setVal(k, j, copy_orig->val(k, j) / div );
            R.setVal(k, j, R.val(k, j) / div );
        }

        // Идём по строкам, которые расположены ниже исходной
        for (int i = k+1; i < N; ++i)
        {
            // Запоминаем множитель - элемент очередной строки,
            // расположенный под диагональным элементом исходной
            // строки
            double multi = copy_orig->val(i, k);

            // Отнимаем от очередной строки исходную, умноженную
            // на сохранённый ранее множитель как в исходной,
            // так и в единичной матрице
            for (int j = 0; j < N; ++j)
            {
                double buf_ij;
                double buf_kj;

                buf_ij = copy_orig->val(i, j);
                buf_kj = copy_orig->val(k, j);
                copy_orig->setVal(i, j, buf_ij - multi*buf_kj);
//                copy[i][j]   -= multi * copy[k][j];

                buf_ij = R.val(i, j);
                buf_kj = R.val(k, j);
                R.setVal(i, j, buf_ij - multi*buf_kj);
//                result[i][j] -= multi * result[k][j];
            }
        }
    }

    // Проходим по верхней треугольной матрице, полученной
    // на прямом ходе, снизу вверх
    // На данном этапе происходит обратный ход, и из исходной
    // матрицы окончательно формируется единичная, а из единичной -
    // обратная
    for ( int k = N-1; k > 0; --k)
    {
        // Идём по строкам, которые расположены выше исходной
        for (int i = k-1; i+1 > 0; --i)
        {
            // Запоминаем множитель - элемент очередной строки,
            // расположенный над диагональным элементом исходной
            // строки
            double multi = copy_orig->val(i, k);

            // Отнимаем от очередной строки исходную, умноженную
            // на сохранённый ранее множитель как в исходной,
            // так и в единичной матрице
            for (int j = 0; j < N; ++j)
            {
                double buf_ij;
                double buf_kj;

                buf_ij = copy_orig->val(i, j);
                buf_kj = copy_orig->val(k, j);
                copy_orig->setVal(i, j, buf_ij - multi*buf_kj);
//                copy[i][j]   -= multi * copy[k][j];


                buf_ij = R.val(i, j);
                buf_kj = R.val(k, j);
                R.setVal(i, j, buf_ij - multi*buf_kj);
//                result[i][j] -= multi * result[k][j];
            }
        }
    }

    // Clear memory
    delete copy_orig;

    return R;
}
//-------------------------------
// return norma ( ||x|| of a vector )
// use Euclidean norm
double Matrix::norm()
{
//    double norm = 0;

    if ((_rows != N) || (_cols != 1))
    {
        // it's not a normal vector (Nx1)
        cout << "ERROR: Попытка посчитать норму не для вектора размера Nx1" << endl;
        exit(-1);
    }

    double summ_of_quards = 0;
    for (int i = _rows*_cols -1; i >= 0; --i) {
        summ_of_quards += pow(val(i), 2);
    }

//    norm = sqrt(summ_of_quards);
    return sqrt(summ_of_quards);
}


// ---------------- O P E R A T O R S ------------------------------------------

void Matrix::operator =(int b)
{
    cout << "= with arg: " << b << endl;
}

// A*a : Multiply all elements of matrix 'A' by digit 'a'
Matrix Matrix::operator *(int a)
{
    cout << "multiply by " << a << endl;
    Matrix R(_rows, _cols);
    for (int i = N*N-1; i>=0; i--)
        R.setVal(i, a * _data[i]);

    return R;
}

// R = A * B
Matrix Matrix::operator *(const Matrix &B)
{


    if (_cols != B.rows())
    {
        cerr << "ERROR: операция умножения недопустима для матриц с A.cols != B.rows"
            << endl;
        exit(-1);
    }

    // A : m x n
    const int m = _rows;
    const int n = _cols;

    // B : n x b
    const int b = B.cols();

    // Result R: m x b
    Matrix R(m, b);


    for (int k = 0; k < m; ++k)         // go through all rows of A: 0..m-1
    {
        for (int l = 0; l < b; ++l)     // go through all cols of B: 0..b-1
        {
            // calculate R[k, l] = c_kl
            double c_kl = 0;
            for (int i = 0; i < n; ++i)
                c_kl += val(k, i) * B.val(i, l);

            R.setVal(k, l, c_kl);
        }
    }
    return R;
}

// A + B
Matrix Matrix::operator +(const Matrix &B)
{
    //    cout << "A + B" < <endl;
    if (_rows != B.rows()  ||  _cols != B.cols())
    {
        cerr << "ERROR: Допустимо складывать матирцы лишь одинакового размера"
             << endl;
        exit(-1);
    }

    Matrix R(_rows, _cols);
    for (int i = _rows*_cols - 1; i >= 0; --i)
    {
        R.setVal(i, val(i) + B.val(i));
    }
    return R;
}
//---------------------------------------
// A - B
Matrix Matrix::operator -(const Matrix &B)
{

    if (_rows != B.rows()  ||  _cols != B.cols())
    {
        cerr << "ERROR: Допустимо вычитать матирцы лишь одинакового размера"
             << endl;
        exit(-1);
    }

    Matrix R(_rows, _cols);
    for (int i = _rows*_cols - 1; i >= 0; --i)
    {
        R.setVal(i, val(i)-B.val(i));
    }
    return R;
}
//-------------------------------------------
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


//Matrix Matrix::operator +(const Matrix &A, const Matrix &B)
//{
//    cout << "A + B" < <endl;
//}
