echo on
z = [ 9 8 7; 6 5 4; 3 2 1]
flip_z = [z(3,:), z(2,:), z(1,:)]       % (Doesn't really flip matrix)
pause
flip_z = z(end:-1:1,:)      % An easire and more general method
echo off
