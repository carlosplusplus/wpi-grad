% MY_SIGN2: A second example of a Matlab function which returns the sign of a number
%   coded in the form of +1,-1, or 0 (if the number if identically 0).
%   This function should work identically to the MathWorks-supplied function SIGN
%   This is more compact than my_sign
%
% USAGE:
%   out = my_sign2( in )
%
% WHERE:
%   in = A matrix of numerical values
%   out = A matrix of the coded sign function, with the same size as in
%
%

function out = my_sign2( in )
out = ones( size( in ));
out(in<0) = -1;
out(in==0) = 0;
return;
