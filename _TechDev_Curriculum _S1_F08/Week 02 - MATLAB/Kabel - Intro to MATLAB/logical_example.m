echo on
a=[1 0 3; -1 1 0]
b=[2 0 -1; 3 3 -3]
c=0

w = a>=b
x = a>=c
pause

disp( a );
disp( b);
y = a&b
z = a&c
pause

disp( a );
disp( b);
t = a|b
u = a|c
pause

disp(a);
v = ~a
echo off
