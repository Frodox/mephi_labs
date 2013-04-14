% Используя метод Средней точки найти приближение к решению задачи Коши:
% y' = f(x, y)
% y(0) = 1
%
% Тема : Численные методы решения ОДУ
%
% Copyright (C) 2013 Frodox

% Author: Frodox
% Created: 2013-04-14



clear all
% call another script to initialize data
init1

[n, m] = size(x);   % x - vector' 1x11
y = zeros(n, m);
y(1, 1) = 1;

for i = 2:m
    x_j = x(1, i-1);
    y_j = y(1, i-1);
    y(1, i) = y_j + h * f(x_j + h/2,   y_j + h/2 * f(x_j, y_j));
end

disp('Метод Средней точки :');
disp(y);
clear('all');