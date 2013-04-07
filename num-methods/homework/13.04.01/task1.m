% Применяя метод Эйлера, составить на отрезке [0, 1] таблицу значений решения задачи Коши.
% y' = f(x, y)
% y(0) = 1
%
% Тема : Численные методы решения ОДУ

clear all
% call another script to initialize data
init

[n, m] = size(x);   % x - vector' 1x11
y = zeros(n, m);
y(1, 1) = 1;

for i = 2:m
    x_j = x(1, i-1);
    y_j = y(1, i-1);
    y(1, i) = y_j + h * f(x_j, y_j);
end
clear('x_j', 'y_j', 'i');

disp('Answer: y :');
disp(y);
clear('all');