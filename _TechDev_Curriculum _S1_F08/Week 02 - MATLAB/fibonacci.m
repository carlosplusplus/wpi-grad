%% Carlos Lazo
%  ELDP Class of 2011
%  Introduction to MATLAB Assignment
%  Due: 9/15/08 @ 8:30am

function f = fibonacci(n) 

% If n = 1 or n = 2, recursively return 1 as a value and end recursion.

if(n==1)
    f = 1;
    return;
end

if(n==2)
    f = 1;
    return;
end

% Recursive statement called until fibonacci(n-1) or fibonacci(n-2) is 1/2.

f = fibonacci(n-1) + fibonacci(n-2);