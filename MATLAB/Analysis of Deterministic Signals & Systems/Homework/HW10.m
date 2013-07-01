% Carlos Lazo
% ECE504
% Homework #10

%% Problem #1

clear all; close all; clc;

% Declare all the matrices given in the problem:

A = [0 1 0; 0 0 -1; 1 0 -1];
B = [1; 1; 1];
C = [1 2 0];
D = [0];

syms f1; syms f2; syms f3; syms lambda;

F = [f1 f2 f3];

% Compute symbolic characteristic polynomial:

SP = det((lambda*eye(3)) - (A - (B * F)));

pretty(SP);

eqn_sol = solve('x+y+z+1=7','2*x+z=16','-y+z+1=12');

f1 =  5;
f2 = -5;
f3 =  6;

F = [f1 f2 f3];

% Now compute the transfer function of the closed-loop system:

A_bar = A - (B*F)

[num,den] = ss2tf(A_bar,B,C,D)

syms s;

G_s = (C - D*F) * (inv(s*eye(3) - (A - B*F))) * B + D;

pretty(G_s);

% Check to see that function tracks a step correctly:

p = -6;

B_bar = p * B;

step(A_bar, B_bar, C, D);

% Check for reachability of closed-loop system:

Qr = [B_bar (A_bar * B_bar) ((A_bar ^ 2) * B_bar)]

Qo = [C; (C * A_bar); (C * (A_bar^2))]

r_Qr = rank(Qr)
r_Qo = rank(Qo)

%% Problem #2

clear all; close all; clc;

% Declare all the matrices given in the problem:

A = [0 1; 0 0];
B = [1; 0];
C = [1 -1];
D = [0];

syms l1; syms l2; syms lambda;

L = [l1; l2];

SP = det((lambda*eye(2)) - (A - (L * C)));

pretty(SP);

%% Problem #3

syms eps;
A_bar = [0 (1+eps); 0 0]
 
syms t;
e_At = expm(t*A_bar);

pretty(e_At);