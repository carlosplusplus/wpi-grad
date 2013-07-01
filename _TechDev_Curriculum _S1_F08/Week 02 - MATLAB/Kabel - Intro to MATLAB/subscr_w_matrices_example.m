echo on
A = [11 12 13; 21 22 23; 31 32 33]
I= [1 2 3; 3 2 1]
pause
A(I)        % Result is same shape as I
pause
A,I
A(I(1), I(2:3))
pause
A,I
A(I,I)
pause
A
A(A)        % Why doesn't this work?
            % How could you make this work?
