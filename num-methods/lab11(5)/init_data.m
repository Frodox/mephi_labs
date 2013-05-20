 % Initialize data for lab11(5)
 % variant: 5.6

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
% Created : 2013-05-19
% Copyright : Frodox <Frodox@lavabit.com>


% == Task ==
% [0; 1]
% h = 0.1
% |- f(x)  = y' = y*x^2/2
% |- y(x0) = 1
%
% Solve it (get table of values) with method of prediction and correction - II 


% == Input data ==

% [a; b]
x0 = 0;
b  = 1;
h  = 0.1;

% y(x0)
y0  = 1;		

% accuracy for Runge-method
eps = 1e-4;
p = 2;
