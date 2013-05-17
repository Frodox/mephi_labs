 % Пуе h/2 - friendly for sympson method

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
%  get_h_div_2.m

% Created : 2013-05-18
% Copyright : Frodox <Frodox@lavabit.com>

function [ ret ] = get_h_div_2(h)

    init_data;
    clear('eps m max_ab_d4f')

    t = h/2;    % correction done

    % check, that h - friendly for using Sympson method
    n = (b - a) / t;	% it's MINimum count of parts. Actually must be even (chetn)
    n = ceil(n);
    if 1 == mod(n, 2)
        n++;
    end

    ret = (b-a) / n;

endfunction
