echo on;       % three_dim_example.m
a=[1 2 3; 4 5 6];
b=cat(3, a,a-10,a-20);
b
pause;
abs(b)
pause;
sum(b)
sum(b,1)
pause;
sum(b,2)
pause;
sum(b,3)
pause;
% Permuting matrix:
b
permute(b, [3,1,2] )

