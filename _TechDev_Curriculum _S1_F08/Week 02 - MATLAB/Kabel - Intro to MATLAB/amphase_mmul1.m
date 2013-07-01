% AMPHASE_MMUL1: Matrix multiply with a twist: the first inpt array is a magnitude
%		(in dB), and the second input array is a phase (in radians).
%		This version uses all for loops and no preallocation.
%
% USAGE: c = amphase_mmul1( a, b )
%	where a and b are the arrays to be multiplied.  They have the form given in the
%	preceding paragraphs.  The output c is the matrix product, according to the formula:
%				c = 10^(a/20) * exp(j*b)
%
%

function c = amphase_mmul1( a, b )

[nrows, nmul] = size(a);
[checkval, ncols] = size(b);

if( nmul ~= checkval )		% Make sure multiplication is legal
   error( 'a and b are sized wrong' );
end;

for( icol=1:ncols )
   for( irow=1:nrows )
      c(irow,icol)=0;
      for( imul=1:nmul )
         c(irow, icol) = c(irow,icol) + ...
            10^(0.05*a(irow,imul)) * exp(j*b(imul,icol));
      end;
   end;
end;

