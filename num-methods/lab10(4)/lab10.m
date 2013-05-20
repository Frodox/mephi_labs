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
% d2f_oct = subs(f2, x, x0+h2);
% disp(d2f); disp(d2f_oct); 
% --- compare d2f and d2f_oct ----------------|
exact_solution = -1.7964889106288868286;
r2 = abs(d2f - exact_solution);


% Output --------------------------------|
printf("\n\n == %s ==\n\n", "Лабораторная работа No.4 - Численное дифференцирование ф-ций");
printf("eps = %f\n", eps);
printf("df/dx | (%1.1f) = %f\n", x0, df);
printf("h_опт. = %f\n", h1_opt);
printf("g_min = %f\n", g_min);
printf("\n");
printf("d2f/dx | (%1.5f) = %f\n", x0+h2, d2f);
printf("h = %f\n", h2);
printf("Невязка точного значения и расчитанного: %f\n", r2);
