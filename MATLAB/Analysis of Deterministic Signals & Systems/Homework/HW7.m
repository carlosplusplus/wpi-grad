% Carlos Lazo
% ECE504
% Homework #7

%% Problem #1

clear all; close all; clc;

% Initialize symbolic variables and all respective matrices for the problem.

syms a;
syms s;

% Compute the transfer function, g_s:

g_s = (a * exp(-1*s)) / (1 + (a * exp(-1*s)));

display ('The transfer function for HW #7, Problem 1 is:');
display (' ');

pretty(g_s);

% ******************
% ***** OUTPUT *****
% ******************
%
% The transfer function for HW #7, Problem 1 is:
%  
%  
%                                    a exp(-s)
%                                  -------------
%                                  1 + a exp(-s)

%% Problem #3

clear all; close all; clc;

% Initialize symbolic variable and all respective matrices for the problem.

syms s;

A = [1/2 1 0; 0 -1 0; 0 0 -1];
B = [0; 1; 0];
C = [0 1 1];
D = [0];

% Compute the transfer function, g_s:

g_s = (C * (inv(s*eye(3) - A)) * B) + D;

display ('The transfer function for HW #7, Problem 3 is:');
display (' ');

pretty(g_s);

% ******************
% ***** OUTPUT *****
% ******************
%
% The transfer function for HW #7, Problem 3 is:
%  
%  
%                                        1
%                                      -----
%                                      s + 1

%% Problem #4

clear all; close all; clc;

% Initialize variables and all respective matrices for the problem.

syms b1;
syms b2;

A = [1 -1 ; -1 1];
B = [b1 ; b2];

% Build the state reachability matrix, Qr:

Qr = [B A*B (A^2)*B];

display ('The reachability matrix for HW #7, Problem 4 is:');
display (' ');

pretty(Qr);

% ******************
% ***** OUTPUT *****
% ******************
%
% The reachability matrix for HW #7, Problem 4 is:
%  
%  
%                        [b1    b1 - b2     2 b1 - 2 b2 ]
%                        [                              ]
%                        [b2    -b1 + b2    -2 b1 + 2 b2]

%% Problem #5

clear all; close all; clc;

% Initialize variables and all respective matrices for the problem.

syms c1;
syms c2;

A = [1 -1 ; -1 1];
C = [c1 c2];

% Build the state reachability matrix, Qr:

Qo = [C; C*A; C*(A^2)];

display ('The observability matrix for HW #7, Problem 5 is:');
display (' ');

pretty(Qo);

% ******************
% ***** OUTPUT *****
% ******************
%
% The observability matrix for HW #7, Problem 5 is:
%  
%  
%                          [    c1              c2     ]
%                          [                           ]
%                          [  c1 - c2        -c1 + c2  ]
%                          [                           ]
%                          [2 c1 - 2 c2    -2 c1 + 2 c2]