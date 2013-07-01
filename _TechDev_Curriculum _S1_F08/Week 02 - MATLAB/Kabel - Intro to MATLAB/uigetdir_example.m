% uigetdir_example.m
dir_name = uigetdir( pwd, 'Pick a directory' );
% Alternate call: dir_name = uigetdir( '', 'Pick a directory' );
disp( ['Picked directory ', dir_name] )
