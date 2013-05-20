 % Solve the task of Cauchy
 %
 % Get table of yi(xi)
 % by method of prediction and correction - II

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
%  solveCauchyPACII.m

% Created : 2013-05-19
% Copyright : Frodox <Frodox@lavabit.com>

% solve exercise Cauchy with Prediction And Correction-II method
function [ ret ] = solveCauchyPACII(h, x0, b, y0)

    n = (b-x0) / h;
    x = x0:h:b;

    % Calculate y1 with some method.
    % Method Runge-Cutta:4 ------------------------
    x_j = x0;
    y_j = y0;

    n_1 = f(x_j, y_j);
    n_2 = f(x_j + h/2, y_j + h/2 *n_1);
    n_3 = f(x_j + h/2, y_j + h/2 *n_2);
    n_4 = f(x_j + h, y_j + h *n_3);
    delta_y = h/6 * (n_1 + 2*n_2 + 2*n_3 + n_4);
    y1 = y_j + delta_y;
    % ---------------------------------------------
    % y1 = y0 + h/2 * ( f(x0, y0) + f(x0 + h, y0 + h*f(x0, y0)) );

    ret(1) = y0;
    ret(2) = y1;

    for i = 2:n
        y_p      = ret(i) + h/2 *( 3*f(x(i),    ret(i)) - f(x(i-1), ret(i-1) ));
        ret(i+1) = ret(i) + h/2 *( f(x(i+1),    y_p)    + f(x(i),   ret(i)   ));
    end

endfunction


 % f(x, y) = y' = y*x^2 / 2
function [ ret ] = f(x, y)

    ret = y * x^2 / 2;

endfunction
