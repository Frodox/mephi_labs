% Calculate integral from defined function f(x) by Sympson method
% Get the step - h  as argument (it's frindly to determine h with Runge method)

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
%  
%  calcIntegralSympson.m

% Created : 2013-05-18
% Copyright : Frodox <Frodox@lavabit.com>

function [ ret ] = calcIntegralSympson(h_w)

% need only 'a' and 'b'
init_data
clear('h_start m n');

% Check, that h - correct -> n must be 'even' for sympson method 
n = (b - a) / h_w;
n = ceil(n);
if 1 == mod(n, 2)
    n++;
end
h_w = (b-a) / n;
m = n/2;


% Sympson method ------------------|

sig1 = 0;
sig2 = 0;
y0 = f(a);
y_2m = f(b);

for i = 1:2:2*m-1
    sig1 += f(a + i*h_w);
end

for i = 2:2:2*m-2
    sig2 += f(a + i*h_w);
end

ret = h_w/3 * (y0 + y_2m + 4*sig1 + 2*sig2);

endfunction
