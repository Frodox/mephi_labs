% Исходная функция:
% y = sqrt (2x + 1)
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
    y(1, i) = sqrt(2 * x_j + 1);
end

disp('y = sqrt (2x + 1) :');
disp(y);
clear('all');
