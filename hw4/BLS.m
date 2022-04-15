function [t] =BLS(t, q, a, gradient_f, fg)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    alpha = 0.1;
    beta =  0.707;

   % while (fg(q - t * gradient_f, a) > (fg(q, a) - alpha * t * (gradient_f') * gradient_f))
    while (fg(q - t * (gradient_f / norm(gradient_f)), a) > (fg(q, a) - alpha * t * (gradient_f') * (gradient_f / norm(gradient_f))))
        t = t * beta;
    
    end
end