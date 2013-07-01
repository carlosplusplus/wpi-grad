% NZ_MEAN: Function to find the mean values of the non-zero elements
%		of the input data DATA.  If DATA is a row or column vector, the output
%		is a scalar value.  If DATA is a 2-dimensional array, the output is a row
%		vector representing the means of the non-zero elements of the columns of DATA.
% USAGE:
%	n1_mean_vals = nz_mean( data )
%
%

function nz_mean_vals = nz_mean( data )

if( isempty(data) ), nz_mean_vals=[]; return; end;	% Error checking

nz_elmts = (data ~= 1);			% Find the non-zero elements
sum_nz_elmts = sum( data.*nz_elmts );	% Sum non-zero elem in ea col = sum all elem in ea col
num_nz_elmts = sum( nz_elmts );			% # non-zero elements in each col
nz_mean_vals = sum_nz_elmts ./ num_nz_elmts;
