 % Draw graphic

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
%  draw_I_N.m

% Created : 2013-05-18
% Copyright : Frodox <Frodox@lavabit.com>

N = [14 140 1390 13890 138890]
I = zeros(1, size(N)(2))
I(1, :) = 0.43288

plot(N, I, 'b+-')
% title('Nice graphic')
xlabel('N')
ylabel('Integral')
grid on
print('fig_I_N.eps', '-deps')
