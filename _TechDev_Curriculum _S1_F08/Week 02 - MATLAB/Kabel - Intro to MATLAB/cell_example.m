echo on;         % cell_example.m
clear all
a=cell(2,2)
a{1} = [2,3]
a{2} = a{1}.'
a(3)=a(1)
a{4}=['the last cell']
pause;
% Another way to define a cell:
z = {[1 3],eye(4),'jingle bells'}
pause
% Accessing contents of cells
a{2}
pause;
a{:}
pause;
iscell(a{1})
iscell(a(1))
pause;
b=a
pause;
b{2,1} = a
pause;
% Accessing sub-cells:
b{2,1}{1,1}
