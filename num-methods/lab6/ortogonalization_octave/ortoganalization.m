% Script for Lab 6 implement second method of ortogonalization
% Input data:
%   A - matrix
%   b - vector
% need to solve: Ax = b

clear all % :)

% Input Data
A = [
4.12    0.05    0.75    0.89    -0.27
-0.70   2.99    0.72    0.77    0.36
0.41    -0.53   3.03    0.08    -0.61
-0.85   -0.72   0.75    6.26    -0.61
-0.89   -0.52   0.93    -0.51   1.01
    ];
b = [
1
2
3
4
5
    ];
E = 2e-4;

% Construct matrix F, that will contain [f1; f2; f3; f4; f5]
% fi *fj = 0 - ortogonalized vector based on A = [a1; a2; ...; a5]
F = [];
for i = 1:5
    ai = A(i, :);   % (1x5)
    fi = ai;

    for k=1 : (i-1)
        % fi = ai + al_i1 * f1 + al_i2 * f2  + ...
        % fi = fi - (ai, fk) / (fk, fk) * fk - ...
        fk = F(k, :);   % (1x5)
        fi = fi - ( ( ai * fk' ) / ( fk * fk' ) ) * fk;
    end

    F = [F; fi];
end
clear i ai fi k fk


% Construct matrix H, that will convert A to A with ortogonalised rows
H = eye(5, 5);  % diag(1)
for i = 1:5
    % i
    H_i = eye(5, 5);
    for j = 1:(i-1)
        ai = A(i, :);   % (1x5)
        fj = F(j, :);   % (1x5)
        H_i(i, j) = - (ai * fj') / (fj * fj');
    end

    H = H_i * H;
end
clear H_i i j fj ai

% H*A = H*b
A = H*A;    % actually, H*A == F already :)
b = H*b;

x = zeros(5, 1);
for i = 1:5
    ai = A(i, :);   % 1x5

    x = x + b(i) / (ai * ai') * ai';

end

% Error of solution
r = b - A*x;

disp("Вектор решения системы:"), disp(x), disp('')
disp("Вектор невязки r = b - A*x"), disp(r), disp('')
disp("Норма вектора невязки ||r|| : "), disp(norm(r))
clear('all');