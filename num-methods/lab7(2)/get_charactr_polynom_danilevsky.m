 % description

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
%  get_charactr_polynom_danilevsky.m


% Version : 1.0.0
% Created : 2013-05-08
% Copyright : Frodox <Frodox@lavabit.com>

function [T, Frob] = get_charactr_polynom_danilevsky(A)

[N, M] = size(A);
if (N ~= M) || (N < 1)
    error('Wrong matrix sructure (not square)');
end

B = A; % don't edit original A
trans = eye(N); % это будет матрица перехода к базису, где А имеет вид Фробениуса

for step = N:-1:2

B_orig = B;
E = eye(N);
find_non_zero = 0;

if 0 == B(step, step-1)
    for j = 1:step-1
	if (find_non_zero ~= 1) && (B(step, j) ~= 0)
	    find_non_zero = 1;

	    % change colums
	    printf("%s\n", "Dangerous! I meet ZERO. This part of algorithm %s",
		    " isn't tested very well.");
	    tmp = B(:, j);
	    B(:, j) = B(:, step-1);
	    B(:, step-1) = tmp;

	    tmp = E(:, j);
	    E(:, j) = E(:, step-1);
	    E(:, step-1) = tmp;

	    %change rows
	    tmp = B(j, :);
	    B(j, :) = B(step-1, :);
	    B(step-1, :) = tmp;

	    tmp = E(j, :);
	    E(j, :) = E(step-1, :);
	    E(step-1, :) = tmp;
	end
    end
else
    find_non_zero = 1;
end

if 1 ~= find_non_zero
    error("Wtf, mthf. Last(?) line have only zeros. I can't work with that");
end


b_n_n_1 = B(step, step-1);
B(:, step-1) = B(:, step-1) / b_n_n_1;
E(:, step-1) = E(:, step-1) / b_n_n_1;

for j = 1:N
    if j ~= step-1
	b_nj = B(step, j);
	B(:, j) = B(:, j) - b_nj * B(:, step-1);	% B(step, j) have changed
	E(:, j) = E(:, j) - b_nj * E(:, step-1);
    end
end

B = inv(E) * B_orig * E;
trans = trans * E;

end % for step = N:-1:2

T = trans;
Frob = B;
endfunction

% you can check it with `poly(A)`
