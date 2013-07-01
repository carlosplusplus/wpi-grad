echo on;			% logical_subscripts_example.m
a = [1 2 3; 4 5 6]
z = (a>=4),  a(z)=0

pause;

% Exactly equivalent notation
a = [1 2 3; 4 5 6]
a(a>=4) = 0
