 % Return eigen vectors of matrix A
 % by Danilevsky-method

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
%  get_eigen_vectors_danilevsky.m


% Version : 1.0.0
% Created : 2013-05-09
% Copyright : Frodox <Frodox@lavabit.com>

function [ X ] = get_eigen_vectors_danilevsky(eig_vals, T)

n = size(eig_vals)(2);

X = zeros(n, n);

for i = 1:n

    lam = eig_vals(1, i);
    v = zeros(n, 1);
    v(n, 1) = 1;

    for j = 1:n-1
	v(n-j, 1) = lam^j;
    end

    X(:, i) =  T * v;
end

endfunction
