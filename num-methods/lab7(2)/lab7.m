% * Численные методы
% * Лабораторная работа No.7(2)
% * Cобственные значения и собственные векторы матриц
% - Вариант 2.6

% Created : 2013-05-07
% Version : 1.0.0
% Copyright : Frodox <Frodox@lavabit.com>

% input data (var. 2.6)
eps = 3e-4;
A = [
5.89	14.84	4.66	11.86
14.84	-12.69	19.85	12.79
4.66	19.85	16.99	-3.01
11.86	12.79	-3.01	-8.07
]

% get max element with coordinates
max_info = get_matrix_max_element(A);
i_max  = max_info(1);
j_max  = max_info(2);

a_ij = A(i_max, j_max)	% abs (max element)
a_ii = A(i_max, i_max)
a_jj = A(j_max, j_max)


p = 2 * a_ij
q = a_ii - a_jj
d = sqrt(p^2 + q^2)

if q ~= 0
    r = abs(q) / (2*d)
    c = sqrt(0.5 + r)
    s = sqrt(0.5 - r) * sign(p*q)
else
    c = s = sqrt(2) / 2
end

b_ii = a_ii*c^2 + a_jj*s^2 + 2*c*s*a_ij
b_jj = a_ii*s^2 + a_jj*c^2 - 2*c*s*a_ij


