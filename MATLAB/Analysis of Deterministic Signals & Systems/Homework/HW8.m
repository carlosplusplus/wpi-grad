% Carlos Lazo
% ECE 504
% Homework #8

%% Problem #2 - Chen 6.3

clc; clear all; close all;
r0 =[0];
r1=[0];

N =10^4;
% Create an random A and B matrix:
for(a=1:N)
    %A = round(rand(3,3) * 10);
    A = ones(3,3);
    B = round(rand(3,1) * 10);

    Qr0 = [B (A*B) (A^2)*B (A^3)*B];
    Qr1 = [(A*B) (A^2)*B (A^3)*B (A^4)*B];

    % Compute the ranks of the individual matrices:

    r0 = rank(Qr0);
    r1 = rank(Qr1);

    if(r0~=r1)
        A
        B
        Qr0
        Qr1
        keyboard
    end
end
r0 = r0/N
r1 = r1/N

%% Problem #3 - Chen 6.8

A = [-1 4 ; 4 -1];
B = [1 ; 1];
C = [1 1];
D = [0];
I = eye(2);

syms s;

g_s = (C * (inv((s*I) - A)) * B) + D;

pretty(g_s);

%% Problem #4 - Chen 6.15

clear all; close all; clc;

A = [1 1 0 0 0; 0 1 0 0 0; 0 0 1 1 0; 0 0 0 1 0; 0 0 0 0 1];

syms b11; syms b12;
syms b21; syms b22;
syms b31; syms b32;
syms b41; syms b42;
syms b51; syms b52;

B = [b11 b12; b21 b22; b31 b32; b41 b42; b51 b52];

syms c11; syms c12; syms c13; syms c14; syms c15;
syms c21; syms c22; syms c23; syms c24; syms c25;
syms c31; syms c32; syms c33; syms c34; syms c35;

C = [c11 c12 c13 c14 c15; c21 c22 c23 c24 c25; c31 c32 c33 c34 c35];

Qr = [B A*B A^2*B A^3*B A^4*B]

r = rank(Qr)

Qo = [C; C*A; C*A^2; C*A^3; C*A^4]

c = rank(Qo)