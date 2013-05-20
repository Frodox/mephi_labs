 % Initialize data for lab9(3)
 % variant: 6 / 2

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
% Created : 2013-05-10
% Copyright : Frodox <Frodox@lavabit.com>

% I = integrate(0, 1){ exp(x) / [ 1 + exp(2*x) ] } dx
% Need to calc `I` with help of Sympson-method

% Input data:
a = 0;
b = 1;

% if want use this interactive mode, need to fix
% - calcIntegralSympson(h)
% - get_h_div_2(h)
% because there call init_data to get a, b, h, n, etc
%
% eps= input('Введите погрешность. eps = ');
eps= 1e-4;

if eps > 1e-2
    error("Слишком большая погрешность. Не хочу работать.");
end

max_ab_d4f = 2.5;	% calculated by hand : max(a,b) | d4f(x) / dx |

h_start = eps * 180 / ( (b-a) * max_ab_d4f );     % wrong formula. Need to add ^1/4
h_start = h_start^(1/4);

n = (b - a) / h_start;	% it's MINimum count of parts
n = ceil(n);
if 1 == mod(n, 2)
    n++;
end

h_start = (b-a) / n;
m = n/2;
