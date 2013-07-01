% Carlos Lazo
% ECE504
% Homework #9

%% Problem #2

clear all; close all; clc;

% Compute the state space realization of each individual TF in G(s):

num_11 = [1 1];
den_11 = [1 2];

num_12 = [0 1];
den_12 = [1 3];

num_21 = [1 0];
den_21 = [1 1];

num_22 = [1 1];
den_22 = [1 2];

[A_11 B_11 C_11 D_11] = tf2ss(num_11,den_11)
[A_12 B_12 C_12 D_12] = tf2ss(num_12,den_12)
[A_21 B_21 C_21 D_21] = tf2ss(num_21,den_21)
[A_22 B_22 C_22 D_22] = tf2ss(num_22,den_22)

%% Prolem #3

clear all; close all; clc;

syms s;

% Compute SS description from num & den:

num = [1 1 -2];
den = [1 2 -5 -6];

[A B C D] = tf2ss(num,den)

% Check for matrix controllability:

Qr = [B A*B (A^2)*B]

%% Problem #4

clear all; close all; clc;

A   = [1 1 -2; 0 1 1; 0 0 1];
syms l;

% Compute the characteristic polynomial:

c_p = det(l*eye(3) - A);

pretty(c_p);

% Using the A,B,C,D matrices, find the transfer function.
% This will be done to put the system into canonical form.

B = [1;0;1];
C = [2 0 0];
D = [0];

[num, den] = ss2tf(A,B,C,D)

syms s;
g_s = C*(inv(s*eye(3) - A))*B + D;

pretty(g_s);

P = [4 -4 1; -1 1 0; 1 -2 1]
G = [4 -2 2]

P_inv = inv(P)

F = G * P_inv