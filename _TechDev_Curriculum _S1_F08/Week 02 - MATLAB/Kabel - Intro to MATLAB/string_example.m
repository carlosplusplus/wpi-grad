echo on
%creating strings

str = 'abcdefg hj'
pause;

% Two-dimensional strings
ms = ['abc';'def';'ghj']
size(ms)
pause;

% Manipulation--Addressing
str		% Original

str(1:3)
pause

str(4:end)
pause

str(1:3:end)
pause

ms    % Original

ms(2,:)
pause

ms(:,3)
pause

%Building up strings
str0 = 'Some letters of the alphabet = ';
tstr = [str0, str]

% Why not [str0;str]  ????
pause

% Using strings in functions
disp( ['An interesting string: ', str] )
pause
echo off
