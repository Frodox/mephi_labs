% function
% Return coordinates of max (by abs()) element in matrix

## Copyright (C) 2013 Vitaly Rybnikov
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## get_matrix_max_element

## Author: Vitaly Rybnikov <Vitaly@desktop.fedora16>
## Created: 2013-05-07

function [ ret ] = get_matrix_max_element(A)

[n, m] = size(A);

if (n ~= m) || (n < 1)
    error('wrong matrix sructure (not square)');
    return;
end

max_el = abs(A(1, 1));
i_max = 1;
j_max = 1;

for i = 1:n
    for j = 1:n
	if abs(A(i, j)) > max_el
	    max_el = A(i, j);
	    i_max = i;
	    j_max = j;
	end
    end
end

ret = [i_max j_max]

endfunction
