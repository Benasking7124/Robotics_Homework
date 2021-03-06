clc
clear all
close all

%global constant
g = 9.80665;
d_E = [0, 0, -g]';
%function
jacobian_g = @(q) -2 * g * [-q(3),       q(4),       -q(1),    q(2);
                             q(2),       q(1),        q(4),    q(3);
                                   0,  -2 * q(2),   -2 * q(3),          0];
e = @(q, a) quatrotate(q', d_E')' - a;
f_cost = @(q, a) e(q, a)' * e(q, a);
%f_cost = @(q, a) (-2 * g * (q(2, 1) * q(4, 1) - q(1, 1) * q(3, 1)) - a(1, 1))^2 + (-2 * g * (q(1, 1) * q(2, 1) + q(3, 1) * q(4, 1)) - a(2, 1))^2 + (-2 * g * (0.5 - q(2, 1)^2 - q(3, 1)^2 ) - a(3, 1))^2;


%import data
a = readmatrix("HW4-2.xls", 'Range', 'A2:C101');

%define
q_value = zeros(4, 100);
q_last_gradient_norm = zeros(1, 100);

%iteration
for i=1:100
    q_E_to_S =[1, 0, 0, 0]';
    t = 1;
    s_S = [a(i, 1); a(i, 2); a(i, 3)];
    while 1
        gradient_f = jacobian_g(q_E_to_S)' * e(q_E_to_S, s_S);
        t = BLS(t, q_E_to_S, s_S, gradient_f, f_cost);
        q_E_to_S = q_E_to_S - t * (gradient_f / norm(gradient_f));
        %q_E_to_S = q_E_to_S - t * gradient_f;
        if (norm(gradient_f) < 0.1)
            break;
        end
    end
    q_value(1:4, i) = q_E_to_S;
    q_last_gradient_norm(i) = norm(gradient_f);
end