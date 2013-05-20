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
h = h_start;
p = 4;

I_h = calcIntegralSympson(h);
I_h_2 = calcIntegralSympson(h/2);
r = (I_h_2 - I_h) / (2^p - 1);

while (abs(r) > eps )
    % if we here - `h` need correction!
    h = h/2;
    
    I_h = calcIntegralSympson(h);
    I_h_2 = calcIntegralSympson(h/2);

    r = (I_h_2 - I_h) / (2^p - 1);
end
%----------------------------------------|
% how to check it:
% [area, ierror, nfneval] = quad("f", 0, 1) % f - defined function
% area =  0.43288 % the answer
% ierror = 0	% the error code
% nfneval =  21	% is the number of function evaluations



% Gauss method --------------------------|
b_a = (b-a)/2;

A1 = A3 = 5/9;
A2 = 8/9;

t1 = -0.774597;
t2 = 0;
t3 = 0.774597;

I = b_a * (A1*f((a+b)/2 + t1*b_a)
        +  A2*f((a+b)/2 + t2*b_a)
        +  A3*f((a+b)/2 + t3*b_a)
        );

% accuracy
max_ab_d6f = 30; % calculate in wxMaxima, plot and view. By abs
r3_gauss = max_ab_d6f / 15750;
%----------------------------------------|

% Output --------------------------------|
printf("[%1.1f; %1.1f]\n", a, b);
printf("eps = %f\n", eps);
printf("Начальное количество разбиений n = %d\n", n);
printf("Начальный шаг: %f\n", h_start);
printf("Конечный  шаг: %f\n", h);
printf("I (симпсоном) = %1.7f\n", I_h_2);
printf("I (Гаусс) = \t%1.7f\n", I);
printf("Погрешность метода Гаусса r3_gauss = %f\n", r3_gauss);
