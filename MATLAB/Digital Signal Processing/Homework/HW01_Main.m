% Carlos Lazo
% ECE 503
% Homework #1
% Due: 2/1/10

% 1) Discrete Sequences, Part d.

clc; clear all; close all;

fprintf('Testing to see if function HW01_even_odd_signal works as intended.\n');
fprintf('Use Problem 1c) homework vector - x(k) = [2 3 4 5 6]:\n\n');


x = [2 3 4 5 6];

[x_e x_o] = HW01_even_odd_signal(x);

fprintf('Even portion of vector x(k):\n');
x_e
fprintf('\n');

fprintf('Odd portion of vector x(k):\n');
x_o
fprintf('\n');

fprintf('Check to see if x_e(k) + x_o(k) = x(k):\n\n');

e_o_sum = x_e + x_o;

if (x == e_o_sum)
    e_o_sum;
    fprintf('They match! This is to be expected.\n\n');
else
    e_o_sum;
    fprintf('They do NOT match! Computational error.\n\n');
end

%% OUTPUT

% Testing to see if function HW01_even_odd_signal works as intended.
% Use Problem 1c) homework vector - x(k) = [2 3 4 5 6]:
% 
% Even portion of vector x(k):
% 
% x_e =
% 
%      4     4     4     4     4
% 
% 
% Odd portion of vector x(k):
% 
% x_o =
% 
%     -2    -1     0     1     2
% 
% 
% Check to see if x_e(k) + x_o(k) = x(k):
% 
% They match! This is to be expected.