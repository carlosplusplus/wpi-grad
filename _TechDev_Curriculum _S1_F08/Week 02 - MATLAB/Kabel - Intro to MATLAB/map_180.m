% MAP_180: Map all input angles (in degrees) into the range (-180,+180]
%
% USAGE: out = map_180( in )
% WHERE: in and out are arrays of angles in degrees
%
%

function out = map_180( in )

out = mod( in, 360 );		% Start by mapping input to [0,360)

hi_indices = find( out > 180.0 );		% Find angles > 180 deg.
out( hi_indices ) = out( hi_indices ) - 360.0;
return;
