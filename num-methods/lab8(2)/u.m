% Base function - u_i = { x^i }, i = 0, n
% usage: u(i, N)
% return N^i
% - i must be positive

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
%  u.m


% Version : 1.0.0
% Created : 2013-05-09
% Copyright : Frodox <Frodox@lavabit.com>

function [ ret ] = u(i, X)

if i < 0 
    error('Bar i-power in u(i, X) function'); 
end
    
    ret = X .^ i; % if is is array - process every element

endfunction
