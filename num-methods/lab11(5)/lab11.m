% * Численные методы
% * Лабораторная работа No.11(5)
% * Методы решения Обыкновенных Дифференциальных Уравненийетоды
% - Вариант 5.6

%  This program is free software; you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation; either version 2 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with this program; if not, write to the Free Software
%  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
%  MA 02110-1301, USA.
%
%  lab11.m

% Created : 2013-05-19
% Copyright : Frodox <Frodox@lavabit.com>

clear('all');
init_data;

% iter = 0;
do
    n = (b - x0) / h;   % must be int, so ...
    n = ceil(n);        % round up (towards +inf)
    h = (b - x0) / n;

    % Get Y_h(h) and Y_h_2(h/2), calculated with h and h/2 respectively
    % by method of prediction and correction - II
    % Y_h / Y_h_2 -- tables of yi(xi)

    Y_h   = solveCauchyPACII(h,   x0, b, y0);
    Y_h_2 = solveCauchyPACII(h/2, x0, b, y0);
    clear('R');         % reuse it during loop
    R = zeros(1, n);    % Runge errors

    for i = 0:n-1
        r_1_i   = ( Y_h_2(1, 2*i+2) - Y_h(1, i+1)) / (2^p - 1);
        R(i+1)  = abs(r_1_i);
    end

    err = max(R);
    if err > eps
        h = h/2;
    end

    % iter++;
until (err < eps)       % stop when it's true


% Output --------------------------------|
[N, M] = size(Y_h_2);

printf("\n\t\t\t\t--- Лаба No.6 ---\n");
printf("\t\t--- Решить задачу Коши методом Прогноза и Корекции II порядка ---\n", "");
printf("y(%d) ~ ", b); disp(Y_h_2(M));
printf("h = "); disp(h);
printf("Заданная точность: \t\t");      disp(eps);
printf("Оценка погрешности по Рунге: \t");  disp(err);

% Extra output for Report. Get data for Table of solution in 5 points.
%
% step=round(size(Y_h)(1, 2) / 4)
% disp(n);
% for i = 1:step:n
    % disp(i)
    % printf("y 2h = "); disp(Y_h(i));
    % printf("y h = "); disp(Y_h_2(2*i));
    % printf("minus: %f\n", abs(Y_h_2(2*i) - Y_h(i)) );
    % printf("%s\n", "");
% end
    % n+1
    % printf("y 2h = "); disp(Y_h(n+1));
    % printf("y h = "); disp(Y_h_2(2*n+1));
    % printf("minus: "); disp(abs(Y_h_2(2*n+1) - Y_h(n+1)));
