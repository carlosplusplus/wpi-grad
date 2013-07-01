try
echo on;
a=[1 2 3; 4 5 6]
pause
b=[6 5 4; 3 2 1]
pause
c=a+b   % Matrix/Matrix
pause
d=a-a
pause
e=(a+c)'
pause
f=a-5
pause
x=[10 11 12]
y=[10; 11; 12]
pause
z=x+y   % Error
catch
lasterr
pause
z=x+y'
pause
zt = x'+y
pause
w=x+100
end
