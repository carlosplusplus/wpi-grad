echo on
z= zeros(5,5)   % Create 5X5 matrix
z(:) = 1:25     % Fill matrix
pause           % Wait for a signal
w=[1 3 5 7 9]
z(4,:)=w        % Insert w into row 4 of z
pause
z(:) = 5        % Fill z with 5's
v(:) = 5        % Why doesn't this work?
echo off
