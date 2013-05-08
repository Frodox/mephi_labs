 % function
 % Return eigen values of square matrix 'A', founded
 % by Yacobi - method.

% must call 'init_data' before

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
%  get_eigenvalues_yacobi.m

% Version : 1.0.0
% Created : 2013-05-08
% Copyright : Frodox <Frodox@lavabit.com>


function [ iteration_count, ret ] = get_eigenvalues_yacobi(A)

[N, M] = size(A);
if (N ~= M) || (N < 1)
    error('Wrong matrix sructure (not square)');
end

% zero step
iteration_count = 0;
B = A;
B_i = B;
max_info = get_matrix_max_element(B);
i_max  = max_info(1);
j_max  = max_info(2);


% main loop
while ( abs( B(i_max, j_max) ) > eps )

iteration_count++;
a_ij = abs( B(i_max, j_max) );	% abs of max element
a_ii = B(i_max, i_max);
a_jj = B(j_max, j_max);


p = 2 * a_ij;
q = a_ii - a_jj;
d = sqrt(p^2 + q^2);

if q ~= 0
    r = abs(q) / (2*d);
    c = sqrt(0.5 + r);
    s = sqrt(0.5 - r) * sign(p*q);
else
    c = s = sqrt(2) / 2;
end


B_i(i_max, i_max) = a_ii*c^2 + a_jj*s^2 + 2*c*s*a_ij;
B_i(j_max, j_max) = a_ii*s^2 + a_jj*c^2 - 2*c*s*a_ij;
B_i(i_max, j_max) = B_i(j_max, i_max) = 0;
% debug only :
% check = (c^2 - s^2)*a_ij - c*s*(a_ii - a_jj);

for m = 1:N
    if (m ~= i_max) && (m ~= j_max)
	B_i(i_max, m) = B_i(m, i_max) = c * B(m, i_max) + s * B(m, j_max);
	B_i(j_max, m) = B_i(m, j_max) = -s* B(m, i_max) + c * B(m, j_max);
    end
end


B = B_i;
max_info = get_matrix_max_element(B);
i_max  = max_info(1);
j_max  = max_info(2);

end % // while B(i_max, j_max) > eps

% diag(B) == eigen values of 'A'
% check it by `[U, V] = eig(A)`
ret = diag(B)';

endfunction
