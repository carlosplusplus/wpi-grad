echo on
clear all
A = [1 2 3; 4 5 6; 7 8 9]
b = [3;2;1]

% 3 Unknowns with 3 equations
x = A\b
pause;

% Fewer equations than unknowns (4 Unknowns with 3 equations)
A(:,4)=[10;23;29]
x = A\b
pause;

% More equations than unknowns (2 Unknowns with 3 equations)
A(:,3:4)=[]
x = A\b
%echo off
