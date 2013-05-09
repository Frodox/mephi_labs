 % Initialize data for lab8(2)
 % variant: 3.6

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
%  init_data.m
%
% Created : 2013-05-09
% Copyright : Frodox <Frodox@lavabit.com>

% Input data:

% the power of the polynomial approximating
m = 3;

% x ~ f(xi) = yi
% input matrix / MUST be square (NxN)
X_i = [-5.16 -3.27 -2.08 -1.72 -0.83 -0.49  0.14];
Y_i = [3.0    3.98  4.88  4.94  5.48  6.35  6.89];

% Метод решения СЛАУ:
%   решение СЛАУ через поиск обратной матрицы
%   (обратная матрица рассчитывается с помощью метода Гаусса).

