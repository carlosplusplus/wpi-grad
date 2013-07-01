% NORMALIZE_TRICKY:  Take data array DAT and normalize each column such that the
%		squares of the column elements sum to 1.
% THIS VERSION USES A TRICKY METHOD THAT RELIES ON MATRIX MULT RULES
%
% USAGE: ndat = normalize_tricky( dat )
%
%

function ndat = normalize_tricky( dat )

sumsq = sqrt(sum(abs(dat).^2));
normalize_term = diag( 1./sumsq );
ndat = dat * normalize_term;
