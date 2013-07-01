echo on;            % struct_example.m
clear all
a = struct('first', [3,2], 'second', 'ha ha');
a
a.first
a.second
pause;
a.third = cell(2,2)
pause;
a(2).second = 666
a(2)
a.second
pause;
% Copying the whole structure is allowed:
b = a(2)
pause
% Another way to create a structure
clear all;
b.first = 'Four score and seven years ago'

