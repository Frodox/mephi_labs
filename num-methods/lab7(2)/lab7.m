% * Численные методы
% * Лабораторная работа No.7(2)
% * Cобственные значения и собственные векторы матриц
% - Вариант 2.6

% Created : 2013-05-07
% Version : 1.0.3
% Copyright : Frodox <Frodox@lavabit.com>


clear('all');
init_data

% task 1 - get eigen values of matrix A by Yacobi-method
eig_val = get_eigenvalues_yacobi(A);

% task 2 - get characteristic polynom of matrix A by Danilevsky-method
char_poly = get_charactr_polynom_danilevsky(A);

% task 3 - get eigen vectors of matrix A by Danilevsky-method

