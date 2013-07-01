echo on
clear all
a=[1 2 3 4; 5 6 7 8; 9 10 11 12]
pause
b=ones(4,3)
pause
c = a.*a   % Element by element multiplication
pause
d=a*b   % Matrix multiplication
pause
e=a./b'
pause
f= a' ./ b
pause
g=a.^2
pause
j=a.^(a/10)
pause
h=[1 2 3; 4 5 6; 7 8 9]
pause
j=h^2       % Why not a^2 ?

