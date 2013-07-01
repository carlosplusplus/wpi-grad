% ABS_VAL: Return the absolute value of an input matrix
%
% USAGE:  absout = abs_val( inmat )
% WHERE: inmat and absout are arrays
%
%

function absout = abs_val( inmat )
absout = inmat;
 % absout(absout<0) = -absout(absout<0);
%Note: The following code is equivalent and may be easier
%   to read:
negvals = find(absout<0);
absout(negvals) = -absout(negvals);
