% NORMALIZE2:  Take data array DAT and normalize each column such that the
%		squares of the column elements sum to 1.
% THIS VERSION USES PARTIAL VECTORIZATION (BUT IT DOES PREALLOCATE FOR SPEED)
%
% USAGE: ndat = normalize2( dat )
%
%

function ndat = normalize2( dat )

[nrows,ncols] = size(dat);
ndat = dat;						% Preallocate to speed up
sumsq = sqrt(sum(abs(dat).^2));

for(icol=1:ncols)
   ndat(:,icol) = ndat(:,icol) / sumsq(icol);
end;
