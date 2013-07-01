echo on
a = [1 2 3 4 5 6]
b=a; b(2)=30

if( a==b ), disp('a equals b'),end;
% a is clearly not equal to b

pause

if( a~=b ), disp('a differs from b'),
else, disp('NO difference detected' ), end;
% This logic still cannot detect a differs from b
pause

if( any(a~=b) ), disp('a differs from b'),
else, disp('NO difference detected' ),end;
% But now This CAN detected differences

pause

% Here's why:
test= a~=b
% To output TRUE if statement requires ALL values to be TRUE
pause

test= any(a~=b)
% This will output TRUE when tested with if statement
pause

% This code still works (as it should):
if(~isequal(a,b)), disp('a differs from b'),end;
