% get_file_names.m
echo on;
dd = dir
pause

namelist = {dd.name};
pause
namelist
pause;

namelist(1)     % A cell
pause

namelist{1}     % We've "dereferenced" the contents of the cell--which is a string

% A final question: What if we used syntax:
% namelist = dd.name
% How about:
% namelist = [dd.name]
echo off
