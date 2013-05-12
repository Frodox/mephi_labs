% do Task1
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

## task1

## Author: Frodox <Frodox@lavabit.com>
## Created: 2013-04-28

init

[n, m] = size(x);   % x' - vector : 1x4
y = zeros(n, m);
z = zeros(n, m);

% initial conditions
y(1, 1) = 1/2;
z(1, 1) = 1;

for i = 2:m
    y_i_1 = y(1, i-1);
    z_i_1 = z(1, i-1);
    
    y_app = y_i_1 + h * ( exp( -y_i_1^2 -z_i_1^2) + 2 * x(1, i-1) );
    z_app = z_i_1 + h * ( 2 * y_i_1^2 + z_i_1);

    y_i = y_i_1 + h * ( exp( -y_app^2 -z_app^2) + 2 * x(1, i-1) );
    z_i = z_i_1 + h * ( 2 * y_app^2 + z_app);

    y(1, i) =  y_i;
    z(1, i) = z_i;

    % disp('');
end

y
z
