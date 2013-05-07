% * Численные методы
% * Лабораторная работа No.7(2)
% * Cобственные значения и собственные векторы матриц
% - Вариант 2.6

% Created : 2013-05-07
% Version : 1.0.1
% Copyright : Frodox <Frodox@lavabit.com>

% input data (var. 2.6)
clear('all');
eps = 3e-4;
N = 4;
A = [
5.89	14.84	4.66	11.86
14.84	-12.69	19.85	12.79
4.66	19.85	16.99	-3.01
11.86	12.79	-3.01	-8.07
]

% zero step
B = A;
B_i = B;
max_info = get_matrix_max_element(B);
i_max  = max_info(1);
j_max  = max_info(2);


% main loop
while ( abs( B(i_max, j_max) ) > eps )

a_ij = abs( B(i_max, j_max) )	% abs of max element
a_ii = B(i_max, i_max);
a_jj = B(j_max, j_max);


p = 2 * a_ij;
q = a_ii - a_jj;
d = sqrt(p^2 + q^2);

if q ~= 0
    r = abs(q) / (2*d);
    c = sqrt(0.5 + r);
    s = sqrt(0.5 - r) * sign(p*q);
else
    c = s = sqrt(2) / 2;
end


B_i(i_max, i_max) = a_ii*c^2 + a_jj*s^2 + 2*c*s*a_ij;
B_i(j_max, j_max) = a_ii*s^2 + a_jj*c^2 - 2*c*s*a_ij;
B_i(i_max, j_max) = B_i(j_max, i_max) = 0;
check = (c^2 - s^2)*a_ij - c*s*(a_ii - a_jj)

for m = 1:N
    if (m ~= i_max) && (m ~= j_max)
	B_i(i_max, m) = B_i(m, i_max) = c * B(m, i_max) + s * B(m, j_max);
	B_i(j_max, m) = B_i(m, j_max) = -s* B(m, i_max) + c * B(m, j_max);
    end
end


B = B_i
max_info = get_matrix_max_element(B);
i_max  = max_info(1);
j_max  = max_info(2);

end % // while B(i_max, j_max) > eps

% in B you have собственные значения
% check it by `[U, V] = eig(A)`
