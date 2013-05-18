 % Initialize data for lab10(4)
 % variant: 4.6

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
% Created : 2013-05-18
% Copyright : Frodox <Frodox@lavabit.com>

% f(x) = x*cos(exp(x))
% find df / dx using the formula approximating the value of the first derivative.

% Input data:

eps = 9e-4;
del = 3e-6;

a  = -1;
b  = 1;
x0 = 0;

% max(a,b) |f''(x)|
max_1_1_d2f = 4.2;  % look fig1_d2f.eps || d2f.wxm(Maxima) || calculate it urself

h = 2*eps / max_1_1_d2f;
h_opt = (4*del / max_1_1_d2f)^0.5;
g_min = 2*del / h_opt + max_1_1_d2f * h_opt / 2;
