% if_while_precautions.m
disp( 'Goal is to halve all array elements repeatedly,' )
disp( 'until all are less than one')
echo on;
a=100*rand(4,5)+1

pause

while(a>1)
    a=a./2
    pause;
end;
echo off
disp( 'The loops only goes while ALL elements of a are >1')

pause
disp( 'The following revision fixes the fault.')
disp( '     Note that matrix a is addressed as a long column vector')
pause
echo on
% This revision fixes the fault
while(any(a(:)>1))
    a=a./2
    pause;
end;
echo off;
disp( 'Now it loops while ANY elements of a are >1' )


