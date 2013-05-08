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
[iteration_count, eig_vals] = get_eigenvalues_yacobi(A);

% task 2 - get characteristic polynom of matrix A by Danilevsky-method
[T, Frob] = get_charactr_polynom_danilevsky(A);

% task 3 - get eigen vectors of matrix A by Danilevsky-method
eig_vects = get_eigen_vectors_danilevsky(eig_vals, T);

% output:
printf("%s\n", "Исходная матрица А:"); disp(A);

printf("\n%s\n\n", "-----------------------------------------");
printf("%s\n\n", "## Метод Якоби поиска собственных значений");
printf("%s\n", "Вектор собственных значений:"); disp(eig_vals);
printf("%s : %d\n", "Число итераций", iteration_count);

printf("\n%s\n\n", "-----------------------------------------");
printf("%s\n\n", "## Определение характеристического многочлена методом Данилевского");
printf("%s\n", "Матрица в форме Фробениуса:"); disp(Frob);

% Frob(1, :) = (-1) * Frob(1, :);
p1 = Frob(1, 1);
p2 = Frob(1, 2);
p3 = Frob(1, 3);
p4 = Frob(1, 4);

printf("\np(l) = l^4 - %f*l^3 - %f*l^2 - %f*l - %f\n", p1, p2, p3, p4);

for i = 1:size(eig_vals)(2)
    err = 0;
    lam = eig_vals(i)
    t1 = lam^4
    t2 = lam^3
    t3 = lam^2

    r1 = t1 - p1*t2
    r2 = p2*t3 - p3*lam
    r3 = r1 - r2
    err = r3 - p4
    err2= lam^4 - p1*lam^3 - p2*lam^2 - p4

    printf("p(%f) = %f\n", lam, err);

    printf('----------------\n\n\n')
end



% printf("\n%s\n\n", "-----------------------------------------");
% printf("%s\n\n", "## Получение собственных векторов при помощи метода Данилевского");
% printf("%s %s\n", "Набор собственных векторов, соотв. собственным",
	% "числам матрицы А (по столбцам)"); disp(eig_vects);
% printf("\n%s\n", "Проверим выполнение условия Av = lam * v для каждого собств.значения lam");
% 
% for i = 1:size(eig_vals)(2)
    % v = eig_vects(:, i);
    % lam = eig_vals(i);
    % err = A * v - eig_vals(i) * v;
% 
    % printf("%s%d = %f\n", "Собственное значение lam", i, lam);
    % printf("%s", "Av - lam * v = "); disp(err');
    % printf("%s\n", "");
% end





disp('');
