% Применяя метод Средней точки, составить на отрезке [0, 1] таблицу значений решения задачи Коши.
% y' = f(x, y)
% y(0) = 1
%
% Тема : Численные методы решения ОДУ
%
% Copyright (C) 2013 Vitaly Rybnikov

% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with Octave; see the file COPYING.  If not, see
% <http://www.gnu.org/licenses/>.

% task3

% Author: Vitaly Rybnikov <Vitaly@localhost.localdomain>
% Created: 2013-04-07



clear all
% call another script to initialize data
init

[n, m] = size(x);   % x - vector' 1x11
y = zeros(n, m);
y(1, 1) = 1;

for i = 2:m
    x_j = x(1, i-1);
    y_j = y(1, i-1);
    y(1, i) = y_j + h * f(x_j + h/2,   y_j + h/2 * f(x_j, y_j));
end

disp('Метод Средней точки / Answer->y :');
disp(y);
clear('all');