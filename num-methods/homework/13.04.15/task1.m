% Используя метод Хойна, найдём приближение к решению задачи Коши
% y' = f(x, y)
% y(0) = 1
%
% Тема : Численные методы решения ОДУ

clear('all');
% call sibling script to initialize data
init1

[n, m] = size(x);   % x - vector' 1x11
y = zeros(n, m);
y(1, 1) = 1;        % first element; i.e. y(0) = 1

for i = 2:m
    x_j = x(1, i-1);
    y_j = y(1, i-1);
    y(1, i) = y_j + h/2 * ( f(x_j, y_j) + f(x_j + h, y_j + h * f(x_j, y_j)) );
end

disp('Метод Хойна :');
disp(y);
clear('all');
