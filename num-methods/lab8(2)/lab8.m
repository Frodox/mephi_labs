% * Численные методы
% * Лабораторная работа No.8(2)
% * Точечная квадратичная аппроксимация функций
% - Вариант 3.6

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
%  lab8.m

% Version : 1.0.0
% Created : 2013-05-09
% Copyright : Frodox <Frodox@lavabit.com>

init_data

A = zeros(m+1, m+1);
b = zeros(m+1, 1);

N = size(X_i)(2);	% N - count of points

for i = 1:m+1
    for j = 1:i
	A(j, i) = A(i, j) = 1/N * ( u(i-1, X_i) * u(j-1, X_i)' );
    end

    b(i, 1) = 1/N * ( u(i-1, X_i) * Y_i' );
end


% now we have to solve A*x = b
% no, A\b - is very easy. It's for weakness. (and check)

A_inv = eye(m+1);	% let find inv(A) with help of Gauss-method:
E = A;			%     ( A|E ) -> ( E|A^-1 )

for i = 1:m+1
    a_ii = E(i, i);

    E(i, :) 	= E(i, :) 	/ a_ii;
    A_inv(i, :) = A_inv(i, :) 	/ a_ii;

    for j = 1:m+1
	if  i ~= j
	    a_ij = E(j, i);
	    E(j, :) 	= E(j, :) 	- a_ij * E(i, :);
	    A_inv(j, :) = A_inv(j, :) 	- a_ij * A_inv(i, :);
	end
    end
end

x = A_inv * b;

x = x';

c0 = x(1);
c1 = x(2);
c2 = x(3);
c3 = x(4);

ro = 0;
Qm_x = zeros(1, N);
for i = 1:N
    y_i = Y_i(i);
    x_i = X_i(i);
    Qm_x(i) = q_m_x = c0*u(0, x_i) + c1*u(1, x_i) + c2*u(2, x_i) + c3*u(3, x_i);
    ro += ( q_m_x -  y_i ) ^ 2;
end

Qm_x
ro
