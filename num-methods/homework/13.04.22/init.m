% Init file for homework's task.
% Тема: Численное решение систем диф.урвывнений I порядка.
%
% Задание: Сделать 3 шага решения методом прогноза и коррекции 1-го порядка, ур-я:
% y' = exp(-y^2 - z^2) + 2x
% z' = 2y^2 + z
% 
% y(0) = 1/2
% z(0) = 1
% 
% Д.з. от семинара: 22-апр-13

## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## init

## Author: Frodox <Frodox@lavabit.com>
## Created: 2013-04-28
clear('all');

iteration_count = 3;
x0 = 0;
h = 0.1;

x = [x0];
for i = 1:iteration_count
    x = [x, x0 + i*h]
end

clear('i', 'iteration_count', 'x0');
