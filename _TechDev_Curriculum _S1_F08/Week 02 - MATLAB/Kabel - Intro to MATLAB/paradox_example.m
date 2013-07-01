echo on
a = [1 2 3; 4 5 6]
b=a; b(2)=30

if( a==b ), disp('a equals b'),end;
% a is clearly not equal to b

pause

if( a~=b ), disp('a differs from b'),
else, disp('NO difference detected' ), end;
% This logic cannot detect a differs from b
pause

if( any(a~=b) ), disp('a differs from b'),
else, disp('NO difference detected' ),end;
% This doesn't help either

pause

% Here's why:
test= a~=b
if(test)
   disp('All values of test are 1')
else
   disp('One or more values of test are 0')
end;
% To output TRUE, the "if" statement requires ALL values to be TRUE
pause

test= any(a~=b)
% Note how the "any" statement works on columns independently
if(test)
   disp('All values of test are 1')
else
   disp('One or more values of test are 0')
end;
% To output TRUE if statement requires ALL values to be TRUE
pause

% This code resolves problem:
test= any(a(:)~=b(:))
% Now the "any" works on all the elements (arranged in a single column)
if(test)
   disp('All values of test are 1')
else
   disp('One or more values of test are 0')
end;
% To output TRUE if statement requires ALL values to be TRUE
pause



% This code also resolves the problem:
% (Maybe more elegantly !!!!!!)
if(~isequal(a,b)), disp('a differs from b'),end;

pause

%When a and b are floating point values try this:
if( find(abs(a-b) > 1e-6) ), disp('a differs from b'),end;
