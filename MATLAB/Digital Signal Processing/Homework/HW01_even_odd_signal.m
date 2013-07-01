% Carlos Lazo
% ECE 503
% Homework #1
% Due: 2/1/10

% 1) Discrete Sequences, Part d.

function [x_e x_o] = HW01_even_odd_signal (x)


% Define the variables:
%   xk     = regular discrete sequence
%   x_negk = xk flipped about y axis
%            * Note - flip about y axis is the same as reversing elements!

xk     = x;
x_negk = fliplr(x);

x_e = 1/2 * (xk + x_negk);
x_o = 1/2 * (xk - x_negk);
    