% * Численные методы
% * Лабораторная работа No.7(2)
% * Cобственные значения и собственные векторы матриц
% - Вариант 2.6

% Created : 2013-05-07
% Version : 1.0.3
% Copyright : Frodox <Frodox@lavabit.com>


clear('all');
init_data

% task 1 - get eigen values of matrix A by yacobi-method
%eig_val = get_eigenvalues_yacobi(A);

% task 2 - get characteristic polynomial by Danilevsky method

B = A; % don't edit original A
N = size(B)(1);
    printf("=============================================\n\n");
    A

E = eye(N);
b_n_n_1 = B(N, N-1)
if b_n_n_1 ~= 0

    B(:, N-1) = B(:, N-1) / b_n_n_1;
    E(:, N-1) = E(:, N-1) / b_n_n_1;

    for j = 1:N
	if j ~= N-1
	    b_nj = B(N, j);
	    B(:, j) = B(:, j) - b_nj * B(:, N-1);	% B(N, j) have changed
	    E(:, j) = E(:, j) - b_nj * E(:, N-1);
	end
    end
    
else 
    
end

