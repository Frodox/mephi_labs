% * Численные методы
% * Лабораторная работа No.7(1)
% * Cобственные значения и собственные векторы матриц
% - Вариант 2.6

% Created : 2013-05-07
% Version : 1.0.5
% Copyright : Frodox <Frodox@lavabit.com>


clear('all');
init_data

% task 1 - get eigen values of matrix A by Yacobi-method
[iteration_count, eig_vals_yacobi] = get_eigenvalues_yacobi(A);

% task 2 - get characteristic polynom of matrix A by Danilevsky-method
[T, Frob] = get_charactr_polynom_danilevsky(A);

% task 3 - get eigen vectors of matrix A by Danilevsky-method
eig_vects = get_eigen_vectors_danilevsky(A, T);

% output:
printf("%s\n", "Исходная матрица А:"); disp(A);

printf("\n%s\n\n", 	"----------------------------------------------------");
printf("%s\n\n", 	"## Метод Якоби поиска собственных значений ##");
printf("%s\n", 		"Вектор собственных значений:"); disp(eig_vals_yacobi);
printf("%s : %d\n", 	"Число итераций", iteration_count);


printf("\n%s\n\n", 	"----------------------------------------------------");
printf("%s\n\n", 	"## Определение характеристического многочлена методом Данилевского ##");
printf("%s\n", 		"Матрица в форме Фробениуса:"); disp(Frob);

p1 = Frob(1, 1); p2 = Frob(1, 2); p3 = Frob(1, 3); p4 = Frob(1, 4);

printf("\np(l) = l^4 - %f*l^3 - %f*l^2 - %f*l - %f\n", p1, p2, p3, p4);

[U, V] = eig(A);
eig_vals = diag(V)';	% if take Yacobi's eig_vals_yacobi - p(l) would be not zero
n = size(eig_vals)(2);

for i = 1:n
    l = eig_vals(i);
    err = l^4 - p1*l^3  - p2*l^2 - p3*l - p4;
    printf("p(%10f) = ", l); disp(err);
end


printf("\n%s\n\n", 	"----------------------------------------------------");
printf("%s\n\n", 	"## Получение собственных векторов при помощи метода Данилевского");
printf("%s %s\n", 	"Набор собственных векторов, соотв. собственным",
			"числам матрицы А (по столбцам):"); disp(eig_vects);
printf("\n%s\n\n", 	"Проверим выполнение условия A*v = lam * v для каждого с.з lam");

for i = 1:n
    v = eig_vects(:, i);
    lam = eig_vals(i);
    err = A*v - eig_vals(i) * v;

    printf("%s%d = %f\n", "С.З. lam", i, lam);
    printf("%s", "A*v - lam*v = "); disp(err');
    printf("%s\n", "");
end
 
disp('');
