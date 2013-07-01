function corr = mf( x, h )
corr = conv(x,h(end:-1:1))./sqrt( (x'*x) .* (h'*h) );
return;
