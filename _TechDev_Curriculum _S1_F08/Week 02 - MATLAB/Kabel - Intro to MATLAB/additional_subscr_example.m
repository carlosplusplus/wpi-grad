% additional_subscr_example.m
echo on;
a = [11 12 13 14; ...
     21 22 23 24; ...
     31 32 33 34];
% some fun with a:

a(2,:)
pause;

a
a(:,4)
pause

a
a(2:3, 3:4)
pause

a
a([1,3],[2,4])
pause

% This gives the same result:
I=[2,3],   J=[2,4]
a
a(I,J)
pause

% Accessing elements as a vector:
a(:)
pause
a(:).'
pause

% Matrix multiplication deconstructed
disp(a)
b = [3;4;5;6]
c = zeros(3,1);
for(irow=1:3 )
    c(irow)=a(irow,:)*b;
end;
disp(c)
disp(a*b)
