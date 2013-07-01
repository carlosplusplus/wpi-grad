% MY_SIGN: An example of a Matlab function which returns the sign of a number
%   coded in the form of +1,-1, or 0 (if the number if identically 0).
%   This function should work identically to the MathWorks-supplied function SIGN
%
% USAGE:
%   out = my_sign( in )
%
% WHERE:
%   in = A matrix of numerical values
%   out = A matrix of the coded sign function, with the same size as in
%
%

function out = my_sign( in )
out = zeros( size( in ));

for( i=1:numel(in) )
    if( in(i) > 0 )
        out(i) = 1;
    elseif( in(i) < 0 )
        out(i) = -1;
    else
        out(i) = 0;
    end;  disp(out)
end;
return;
