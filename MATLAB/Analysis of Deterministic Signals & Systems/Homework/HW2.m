% Carlos Lazo
% ECE504 - Homework 2

%% Problem #1

clc; clear all; close all;

% After computing all SS matrices, input them as follows:

A = [-1 0 0; 0 0 -1; 0 1 -1];
B = [1; 1; 0];
C = [0 1 0];
D = [0];

% Compute numerator and denominators of SS TF:

[num_SS, den_SS] = ss2tf(A,B,C,D,1);

TF = tf(num_SS, den_SS);

display ('The following is the output from a ss2tf operation of the SS matrices:');

display(TF);

display ('Note that there is a factor of (s+1) in the numerator and denominator. Simplifying yields:');

syms s;

TF = (s+1)/(s^2 + s + 1);

display(TF);

% Second check to see if the matrix is being computed correctly:

I = eye(3);

G = (C * inv((s*I) - A) * B) + D;

display ('The following is the output from the [C((sI - A)^-1)*B] + D operation of the SS matrices:');

display(G);

%% Problem #3

clc; clear all; close all;

% Declare all system variables.

syms a; syms b; syms c; syms d; syms e;

% Declare given matrix.

M = [a 0 0; 0 b c; 0 d e];

display ('Here is the given matrix:');

pretty(M);

display ('Here is the inverse of the given matrix:');

pretty(inv(M));