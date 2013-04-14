% Методом Рунге-Кутта IV порядка найти на отрезке [0, 0.5] приближение
% к решению задачи Коши:
% y' = f(x, y) = x+y
% y(0) = 1
%
% Тема : Численные методы решения ОДУ
%
% Copyright (C) 2013 Frodox

% Author: Frodox
% Created: 2013-04-14

clear('all');
% call another script to initialize data
init2;

[n, m] = size(x);   % x - vector' 1x11
y = zeros(n, m);
y(1, 1) = 1;        % first element; i.e. y(0) = 1

for i = 2:m
    x_j = x(1, i-1);
    y_j = y(1, i-1);

    % Метод Р-К:4
    n_1 = f2(x_j, y_j);
    n_2 = f2(x_j + h/2, y_j + h/2 *n_1);
    n_3 = f2(x_j + h/2, y_j + h/2 *n_2);
    n_4 = f2(x_j + h, y_j + h *n_3);
    delta_y = h/6 * (n_1 + 2*n_2 + 2*n_3 + n_4);
    y(1, i) = y_j + delta_y;
end

disp('Метод Рунге-Кутта (IV) :');
disp(y);
clear('all');
