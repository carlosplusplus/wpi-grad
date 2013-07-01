% NORMALIZE1:  Take data array DAT and normalize each column such that the
%		squares of the column elements sum to 1.
% THIS VERSION USES ALL FOR LOOPS (BUT IT DOES PREALLOCATE FOR SPEED)
%
% USAGE: ndat = normalize1( dat )
%
%

function ndat = normalize1( dat )

[nrows,ncols] = size(dat);
ndat = dat;						% Preallocate to speed up
sumsq = sqrt(sum(abs(dat).^2));

for(icol=1:ncols)
   for(irow=1:nrows)
      ndat(irow,icol) = ndat(irow,icol) / sumsq(icol);
   end;
end;
