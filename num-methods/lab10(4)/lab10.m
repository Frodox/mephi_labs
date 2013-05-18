% * Численные методы
% * Лабораторная работа No.10(4)
% * Методы численного дифференцирования функций
% - Вариант 4.6

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
%  lab10.m

% Version : 1.0.0
% Created : 2013-05-18
% Copyright : Frodox <Frodox@lavabit.com>

clear('all');
init_data;

% df/dx - calculate the first derivative-|
y0 = f(x0);
y1 = f(x0 + h1);

df = (y1 - y0) / h1;
% ---------------------------------------|
% --- How to check:----------------------|
% symbols
% x = sym("x");
% f = x * Cos(Exp(x));
% f1 = differentiate(f, x);
% df_oct = subs(f1, x, x0);
% --- compare df and df_oct -------------|


% d2f/dx - calculate the second derivative -|
y0 = f(x0);
y1 = f(x0 + h2);
y2 = f(x0 + 2*h2);

d2f = (y0 - 2*y1 + y2) / h2^2;
% ------------------------------------------|
% --- How to check:-------------------------|
% symbols
% x = sym("x");
% f = x * Cos(Exp(x));
% f2 = differentiate(f, x, 2);
% d2f_oct = subs(f2, x, x0);
% disp(d2f); disp(d2f_oct); 
% --- compare d2f and d2f_oct ----------------|


% Output --------------------------------|
% printf("[%1.1f; %1.1f]\n", a, b);
% printf("eps = %f\n", eps);
% printf("Начальное количество разбиений n = %d\n", n);
% printf("Начальный шаг: %f\n", h_start);
% printf("Конечный  шаг: %f\n", h);
% printf("I (симпсоном) = %1.7f\n", I_h_2);
% printf("I (Гаусс) = \t%1.7f\n", I);
% printf("Погрешность метода Гаусса r3_gauss = %f\n", r3_gauss);
