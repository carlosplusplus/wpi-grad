% NORMALIZE3:  Take data array DAT and normalize each column such that the
%		squares of the column elements sum to 1.
% THIS VERSION USES COMPLETE VECTORIZATION
%
% USAGE: ndat = normalize3( dat )
%
%

function ndat = normalize3( dat )

[nrows,ncols] = size(dat);
sumsq = sqrt(sum(abs(dat).^2));
denom = repmat( 1./sumsq, nrows, 1);
ndat = dat .* denom;
