% * Численные методы
% * Лабораторная работа No.9(3)
% * Методы численного интегрирования функций
% - Вариант 6 / 2

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
%  lab9.m

% Version : 1.0.0
% Created : 2013-05-10
% Copyright : Frodox <Frodox@lavabit.com>

clear('all');
init_data;

sig1 = 0;
sig2 = 0;
y0 = f(a);
y_2m = f(b);

for i = 1:2:2*m-1
    sig1 += f(a + i*h);
end

for i = 2:2:2*m-2
    sig2 += f(a + i*h);
end

I = h/3 * (y0 + y_2m + 4*sig1 + 2*sig2);

% how to check it:
% [area, ierror, nfneval] = quad("f", 0, 1) % f - defined function
% area =  0.43288 % the answer
% ierror = 0	% the error code
% nfneval =  21	% is the number of function evaluations


