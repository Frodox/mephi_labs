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

% Sympson method ------------------------|
h_start = h;
p = 4;
h_2 = get_h_div_2(h);

I_h = calcIntegralSympson(h);
I_h_2 = calcIntegralSympson(h_2);
r = (I_h_2 - I_h) / (2^p - 1);

while (abs(r) > eps )
    % if we here - `h` need correction!
    h = get_h_div_2(h);    % correction done
    h_2 = get_h_div_2(h);

    I_h = calcIntegralSympson(h);
    I_h_2 = calcIntegralSympson(h_2);

    r = (I_h_2 - I_h) / (2^p - 1);
end
%----------------------------------------|
% how to check it:
% [area, ierror, nfneval] = quad("f", 0, 1) % f - defined function
% area =  0.43288 % the answer
% ierror = 0	% the error code
% nfneval =  21	% is the number of function evaluations

printf("I = %1.5f\n", I);

